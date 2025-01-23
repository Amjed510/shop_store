import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/models/product_model.dart';
import 'package:shop_store/screens/cart_screen.dart';
import 'package:shop_store/screens/categories_screen.dart';
import 'package:shop_store/screens/product_details_screen.dart';
import 'package:shop_store/screens/profile_screen.dart';
import 'package:shop_store/screens/notifications_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'utils/responsive_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop Store',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
              fontFamily: 'Cairo',
              useMaterial3: true,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/categories': (context) => const CategoriesScreen(),
              '/cart': (context) => const CartScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/product-details': (context) => ProductDetailsScreen(
                product: ModalRoute.of(context)!.settings.arguments as Product,
              ),
            },
          );
        },
      ),
    );
  }
}
