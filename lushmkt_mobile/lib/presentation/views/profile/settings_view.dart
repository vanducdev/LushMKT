import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());

    return Obx(() {
      final isDark = settingsController.isDarkMode.value;
      final Color scaffoldBg = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF8F9FA);
      final Color cardBg = isDark ? const Color(0xFF161B22) : Colors.white;
      final Color textColor = isDark ? Colors.white : Colors.black87;
      final Color subtitleColor = isDark ? Colors.grey : Colors.black54;

      return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          title: Text(
            'CÀI ĐẶT HỆ THỐNG',
            style: settingsController.getTextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          backgroundColor: isDark ? const Color(0xFF0D0F14) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
            onPressed: () => Get.back(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            // SECTION 1: INTERFACE STYLE
            _buildSectionHeader('GIAO DIỆN & MÀU SẮC', settingsController, textColor),
            Card(
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04)),
              ),
              child: SwitchListTile(
                title: Text('Chế độ Tối (Dark Mode)', style: settingsController.getTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
                subtitle: Text('Giảm mỏi mắt và tiết kiệm pin', style: settingsController.getTextStyle(fontSize: 11, color: subtitleColor)),
                value: isDark,
                onChanged: (val) => settingsController.toggleTheme(),
                activeColor: const Color(0xFF00E5FF),
              ),
            ),
            const SizedBox(height: 20),

            // SECTION 2: LANGUAGES
            _buildSectionHeader('NGÔN NGỮ TOÀN APP', settingsController, textColor),
            Card(
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: settingsController.languages.map((lang) {
                    final isSelected = settingsController.currentLanguage.value == lang['code'];
                    return RadioListTile<String>(
                      title: Row(
                        children: [
                          Text(lang['flag'] ?? '🌐', style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 12),
                          Text(
                            lang['name'] ?? '',
                            style: settingsController.getTextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      value: lang['code'] ?? '',
                      groupValue: settingsController.currentLanguage.value,
                      onChanged: (val) {
                        if (val != null) settingsController.setLanguage(val);
                      },
                      activeColor: const Color(0xFF00E5FF),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // SECTION 3: FONTS
            _buildSectionHeader('PHÔNG CHỮ (FONTS)', settingsController, textColor),
            Card(
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: settingsController.fonts.map((font) {
                    final isSelected = settingsController.currentFont.value == font;
                    return RadioListTile<String>(
                      title: Text(
                        font,
                        style: settingsController.getTextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: textColor,
                        ).copyWith(fontFamily: font), // Preview the font
                      ),
                      value: font,
                      groupValue: settingsController.currentFont.value,
                      onChanged: (val) {
                        if (val != null) settingsController.setFont(val);
                      },
                      activeColor: const Color(0xFF00E5FF),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // SAMPLE PREVIEW CARD
            Card(
              color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.02),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('BẢN XEM TRƯỚC PHÔNG CHỮ', style: settingsController.getTextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: subtitleColor)),
                    const SizedBox(height: 8),
                    Text(
                      'Hệ sinh thái LushMKT - Tiên phong trong giải pháp tiếp thị số.',
                      style: settingsController.getTextStyle(fontSize: 13, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildSectionHeader(String title, SettingsController settings, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: settings.getTextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color.withOpacity(0.6)),
      ),
    );
  }
}
