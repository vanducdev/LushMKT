<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class LushMktSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Seed Users (Admin & Test User)
        DB::table('users')->insert([
            [
                'name' => 'Lush Admin',
                'email' => 'admin@lushmkt.com',
                'password' => Hash::make('admin123'),
                'balance' => 99999999.00,
                'role' => 'admin',
                'api_key' => 'lush_mkt_admin_key_99999',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Lush Tester',
                'email' => 'user@lushmkt.com',
                'password' => Hash::make('user123'),
                'balance' => 2450000.00,
                'role' => 'user',
                'api_key' => 'lush_mkt_live_key_918237198a9d8213bc89a',
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // 2. Seed Categories
        DB::table('categories')->insert([
            [
                'id' => 1,
                'name' => 'Facebook Services',
                'slug' => 'facebook-services',
                'icon' => 'facebook',
                'type' => 'service',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'name' => 'Tài Khoản Gmail',
                'slug' => 'tai-khoan-gmail',
                'icon' => 'email',
                'type' => 'product',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'name' => 'VIA Facebook',
                'slug' => 'via-facebook',
                'icon' => 'face',
                'type' => 'product',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'name' => 'Proxy Chất Lượng Cao',
                'slug' => 'proxy-high-quality',
                'icon' => 'vpn_lock',
                'type' => 'product',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // 3. Seed Services (FB Like, Follow, Comment, Share)
        DB::table('services')->insert([
            [
                'category_id' => 1,
                'name' => 'Tăng Like Facebook Bài Viết',
                'code' => 'fb_like_speed',
                'price_per_one' => 4.00,
                'min_quantity' => 100,
                'max_quantity' => 50000,
                'description' => 'Tốc độ lên nhanh, không tụt tụt, nick thật hoạt động.',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'category_id' => 1,
                'name' => 'Tăng Follow Trang Cá Nhân',
                'code' => 'fb_follow_vip',
                'price_per_one' => 12.00,
                'min_quantity' => 500,
                'max_quantity' => 100000,
                'description' => 'Sub thật chất lượng cao có bảo hành tụt 30 ngày.',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'category_id' => 1,
                'name' => 'Buff Comment Facebook Động',
                'code' => 'fb_comment_custom',
                'price_per_one' => 8.00,
                'min_quantity' => 10,
                'max_quantity' => 5000,
                'description' => 'Tự soạn nội dung viết mỗi bình luận một dòng mới.',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'category_id' => 1,
                'name' => 'Tăng Share Bài Viết Nhóm Lớn',
                'code' => 'fb_share_group',
                'price_per_one' => 15.00,
                'min_quantity' => 50,
                'max_quantity' => 20000,
                'description' => 'Share về tường hoặc lên các hội nhóm có tương tác sẵn.',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // 4. Seed Products
        DB::table('products')->insert([
            [
                'category_id' => 3,
                'name' => 'VIA Facebook Cổ (Kháng 2FA, 500-1000 Friends)',
                'price' => 45000.00,
                'stock_quantity' => 124,
                'description' => 'Tài khoản VIA hoạt động trên 2 năm, đã kháng hạn chế quảng cáo, đầy đủ mã 2FA đăng nhập.',
                'warranty_policy' => 'Bao login lần đầu trong vòng 24h từ lúc mua.',
                'rating' => 4.9,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'category_id' => 2,
                'name' => 'Gmail Ngoại Cổ (Đã Ngâm 1 Năm, Bao Spam)',
                'price' => 8500.00,
                'stock_quantity' => 430,
                'description' => 'Gmail lập năm 2022-2023, đã ngâm thiết bị sạch, bao login mọi IP ngoại.',
                'warranty_policy' => '1 đổi 1 nếu lỗi mật khẩu hoặc sai định dạng tài khoản.',
                'rating' => 4.8,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'category_id' => 4,
                'name' => 'Proxy IPv4 Việt Nam (Hạn dùng 30 ngày)',
                'price' => 22000.00,
                'stock_quantity' => 99,
                'description' => 'Proxy riêng tư cá nhân IPv4, giao thức HTTP/SOCKS5 tốc độ ổn định 100Mbps.',
                'warranty_policy' => 'Hỗ trợ đổi IP mới miễn phí nếu bị die mạng trong 3 ngày đầu.',
                'rating' => 5.0,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // 5. Seed Banners
        DB::table('banners')->insert([
            [
                'title' => 'KHUYẾN MÃI NẠP TIỀN 10%',
                'image_path' => 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=600&q=80',
                'link_url' => '/deposit',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'DỊCH VỤ FACEBOOK GIÁ CỰC RẺ',
                'image_path' => 'https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?auto=format&fit=crop&w=600&q=80',
                'link_url' => '/services',
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);

        // 6. Seed Settings
        DB::table('settings')->insert([
            ['key' => 'brand_name', 'value' => 'LushMKT', 'created_at' => now(), 'updated_at' => now()],
            ['key' => 'telegram_support', 'value' => 'https://t.me/lush_support', 'created_at' => now(), 'updated_at' => now()],
            ['key' => 'vietqr_deposit_bonus', 'value' => '10', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
