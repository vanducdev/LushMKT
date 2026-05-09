import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  final String _bankName = "MB Bank (Ngân hàng Quân Đội)";
  final String _accountNumber = "1903561728394";
  final String _accountName = "CONG TY CONG NGHE LUSHMKT";
  final String _transferNote = "LUSH 79836";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NẠP TIỀN TỰ ĐỘNG 24/7', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
        backgroundColor: const Color(0xFF0D0F14),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF0D0F14)),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Instruction card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.15)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shield_outlined, color: Color(0xFF00E5FF), size: 24),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Hệ thống nạp tiền tự động qua VietQR. Tiền cộng vào số dư tài khoản trong vòng 1-3 phút.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Simulated VietQR Code Box (Cyber Gradient frame)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.05),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Simulated QR code using Flutter built-in widgets
                        Container(
                          width: 200,
                          height: 200,
                          color: Colors.white,
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Mock QR squares using a GridView
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: 36,
                                itemBuilder: (context, index) {
                                  // Alternating colors to simulate QR code data squares
                                  bool isBlack = (index % 3 == 0 || index % 5 == 0 || index == 0 || index == 5 || index == 30 || index == 35);
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: isBlack ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                },
                              ),
                              // Core VietQR logo inside the center
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.blue, width: 1.5),
                                ),
                                child: const Text(
                                  'VietQR',
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Quét mã QR để thanh toán tự động nhanh nhất',
                          style: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Bank details listing with copy buttons
                  _buildBankDetailRow('Ngân hàng:', _bankName, false),
                  _buildBankDetailRow('Số tài khoản:', _accountNumber, true),
                  _buildBankDetailRow('Chủ tài khoản:', _accountName, false),
                  _buildBankDetailRow('Nội dung chuyển khoản:', _transferNote, true),

                  const SizedBox(height: 40),

                  // Bottom alert notice
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2D55).withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFF2D55).withOpacity(0.15)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Color(0xFFFF2D55), size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Lưu ý: Chuyển đúng số tài khoản và bắt buộc ghi đúng nội dung chuyển khoản phía trên để được cộng tiền tự động.',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        )
                      ],
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

  Widget _buildBankDetailRow(String label, String value, bool copyable) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy, color: Color(0xFF00E5FF), size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                Get.snackbar(
                  'Đã sao chép',
                  'Đã sao chép "$value" vào bộ nhớ tạm',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF161B22),
                  colorText: Colors.white,
                );
              },
            )
        ],
      ),
    );
  }
}
