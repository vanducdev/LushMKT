import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/payment_controller.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  final PaymentController _controller = Get.put(PaymentController());
  final _couponController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = _controller.qrAmount.value.toInt().toString();
  }

  void _copyToClipboard(String text, String fieldName) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Đã Sao Chép',
      'Đã sao chép $fieldName vào bộ nhớ tạm.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF161B22),
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VÍ & NẠP TIỀN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1)),
        backgroundColor: const Color(0xFF0D0F14),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF0D0F14)),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Balance Dashboard
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF7000FF)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SỐ DƯ TÀI KHOẢN', style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            const SizedBox(height: 6),
                            Obx(() => Text(
                              '${_controller.balance.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                            ))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.08), shape: BoxShape.circle),
                          child: const Icon(Icons.account_balance_wallet, color: Colors.black, size: 28),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. Set Recharge Amount & Coupon
                  const Text('THIẾT LẬP KHOẢN NẠP', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Số tiền muốn nạp (đ)',
                            labelStyle: const TextStyle(color: Colors.grey, fontSize: 11),
                            filled: true,
                            fillColor: const Color(0xFF161B22),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.04))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00E5FF))),
                          ),
                          onChanged: (val) {
                            final intAmt = double.tryParse(val) ?? 50000.0;
                            _controller.qrAmount.value = intAmt;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.simulateDeposit(_controller.qrAmount.value);
                            Get.snackbar('Nạp Thử Nghiệm', 'Đã cộng ${_controller.qrAmount.value.toInt()}đ vào ví của bạn.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7000FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('NẠP THỬ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Coupon applying row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _couponController,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Nhập mã giảm giá/khuyến mãi...',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                            filled: true,
                            fillColor: const Color(0xFF161B22),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.04))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00E5FF))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => _controller.applyCouponCode(_couponController.text),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('ÁP DỤNG', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 3. Dynamic VietQR Generation Box
                  const Text('QUÉT MÃ CHUYỂN KHOẢN TỰ ĐỘNG VIETQR', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                    ),
                    child: Column(
                      children: [
                        // Dynamic QR Image using Quick VietQR Generator API
                        Obx(() => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                          child: Image.network(
                            'https://img.vietqr.io/image/MB-098123456789-compact2.png?amount=${_controller.qrAmount.value.toInt()}&addInfo=${_controller.transferNote.value}',
                            height: 180,
                            width: 180,
                            fit: BoxFit.cover,
                          ),
                        )),
                        const SizedBox(height: 20),

                        // Fast copy helper rows
                        _buildCopyRow('Ngân hàng:', _controller.bankName.value, 'Tên ngân hàng'),
                        _buildCopyRow('Số tài khoản:', _controller.accountNumber.value, 'Số tài khoản'),
                        _buildCopyRow('Chủ tài khoản:', _controller.accountHolder.value, 'Tên chủ tài khoản'),
                        _buildCopyRow('Nội dung chuyển khoản:', _controller.transferNote.value, 'Nội dung CK'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. Transaction History Logs
                  const Text('LỊCH SỬ GIAO DỊCH', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 12),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = _controller.transactions[index];
                      final isDeposit = tx.type == 'deposit';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B22).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.02)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tx.description, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(tx.date, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                                ],
                              ),
                            ),
                            Text(
                              '${isDeposit ? '+' : '-'}${tx.amount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
                              style: TextStyle(color: isDeposit ? Colors.green : Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Copy Row helper
  Widget _buildCopyRow(String label, String value, String clipboardLabel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Row(
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => _copyToClipboard(value, clipboardLabel),
                child: const Icon(Icons.copy_rounded, color: Color(0xFF00E5FF), size: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
