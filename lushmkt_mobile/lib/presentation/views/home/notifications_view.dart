import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/social_controller.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final SettingsController _settingsController = Get.find<SettingsController>();
  final SocialController _socialController = Get.find<SocialController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = _settingsController.isDarkMode.value;
      final Color textColor = isDark ? Colors.white : Colors.black87;
      final Color cardBg = isDark ? const Color(0xFF161B22) : Colors.white;
      final list = _socialController.notifications;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: Text(
            'THÔNG BÁO HỘP THƯ',
            style: _settingsController.getTextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          backgroundColor: isDark ? const Color(0xFF0D0F14) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
            onPressed: () => Get.back(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _socialController.markAllAsRead();
                Get.snackbar('Thành Công', 'Đã đánh dấu tất cả là đã đọc.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
              },
              child: Text('ĐỌC TẤT CẢ', style: _settingsController.getTextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF))),
            )
          ],
        ),
        body: list.isEmpty
            ? Center(
                child: Text('Không có thông báo nào.', style: _settingsController.getTextStyle(fontSize: 13, color: Colors.grey)),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final notif = list[index];
                  IconData icon = Icons.info_outline;
                  Color iconColor = Colors.blueAccent;

                  if (notif.type == 'deposit') {
                    icon = Icons.account_balance_wallet_outlined;
                    iconColor = Colors.green;
                  } else if (notif.type == 'post') {
                    icon = Icons.post_add_outlined;
                    iconColor = const Color(0xFF00E5FF);
                  } else if (notif.type == 'like') {
                    icon = Icons.favorite_outline_rounded;
                    iconColor = Colors.redAccent;
                  }

                  return Card(
                    color: cardBg,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: notif.isRead ? Colors.transparent : const Color(0xFF00E5FF).withOpacity(0.15)),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconColor.withOpacity(0.12),
                        child: Icon(icon, color: iconColor, size: 20),
                      ),
                      title: Text(notif.title, style: _settingsController.getTextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor)),
                      subtitle: Text(notif.body, style: _settingsController.getTextStyle(fontSize: 11, color: textColor.withOpacity(0.6))),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Vừa xong', style: _settingsController.getTextStyle(fontSize: 9, color: Colors.grey)),
                          const SizedBox(height: 4),
                          if (!notif.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                            )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          notif.isRead = true;
                        });
                      },
                    ),
                  );
                },
              ),
      );
    });
  }
}
