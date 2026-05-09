import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../auth/login_view.dart';
import 'tickets_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final String _apiKey = "lush_mkt_live_key_918237198a9d8213bc89a";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRANG CÁ NHÂN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
        backgroundColor: const Color(0xFF0D0F14),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF0D0F14)),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 1. Glowing Avatar & Level Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF00E5FF), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00E5FF).withOpacity(0.2),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 45,
                            backgroundColor: Color(0xFF161B22),
                            child: Text(
                              'L',
                              style: TextStyle(color: Color(0xFF00E5FF), fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'LushDeveloper 🚀',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00E5FF), Color(0xFF7000FF)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'VIP LEVEL 3',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 2. Personal API Key Box (High-End MMO Automation requirement)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'KHÓA TÍCH HỢP API CÁ NHÂN'.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF00E5FF), letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _apiKey,
                            style: const TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Color(0xFF00E5FF), size: 18),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _apiKey));
                            Get.snackbar(
                              'Đã sao chép',
                              'Đã sao chép khóa API cá nhân của bạn!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color(0xFF161B22),
                              colorText: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 3. User spendings & transactions summary
                  Row(
                    children: [
                      _buildSpendingCard('TỔNG CHI TIÊU', '12,450,000đ', Icons.payment, Colors.green),
                      const SizedBox(width: 16),
                      _buildSpendingCard('ĐƠN ĐÃ HOÀN THÀNH', '142 Đơn', Icons.assignment_turned_in, Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 4. Action List Tiles
                  _buildProfileTile(Icons.history, 'Lịch sử giao dịch & Nạp tiền', () {}),
                  _buildProfileTile(Icons.support_agent, 'Gửi yêu cầu hỗ trợ (Ticket)', () => Get.to(() => const TicketsView())),
                  _buildProfileTile(Icons.security, 'Thay đổi mật khẩu', () {}),
                  _buildProfileTile(Icons.info_outline, 'Điều khoản & Chính sách', () {}),
                  
                  const SizedBox(height: 30),

                  // 5. Modern Red Logout Button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFF2D55).withOpacity(0.5)),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.offAll(() => const LoginView());
                      },
                      icon: const Icon(Icons.logout, color: Color(0xFFFF2D55), size: 18),
                      label: const Text(
                        'ĐANG XUẤT TÀI KHOẢN',
                        style: TextStyle(color: Color(0xFFFF2D55), fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSpendingCard(String title, String val, IconData icon, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: col, size: 20),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String label, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00E5FF), size: 20),
        title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12),
        onTap: onTap,
      ),
    );
  }
}
