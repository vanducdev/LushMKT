import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceOrderView extends StatefulWidget {
  final String serviceName;
  final double basePrice;

  const ServiceOrderView({
    super.key,
    required this.serviceName,
    required this.basePrice,
  });

  @override
  State<ServiceOrderView> createState() => _ServiceOrderViewState();
}

class _ServiceOrderViewState extends State<ServiceOrderView> {
  final _linkController = TextEditingController();
  final _quantityController = TextEditingController();
  
  String _selectedServer = 'Server 1 - Tốc độ cao (Không bảo hành)';
  double _serverMarkup = 0.0;
  int _quantity = 1000;
  double _totalCost = 0.0;

  final List<Map<String, dynamic>> _servers = [
    {'name': 'Server 1 - Tốc độ cao (Không bảo hành)', 'markup': 0.0, 'speed': 'Siêu nhanh'},
    {'name': 'Server 2 - Premium (Bảo hành 30 ngày)', 'markup': 1.5, 'speed': 'Ổn định'},
    {'name': 'Server 3 - Việt Real (Lên tự nhiên, an toàn)', 'markup': 3.0, 'speed': 'Tự nhiên'},
  ];

  @override
  void initState() {
    super.initState();
    _quantityController.text = _quantity.toString();
    _calculateCost();
  }

  void _calculateCost() {
    setState(() {
      double pricePerOne = widget.basePrice + _serverMarkup;
      _totalCost = pricePerOne * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  // Info Alert Banner
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Color(0xFF00E5FF), size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Vui lòng mở công khai bài viết / trang cá nhân trước khi mua đơn để tránh lỗi treo đơn hàng.',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. Link Input Field
                  const Text('LIÊN KẾT / ID BÀI VIẾT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00E5FF), letterSpacing: 1)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.link, color: Color(0xFF00E5FF)),
                      hintText: 'Nhập link Facebook, Instagram hoặc ID bài viết...',
                      fillColor: const Color(0xFF161B22),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. Server Selection (Glass Cards)
                  const Text('CHỌN MÁY CHỦ (SERVER)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00E5FF), letterSpacing: 1)),
                  const SizedBox(height: 10),
                  Column(
                    children: _servers.map((server) {
                      bool isSelected = _selectedServer == server['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedServer = server['name'];
                            _serverMarkup = server['markup'];
                            _calculateCost();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF161B22) : const Color(0xFF161B22).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF00E5FF) : Colors.white.withOpacity(0.04),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      server['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: isSelected ? const Color(0xFF00E5FF) : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tốc độ: ${server['speed']}',
                                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '+${server['markup']}đ',
                                style: TextStyle(
                                  color: isSelected ? const Color(0xFF00E5FF) : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 3. Quantity Input Field
                  const Text('SỐ LƯỢNG BUFF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00E5FF), letterSpacing: 1)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _quantity = int.tryParse(value) ?? 0;
                        _calculateCost();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.add_moderator_outlined, color: Color(0xFF00E5FF)),
                      hintText: 'Nhập số lượng buff tối thiểu 100...',
                      fillColor: const Color(0xFF161B22),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 4. Detailed Cost Estimate Glass Card
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
                            const Text('Giá gốc một đơn vị:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text('${widget.basePrice} đ', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Phụ phí máy chủ:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text('+$_serverMarkup đ', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Colors.white10, height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('TỔNG CHI PHÍ:', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              '$_totalCost đ',
                              style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 5. Submit Order Button
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
                        Get.snackbar(
                          'Tạo đơn thành công',
                          'Đơn hàng của bạn đang được xử lý trong hàng đợi!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'TẠO ĐƠN NGAY',
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
