import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketsView extends StatefulWidget {
  const TicketsView({super.key});

  @override
  State<TicketsView> createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView> {
  // Mock active tickets
  final List<Map<String, dynamic>> _tickets = [
    {
      'id': 'TK-8912',
      'title': 'Đơn hàng buff follow lên chậm',
      'department': 'Dịch vụ mạng xã hội',
      'priority': 'Trung bình',
      'status': 'Đang chờ phản hồi',
      'date': '08:15 - 09/05/2026'
    },
    {
      'id': 'TK-7812',
      'title': 'Lỗi chưa cộng tiền nạp thẻ qua VietQR',
      'department': 'Bộ phận thanh toán',
      'priority': 'Cao',
      'status': 'Đã trả lời',
      'date': '19:40 - 08/05/2026'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YÊU CẦU HỖ TRỢ (TICKET)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1)),
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: _tickets.length,
              itemBuilder: (context, index) {
                final ticket = _tickets[index];
                bool isReplied = ticket['status'] == 'Đã trả lời';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.04)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticket['id'],
                            style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isReplied ? Colors.green.withOpacity(0.15) : Colors.amber.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              ticket['status'],
                              style: TextStyle(
                                color: isReplied ? Colors.green : Colors.amber,
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ticket['title'],
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.business_center_outlined, color: Colors.grey, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            ticket['department'],
                            style: const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          const SizedBox(width: 14),
                          const Icon(Icons.priority_high_outlined, color: Colors.grey, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'Ưu tiên: ${ticket['priority']}',
                            style: TextStyle(
                              color: ticket['priority'] == 'Cao' ? Colors.redAccent : Colors.grey,
                              fontSize: 11,
                              fontWeight: ticket['priority'] == 'Cao' ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white10, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ticket['date'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          TextButton(
                            onPressed: () {
                              Get.snackbar(
                                'Chi tiết hỗ trợ',
                                'Nội dung phản hồi hỗ trợ đang được đồng bộ tải về.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF161B22),
                                colorText: Colors.white,
                              );
                            },
                            child: const Text('Xem trao đổi', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      
      // Floating button to submit new ticket
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar(
            'Gửi Ticket mới',
            'Chức năng gửi yêu cầu hỗ trợ mới đang kết nối dữ liệu.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF161B22),
            colorText: Colors.white,
            borderColor: const Color(0xFF00E5FF),
            borderWidth: 1,
          );
        },
        backgroundColor: const Color(0xFF00E5FF),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
