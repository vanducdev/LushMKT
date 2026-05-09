<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Service;
use App\Models\Product;
use App\Models\Order;
use App\Models\Transaction;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class OrderController extends Controller
{
    /**
     * Create service orders (e.g. Buff Like, Buff Follow)
     */
    public function createServiceOrder(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'service_id' => 'required|exists:services,id',
            'quantity' => 'required|integer',
            'target_link' => 'required|url',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = $request->user();
        $service = Service::find($request->service_id);

        if (!$service->is_active) {
            return response()->json(['error' => 'Dịch vụ này hiện đang bảo trì.'], 400);
        }

        if ($request->quantity < $service->min_quantity || $request->quantity > $service->max_quantity) {
            return response()->json([
                'error' => "Số lượng tối thiểu là {$service->min_quantity} và tối đa là {$service->max_quantity}."
            ], 400);
        }

        $totalPrice = $service->price_per_one * $request->quantity;

        // DB Transaction for race condition protection
        return DB::transaction(function () use ($user, $service, $request, $totalPrice) {
            // Lock user row for update
            $user = DB::table('users')->where('id', $user->id)->lockForUpdate()->first();

            if ($user->balance < $totalPrice) {
                return response()->json(['error' => 'Số dư tài khoản không đủ để thanh toán.'], 400);
            }

            // 1. Deduct user balance
            DB::table('users')->where('id', $user->id)->decrement('balance', $totalPrice);

            // 2. Create Order
            $order = Order::create([
                'user_id' => $user->id,
                'order_type' => 'service',
                'orderable_id' => $service->id,
                'quantity' => $request->quantity,
                'total_price' => $totalPrice,
                'status' => 'processing',
                'target_link' => $request->target_link,
            ]);

            // 3. Log Transaction
            Transaction::create([
                'user_id' => $user->id,
                'transaction_code' => 'PAY' . strtoupper(Str::random(10)),
                'type' => 'payment',
                'amount' => $totalPrice,
                'status' => 'success',
                'description' => "Thanh toán dịch vụ: {$service->name} (Số lượng: {$request->quantity})",
            ]);

            // Real-world: dispatch job to call Subgiare / Subviet API in background queues
            // DispatchServiceOrder::dispatch($order);

            return response()->json([
                'message' => 'Tạo đơn hàng dịch vụ thành công.',
                'order' => $order,
                'remaining_balance' => $user->balance - $totalPrice
            ]);
        });
    }

    /**
     * Create product purchases (e.g. VIA, Gmail) with automated stock delivery
     */
    public function createProductOrder(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = $request->user();
        $product = Product::find($request->product_id);

        if ($product->stock_quantity < $request->quantity) {
            return response()->json(['error' => 'Số lượng trong kho không đủ để cung cấp.'], 400);
        }

        $totalPrice = $product->price * $request->quantity;

        return DB::transaction(function () use ($user, $product, $request, $totalPrice) {
            // Lock user and product rows for update to prevent concurrent race conditions
            $user = DB::table('users')->where('id', $user->id)->lockForUpdate()->first();
            $productRef = DB::table('products')->where('id', $product->id)->lockForUpdate()->first();

            if ($user->balance < $totalPrice) {
                return response()->json(['error' => 'Số dư tài khoản không đủ để thanh toán.'], 400);
            }

            if ($productRef->stock_quantity < $request->quantity) {
                return response()->json(['error' => 'Kho hàng vừa hết, vui lòng thử lại sau.'], 400);
            }

            // 1. Deduct user balance & reduce product stock
            DB::table('users')->where('id', $user->id)->decrement('balance', $totalPrice);
            DB::table('products')->where('id', $product->id)->decrement('stock_quantity', $request->quantity);

            // Mock delivery of virtual accounts
            $deliveredAccounts = [];
            for ($i = 0; $i < $request->quantity; $i++) {
                $deliveredAccounts[] = "username" . rand(1000, 9999) . "|password" . Str::random(8) . "|2fa" . Str::random(16);
            }
            $deliveredData = implode("\n", $deliveredAccounts);

            // 2. Create Order
            $order = Order::create([
                'user_id' => $user->id,
                'order_type' => 'product',
                'orderable_id' => $product->id,
                'quantity' => $request->quantity,
                'total_price' => $totalPrice,
                'status' => 'completed',
                'response_data' => $deliveredData,
            ]);

            // 3. Log Transaction
            Transaction::create([
                'user_id' => $user->id,
                'transaction_code' => 'BUY' . strtoupper(Str::random(10)),
                'type' => 'payment',
                'amount' => $totalPrice,
                'status' => 'success',
                'description' => "Mua tài nguyên: {$product->name} (Số lượng: {$request->quantity})",
            ]);

            return response()->json([
                'message' => 'Mua tài nguyên thành công. Đã nhận hàng.',
                'order' => $order,
                'delivered_accounts' => $deliveredAccounts,
                'remaining_balance' => $user->balance - $totalPrice
            ]);
        });
    }

    /**
     * Get user history orders
     */
    public function history(Request $request)
    {
        $orders = Order::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json($orders);
    }
}
