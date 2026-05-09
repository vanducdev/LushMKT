import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/service_order_view.dart';
import '../profile/profile_view.dart';
import '../products/product_purchase_view.dart';
import '../payment/deposit_view.dart';
import 'notifications_view.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/social_controller.dart';
import '../../controllers/auth_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final SettingsController _settingsController = Get.put(SettingsController());
  final SocialController _socialController = Get.put(SocialController());
  final AuthController _authController = Get.put(AuthController());

  final _postTextController = TextEditingController();
  final _postLocationController = TextEditingController();
  final _commentControllers = <int, TextEditingController>{};

  Widget _buildBody() {
    switch (_currentIndex) {
      case 1:
        return const ServiceOrderView();
      case 2:
        return const ProductPurchaseView(); // Store Module upgraded to "Store"
      case 3:
        return const DepositView(); // Upgraded Fintech Deposit
      case 4:
        return const ProfileView(); // Premium Profile Screen
      default:
        return _buildSocialFeed(); // Upgraded Social Network Feed Dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = _settingsController.isDarkMode.value;
      final Color navBg = isDark ? const Color(0xFF0D0F14) : Colors.white;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF8F9FA),
        body: _buildBody(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04), width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: navBg,
            selectedItemColor: const Color(0xFF00E5FF),
            unselectedItemColor: Colors.grey,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.forum_outlined), label: 'Feed'),
              BottomNavigationBarItem(icon: Icon(Icons.rocket_launch_outlined), label: 'Dịch vụ'),
              BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Store'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Nạp tiền'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Tài khoản'),
            ],
          ),
        ),
      );
    });
  }

  // --- SOCIAL FEED DASHBOARD (TAB 0) ---
  Widget _buildSocialFeed() {
    return Obx(() {
      final isDark = _settingsController.isDarkMode.value;
      final Color textColor = isDark ? Colors.white : Colors.black87;
      final Color cardColor = isDark ? const Color(0xFF161B22) : Colors.white;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: Text(
            'LushMKT SOCIAL',
            style: _settingsController.getTextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          backgroundColor: isDark ? const Color(0xFF0D0F14) : Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none_rounded, color: textColor),
              onPressed: () => Get.to(() => const NotificationsView()),
            ),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // 1. STORY / TIN SLIDER
            _buildStorySlider(cardColor, textColor),
            const SizedBox(height: 20),

            // 2. CREATE POST CONTAINER
            _buildCreatePostBox(cardColor, textColor),
            const SizedBox(height: 20),

            // 3. POSTS FEED LIST
            Text(
              'BÀI VIẾT NỔI BẬT',
              style: _settingsController.getTextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor.withOpacity(0.5)),
            ),
            const SizedBox(height: 12),

            _buildPostFeedList(cardColor, textColor),
          ],
        ),
      );
    });
  }

  // Beautiful visual stories box (đăng tin)
  Widget _buildStorySlider(Color cardColor, Color textColor) {
    final stories = [
      {'name': 'Tin của tôi', 'img': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=150', 'isMe': true},
      {'name': 'Nguyễn Đức', 'img': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150', 'isMe': false},
      {'name': 'Admin Lush', 'img': 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150', 'isMe': false},
      {'name': 'Quốc Khánh', 'img': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150', 'isMe': false},
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(story['img'] as String),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xFF00E5FF),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(story['img'] as String),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    story['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _settingsController.getTextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Create social post widget
  Widget _buildCreatePostBox(Color cardColor, Color textColor) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _settingsController.isDarkMode.value ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF00E5FF).withOpacity(0.1),
                  child: Icon(Icons.person, color: const Color(0xFF00E5FF)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _postTextController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Bạn đang nghĩ gì thế?',
                      hintStyle: _settingsController.getTextStyle(fontSize: 13, color: Colors.grey),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                    style: _settingsController.getTextStyle(fontSize: 13, color: textColor),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, color: Colors.white10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _postLocationController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on_outlined, size: 16, color: Colors.redAccent),
                      hintText: 'Thêm địa chỉ (Ví dụ: Hà Nội)',
                      hintStyle: _settingsController.getTextStyle(fontSize: 11, color: Colors.grey),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                    style: _settingsController.getTextStyle(fontSize: 12, color: textColor),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    final text = _postTextController.text.trim();
                    final location = _postLocationController.text.trim();

                    if (text.isEmpty) {
                      Get.snackbar('Cảnh Báo', 'Vui lòng nhập nội dung bài đăng.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orangeAccent, colorText: Colors.white);
                      return;
                    }

                    _socialController.createPost(text, null, location.isNotEmpty ? location : null);
                    _postTextController.clear();
                    _postLocationController.clear();
                    Get.snackbar('Đăng bài thành công', 'Bài viết đã được chia sẻ lên Feed.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                  },
                  icon: const Icon(Icons.send_rounded, size: 14),
                  label: const Text('ĐĂNG'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: _settingsController.getTextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Posts Feed List builder
  Widget _buildPostFeedList(Color cardColor, Color textColor) {
    return Obx(() {
      final feed = _socialController.posts;
      if (feed.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text('Chưa có bài viết nào.', style: _settingsController.getTextStyle(fontSize: 13, color: Colors.grey)),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: feed.length,
        itemBuilder: (context, index) {
          final post = feed[index];
          if (!_commentControllers.containsKey(post.id)) {
            _commentControllers[post.id] = TextEditingController();
          }

          return Card(
            color: cardColor,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: _settingsController.isDarkMode.value ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER: Author info
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF00E5FF).withOpacity(0.1),
                        child: Text(
                          post.authorName.isNotEmpty ? post.authorName[0].toUpperCase() : 'U',
                          style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.authorName, style: _settingsController.getTextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor)),
                            if (post.location != null)
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 10, color: Colors.redAccent),
                                  const SizedBox(width: 2),
                                  Text(post.location!, style: _settingsController.getTextStyle(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Text(
                        'Vừa xong',
                        style: _settingsController.getTextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),

                  // BODY: Content text
                  Text(post.text, style: _settingsController.getTextStyle(fontSize: 13, color: textColor)),
                  const SizedBox(height: 16),

                  // FOOTER ACTIONS: Like, comment
                  const Divider(height: 1, color: Colors.white10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => _socialController.likePost(post.id),
                        icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 16),
                        label: Text('${post.likes} Likes', style: _settingsController.getTextStyle(fontSize: 11, color: textColor)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_outlined, color: Colors.grey, size: 16),
                        label: Text('${post.comments.length} Bình luận', style: _settingsController.getTextStyle(fontSize: 11, color: textColor)),
                      ),
                    ],
                  ),

                  // COMMENT LIST PREVIEWS
                  if (post.comments.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: post.comments.map((comment) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: 'Khách: ', style: _settingsController.getTextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor)),
                                  TextSpan(text: comment, style: _settingsController.getTextStyle(fontSize: 12, color: textColor.withOpacity(0.8))),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  // ADD COMMENT FIELD
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentControllers[post.id],
                          decoration: InputDecoration(
                            hintText: 'Viết bình luận...',
                            hintStyle: _settingsController.getTextStyle(fontSize: 11, color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                          ),
                          style: _settingsController.getTextStyle(fontSize: 12, color: textColor),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_rounded, size: 16, color: Color(0xFF00E5FF)),
                        onPressed: () {
                          final cText = _commentControllers[post.id]!.text.trim();
                          if (cText.isNotEmpty) {
                            _socialController.commentPost(post.id, cText);
                            _commentControllers[post.id]!.clear();
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
