import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/responsive_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // تعيين مؤشر التنقل السفلي للحساب

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'طلباتي',
      'icon': Icons.shopping_bag_outlined,
      'color': Color(0xFF5C6BC0),
    },
    {
      'title': 'العناوين',
      'icon': Icons.location_on_outlined,
      'color': Color(0xFF66BB6A),
    },
    {
      'title': 'المفضلة',
      'icon': Icons.favorite_border,
      'color': Color(0xFFEF5350),
    },
    {
      'title': 'المحفظة',
      'icon': Icons.account_balance_wallet_outlined,
      'color': Color(0xFFFF7043),
    },
    {
      'title': 'الإعدادات',
      'icon': Icons.settings_outlined,
      'color': Color(0xFF26A69A),
    },
    {
      'title': 'مركز المساعدة',
      'icon': Icons.help_outline,
      'color': Color(0xFFF06292),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveConfig.getHorizontalPadding(context);
    final baseFontSize = ResponsiveConfig.getBaseFontSize(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'حسابي',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35.r,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 40.r,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'أحمد محمد',
                                  style: TextStyle(
                                    fontSize: baseFontSize * 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'ahmed@example.com',
                                  style: TextStyle(
                                    fontSize: baseFontSize * 0.9,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            color: Colors.white,
                            onPressed: () {
                              // TODO: Navigate to edit profile
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Menu Items
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                      ),
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        final item = _menuItems[index];
                        return Card(
                          elevation: 2,
                          shadowColor: item['color'].withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: InkWell(
                            onTap: () {
                              // TODO: Navigate to respective screens
                            },
                            borderRadius: BorderRadius.circular(15.r),
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    item['icon'],
                                    size: 32.r,
                                    color: item['color'],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: baseFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement logout
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('تسجيل الخروج'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/categories');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/cart');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
            }
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
