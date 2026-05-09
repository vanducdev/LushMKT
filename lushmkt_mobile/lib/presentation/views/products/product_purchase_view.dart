import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPurchaseView extends StatefulWidget {
  final String productName;
  final double price;
  final int stock;
  final String category;
  final String warranty;

  const ProductPurchaseView({
    super.key,
    required this.productName,
    required this.price,
    required this.stock,
    required this.category,
    required this.warranty,
  });

  @override
  State<ProductPurchaseView> createState() => _ProductPurchaseViewState();
}

class _ProductPurchaseViewState extends State<ProductPurchaseView> {
  int _quantity = 1;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    setState(() {
      _totalPrice = widget.price * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MUA TÀI NGUYÊN MMO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product info header card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.1)),
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
                            widget.category == 'VIA Facebook'
                                ? Icons.facebook
                                : widget.category == 'Gmail'
                                    ? Icons.email_outlined
                                    : Icons.vpn_lock,
                            color: const Color(0xFF00E5FF),
                            size: 36,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7000FF).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Còn lại: ${widget.stock}',
                                      style: const TextStyle(color: Color(0xFF7000FF), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.warranty,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description / Warranty Details
                  const Text('CHÍNH SÁCH BẢO HÀNH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00E5FF), letterSpacing: 1)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.02)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WarrantyBulletPoint('Bảo hành login lần đầu tiên thành công trong vòng 24h.'),
                        _WarrantyBulletPoint('Không bảo hành lỗi đổi thông tin, đổi IP bẩn dẫn đến checkpoint.'),
                        _WarrantyBulletPoint('Hệ thống tự động lưu trữ và giao hàng ngay lập tức sau khi thanh toán thành công.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quantity Selector Section
                  const Text('SỐ LƯỢNG MUA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00E5FF), letterSpacing: 1)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Chọn số lượng tài khoản:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B22),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                    _calculateTotal();
                                  });
                                }
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white, size: 18),
                              onPressed: () {
                                if (_quantity < widget.stock) {
                                  setState(() {
                                    _quantity++;
                                    _calculateTotal();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Price Details Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Đơn giá sản phẩm:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text('${widget.price} đ', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Số lượng:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text('x $_quantity', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Colors.white10, height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('TỔNG THANH TOÁN:', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              '$_totalPrice đ',
                              style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Checkout Action Button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00E5FF), Color(0xFF7000FF)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: const Color(0xFF161B22),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: const Color(0xFF00E5FF).withOpacity(0.2))),
                            title: const Row(
                              children: [
                                Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF)),
                                SizedBox(width: 10),
                                Text('MUA THÀNH CÔNG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            content: Text(
                              'Đã mua thành công $_quantity gói tài nguyên. Thông tin tài khoản và định dạng đăng nhập đã được tự động phân phối gửi vào phần Lịch sử đơn hàng của bạn.',
                              style: const TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('ĐỒNG Ý', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'THANH TOÁN NGAY',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1),
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
}

class _WarrantyBulletPoint extends StatelessWidget {
  final String text;
  const _WarrantyBulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 11))),
        ],
      ),
    );
  }
}
