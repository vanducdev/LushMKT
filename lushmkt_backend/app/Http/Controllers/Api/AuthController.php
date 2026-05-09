<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'balance' => 0.00, // Initial balance
            'role' => 'user',
            'api_key' => 'lush_mkt_' . Str::random(32),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Đăng ký tài khoản thành công.',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ], 201);
    }

    /**
     * Login user and issue API Token
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'Thông tin đăng nhập không chính xác.'], 401);
        }

        // Revoke previous tokens if any
        $user->tokens()->delete();

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Đăng nhập thành công.',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user
        ]);
    }

    /**
     * Get authenticated user profile
     */
    public function profile(Request $request)
    {
        return response()->json($request->user());
    }

    /**
     * Update user avatar
     */
    public function updateAvatar(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'avatar' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user = $request->user();

        if ($request->hasFile('avatar')) {
            $imageName = time() . '.' . $request->avatar->extension();
            $request->avatar->move(public_path('avatars'), $imageName);
            
            $user->avatar = '/avatars/' . $imageName;
            $user->save();
        }

        return response()->json([
            'message' => 'Cập nhật ảnh đại diện thành công.',
            'avatar_url' => $user->avatar
        ]);
    }

    /**
     * Get user notifications
     */
    public function getNotifications(Request $request)
    {
        // Mock notifications for instant visual loading
        $notifications = [
            [
                'id' => 1,
                'title' => 'Khuyến mãi nạp thẻ',
                'content' => 'Hệ thống đang khuyến mãi 10% giá trị nạp tiền qua tài khoản VietQR ngân hàng tự động.',
                'created_at' => now()->subHours(2)->toIso8601String(),
            ],
            [
                'id' => 2,
                'title' => 'Tăng tương tác thành công',
                'content' => 'Đơn hàng buff 1000 Like Facebook bài viết của bạn đã được hoàn thành.',
                'created_at' => now()->subDays(1)->toIso8601String(),
            ]
        ];

        return response()->json($notifications);
    }

    /**
     * Logout user
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Đăng xuất tài khoản thành công.']);
    }
}
