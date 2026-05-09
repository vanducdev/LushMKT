import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/service_order_view.dart';
import '../profile/profile_view.dart';
import '../products/product_purchase_view.dart';
import '../payment/deposit_view.dart';
import 'notifications_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Mock list of banners
  final List<Map<String, String>> _banners = [
    {
      'title': 'KHUYẾN MÃI NẠP TIỀN 10%',
      'subtitle': 'Tự động duyệt 24/7 qua VietQR',
      'image': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=600&q=80',
    },
    {
      'title': 'DỊCH VỤ FACEBOOK GIÁ CỰC RẺ',
      'subtitle': 'Buff Like, Follow bảo hành lên tới 30 ngày',
      'image': 'https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?auto=format&fit=crop&w=600&q=80',
    }
  ];

  // Mock list of MMO products
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'VIA Facebook Cổ (Kháng 2FA, 500-1000 Friends)',
      'price': 45000,
      'stock': 124,
      'warranty': 'Bao login 24h',
      'category': 'VIA Facebook',
    },
    {
      'name': 'Gmail Ngoại Cổ (Đã Ngâm 1 Năm, Bao Spam)',
      'price': 8500,
      'stock': 430,
      'warranty': '1 đổi 1 nếu lỗi',
      'category': 'Gmail',
    },
    {
      'name': 'Proxy IPv4 Việt Nam (Hạn dùng 30 ngày)',
      'price': 22000,
      'stock': 99,
      'warranty': 'Bảo hành mạng 24/7',
      'category': 'Proxy',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 3
          ? const ProfileView()
          : Stack(
              children: [
          // Cyber space dark background
          Container(
            color: const Color(0xFF0D0F14),
          ),
          // Glow decorations
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.12),
                blurRadius: 90,
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7000FF).withOpacity(0.08),
                blurRadius: 100,
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Header (Premium MMO style)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF00E5FF), width: 1.5),
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundColor: Color(0xFF161B22),
                                child: Text('L', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Xin chào,',
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                                Text(
                                  'LushDeveloper 🚀',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Realtime notifications count badge
                        GestureDetector(
                          onTap: () => Get.to(() => const NotificationsView()),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161B22),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: const Icon(Icons.notifications_none_outlined, color: Colors.white, size: 24),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF2D55),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // 2. Glowing User Wallet Card (Glassmorphism)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF161B22).withOpacity(0.9),
                            const Color(0xFF0D0F14).withOpacity(0.8),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF00E5FF).withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withOpacity(0.05),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF00E5FF), size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Số dư tài khoản'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 11,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '2,450,000 đ',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Premium neon deposit button
                          ElevatedButton.icon(
                            onPressed: () => Get.to(() => const DepositView()),
                            icon: const Icon(Icons.add_circle_outline, color: Colors.black, size: 18),
                            label: const Text(
                              'NẠP TIỀN',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E5FF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              elevation: 5,
                              shadowColor: const Color(0xFF00E5FF).withOpacity(0.3),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 25)),

                // 3. Fast Service Category Grid
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'DỊCH VỤ FACEBOOK HOT',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Color(0xFF00E5FF)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 110,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(() => const ServiceOrderView(serviceName: 'Tăng Like Facebook', basePrice: 4.0)),
                              child: _buildFastCategoryItem(Icons.thumb_up_alt_outlined, 'Tăng Like FB', 'Chỉ từ 4đ/like'),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const ServiceOrderView(serviceName: 'Tăng Follow Facebook', basePrice: 12.0)),
                              child: _buildFastCategoryItem(Icons.person_add_alt_1_outlined, 'Tăng Follow', 'Tài khoản thật'),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const ServiceOrderView(serviceName: 'Buff Comment Facebook', basePrice: 8.0)),
                              child: _buildFastCategoryItem(Icons.comment_outlined, 'Buff Comment', 'Nội dung tự chọn'),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const ServiceOrderView(serviceName: 'Tăng Share Facebook', basePrice: 15.0)),
                              child: _buildFastCategoryItem(Icons.share_outlined, 'Share Bài Viết', 'Lên group lớn'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 25)),

                // 4. Products List (VIA, Gmail, Proxy)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'KHO TÀI NGUYÊN MMO',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Color(0xFF00E5FF)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Xem tất cả', style: TextStyle(color: Color(0xFF7000FF), fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = _products[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161B22),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.04)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D0F14),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  product['category'] == 'VIA Facebook'
                                      ? Icons.facebook
                                      : product['category'] == 'Gmail'
                                          ? Icons.email_outlined
                                          : Icons.vpn_lock,
                                  color: const Color(0xFF00E5FF),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF7000FF).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Kho: ${product['stock']}',
                                            style: const TextStyle(color: Color(0xFF7000FF), fontSize: 10, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          product['warranty'],
                                          style: const TextStyle(color: Colors.grey, fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${product['price']} đ',
                                          style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.to(() => ProductPurchaseView(
                                              productName: product['name'],
                                              price: (product['price'] as int).toDouble(),
                                              stock: product['stock'],
                                              category: product['category'],
                                              warranty: product['warranty'],
                                            ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF161B22),
                                            foregroundColor: const Color(0xFF00E5FF),
                                            side: const BorderSide(color: Color(0xFF00E5FF)),
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          child: const Text('MUA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: _products.length,
                    ),
                  ),
                ),
                
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
      
      // Bottom navigation bar with glassmorphism style
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.04))),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0D0F14),
          selectedItemColor: const Color(0xFF00E5FF),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.flash_on_outlined), label: 'Dịch vụ FB'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Mua Acc'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Cá nhân'),
          ],
        ),
      ),
    );
  }

  Widget _buildFastCategoryItem(IconData icon, String title, String subtitle) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF00E5FF), size: 24),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
