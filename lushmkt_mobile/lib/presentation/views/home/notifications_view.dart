import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  // Mock notifications matching the database/seeder data
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'title': 'Khuyến mãi nạp thẻ tự động 10%',
      'content': 'Hệ thống đang áp dụng chương trình khuyến mãi tặng thêm 10% giá trị nạp tiền qua tài khoản VietQR ngân hàng tự động MB Bank.',
      'type': 'promo',
      'is_read': false,
      'time': 'Vừa xong'
    },
    {
      'id': 2,
      'title': 'Đơn hàng buff hoàn thành',
      'content': 'Yêu cầu tăng 1000 Like Facebook bài viết của bạn đã được hệ thống phân phối hoàn thành 100%.',
      'type': 'order',
      'is_read': true,
      'time': '2 giờ trước'
    },
    {
      'id': 3,
      'title': 'Cập nhật hệ thống an toàn',
      'content': 'LushMKT đã hoàn thành bảo trì định kỳ cụm máy chủ Proxy IPv4 giúp cải thiện 50% băng thông tải dữ liệu.',
      'type': 'system',
      'is_read': true,
      'time': '1 ngày trước'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('THÔNG BÁO HỆ THỐNG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1)),
        backgroundColor: const Color(0xFF0D0F14),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF0D0F14)),
          
          SafeArea(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                IconData icon;
                Color iconColor;
                
                switch (notif['type']) {
                  case 'promo':
                    icon = Icons.star_outline_rounded;
                    iconColor = const Color(0xFF00E5FF);
                    break;
                  case 'order':
                    icon = Icons.check_circle_outline_rounded;
                    iconColor = Colors.green;
                    break;
                  default:
                    icon = Icons.info_outline;
                    iconColor = const Color(0xFF7000FF);
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: notif['is_read'] ? Colors.white.withOpacity(0.02) : const Color(0xFF00E5FF).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D0F14),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: iconColor, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  notif['time'],
                                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                                ),
                                if (!notif['is_read'])
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00E5FF),
                                      shape: BoxShape.circle,
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif['title'],
                              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notif['content'],
                              style: const TextStyle(color: Colors.grey, fontSize: 11, height: 1.4),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
