import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/responsive_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'الكل';
  int _currentIndex = 0;
  
  final List<Map<String, dynamic>> _categories = [
    {'name': 'الكل', 'icon': Icons.apps},
    {'name': 'ملابس', 'icon': Icons.checkroom},
    {'name': 'إلكترونيات', 'icon': Icons.devices},
    {'name': 'إكسسوارات', 'icon': Icons.watch},
  ];

  final List<Map<String, dynamic>> _promotions = [
    {
      'title': 'خصم 50% على جميع المنتجات',
      'color1': Color(0xFF5C6BC0),
      'color2': Color(0xFFFF7043),
    },
    {
      'title': 'وصل حديثاً',
      'color1': Color(0xFF66BB6A),
      'color2': Color(0xFF26A69A),
    },
    {
      'title': 'عروض حصرية اليوم',
      'color1': Color(0xFFEF5350),
      'color2': Color(0xFFF06292),
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ProductProvider>().fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على القياسات المتجاوبة
    final horizontalPadding = ResponsiveConfig.getHorizontalPadding(context);
    final carouselHeight = ResponsiveConfig.getCarouselHeight(context);
    final categoryCardWidth = ResponsiveConfig.getCategoryCardWidth(context);
    final gridSpacing = ResponsiveConfig.getGridSpacing(context);
    final gridColumnCount = ResponsiveConfig.getGridColumnCount(context);
    final productCardAspectRatio = ResponsiveConfig.getProductCardAspectRatio(context);
    final baseFontSize = ResponsiveConfig.getBaseFontSize(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'المتجر',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن المنتجات...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context.read<ProductProvider>().searchProducts(value);
                    } else {
                      context.read<ProductProvider>().fetchProducts();
                    }
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: carouselHeight,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    final promotion = _promotions[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            promotion['color1'],
                            promotion['color2'],
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: promotion['color1'].withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(horizontalPadding),
                          child: Text(
                            promotion['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: baseFontSize * 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _promotions.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Theme.of(context).colorScheme.primary,
                      color: Colors.grey[300],
                      size: 8.w,
                      activeSize: 10.w,
                    ),
                  ),
                  autoplay: true,
                  autoplayDelay: 3000,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16.h,
                ),
                child: Text(
                  'الفئات',
                  style: TextStyle(
                    fontSize: baseFontSize * 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: categoryCardWidth * 1.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.5),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return CategoryCard(
                      name: category['name'],
                      icon: category['icon'],
                      isSelected: _selectedCategory == category['name'],
                      onTap: () {
                        setState(() {
                          _selectedCategory = category['name'];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (provider.error != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.w,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            provider.error!,
                            style: TextStyle(
                              fontSize: baseFontSize,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final products = _selectedCategory == 'الكل'
                    ? provider.products
                    : provider.getProductsByCategory(_selectedCategory);

                if (products.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48.w,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'لا توجد منتجات',
                            style: TextStyle(
                              fontSize: baseFontSize,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8.h,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumnCount,
                      childAspectRatio: productCardAspectRatio,
                      mainAxisSpacing: gridSpacing,
                      crossAxisSpacing: gridSpacing,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product-details',
                              arguments: products[index],
                            );
                          },
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                );
              },
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
