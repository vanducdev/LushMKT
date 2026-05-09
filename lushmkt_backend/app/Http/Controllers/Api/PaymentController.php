<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Transaction;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class PaymentController extends Controller
{
    /**
     * Generate VietQR specifications for deposit
     */
    public function createVietQR(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'amount' => 'required|numeric|min:10000',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = $request->user();
        $transactionCode = 'LUSH' . rand(10000, 99999);

        // Record a pending transaction
        $transaction = Transaction::create([
            'user_id' => $user->id,
            'transaction_code' => $transactionCode,
            'type' => 'deposit',
            'amount' => $request->amount,
            'payment_method' => 'bank',
            'status' => 'pending',
            'description' => "Nạp tiền tự động qua VietQR tài khoản LUSH {$transactionCode}",
        ]);

        // Generate VietQR dynamic payload parameters
        $bankBin = "970422"; // MB Bank BIN
        $accountNo = "1903561728394";
        $amount = $request->amount;
        
        // standard VietQR Link format
        $qrUrl = "https://img.vietqr.io/image/MB-{$accountNo}-compact2.png?amount={$amount}&addInfo=" . urlencode($transactionCode) . "&accountName=" . urlencode("CONG TY LUSHMKT");

        return response()->json([
            'message' => 'Tạo yêu cầu nạp tiền thành công.',
            'transaction_code' => $transactionCode,
            'amount' => $amount,
            'note' => $transactionCode,
            'qr_url' => $qrUrl,
            'transaction' => $transaction
        ]);
    }

    /**
     * Retrieve user transaction history
     */
    public function transactions(Request $request)
    {
        $transactions = Transaction::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json($transactions);
    }
}
