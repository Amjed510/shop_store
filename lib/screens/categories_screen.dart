import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/responsive_config.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _currentIndex = 1; // تعيين مؤشر التنقل السفلي للفئات

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'ملابس',
      'icon': Icons.checkroom,
      'color': Color(0xFF5C6BC0),
      'subCategories': ['ملابس رجالية', 'ملابس نسائية', 'ملابس أطفال'],
    },
    {
      'name': 'إلكترونيات',
      'icon': Icons.devices,
      'color': Color(0xFF66BB6A),
      'subCategories': ['هواتف', 'حواسيب', 'أجهزة لوحية'],
    },
    {
      'name': 'إكسسوارات',
      'icon': Icons.watch,
      'color': Color(0xFFEF5350),
      'subCategories': ['ساعات', 'نظارات', 'مجوهرات'],
    },
    {
      'name': 'أحذية',
      'icon': Icons.shopping_bag,
      'color': Color(0xFFFF7043),
      'subCategories': ['رياضية', 'رسمية', 'كاجوال'],
    },
    {
      'name': 'رياضة',
      'icon': Icons.sports_soccer,
      'color': Color(0xFF26A69A),
      'subCategories': ['ملابس رياضية', 'معدات', 'أحذية رياضية'],
    },
    {
      'name': 'منزل ومطبخ',
      'icon': Icons.home,
      'color': Color(0xFFF06292),
      'subCategories': ['أدوات مطبخ', 'أثاث', 'إضاءة'],
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
                'الفئات',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            SliverPadding(
              padding: EdgeInsets.all(horizontalPadding),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = _categories[index];
                    return _buildCategoryCard(
                      category: category,
                      baseFontSize: baseFontSize,
                    );
                  },
                  childCount: _categories.length,
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

  Widget _buildCategoryCard({
    required Map<String, dynamic> category,
    required double baseFontSize,
  }) {
    return Card(
      elevation: 4,
      shadowColor: category['color'].withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to category details
          _showSubCategories(category);
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: LinearGradient(
              colors: [
                category['color'].withOpacity(0.8),
                category['color'],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category['icon'],
                  size: 48.r,
                  color: Colors.white,
                ),
                SizedBox(height: 12.h),
                Text(
                  category['name'],
                  style: TextStyle(
                    fontSize: baseFontSize * 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  '${category['subCategories'].length} أقسام',
                  style: TextStyle(
                    fontSize: baseFontSize * 0.9,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSubCategories(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: category['color'],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      category['icon'],
                      color: Colors.white,
                      size: 24.r,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      category['name'],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: category['subCategories'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      category['subCategories'][index],
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.r,
                      color: category['color'],
                    ),
                    onTap: () {
                      // TODO: Navigate to subcategory products
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
