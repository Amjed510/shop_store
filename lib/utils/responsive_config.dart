import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// فئة لإدارة الأبعاد والقياسات المتجاوبة في التطبيق
class ResponsiveConfig {
  /// الحصول على ارتفاع شريط التطبيق بناءً على حجم الشاشة
  static double getAppBarHeight(BuildContext context) {
    // الحصول على حجم الشاشة
    final size = MediaQuery.of(context).size;
    // تحديد الارتفاع بناءً على عرض الشاشة
    if (size.width > 600) {
      return 70.h; // للأجهزة اللوحية والشاشات الكبيرة
    }
    return 56.h; // للهواتف
  }

  /// الحصول على التباعد الأفقي بناءً على حجم الشاشة
  static double getHorizontalPadding(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return 32.w; // تباعد أكبر للشاشات الكبيرة
    }
    return 16.w; // تباعد عادي للهواتف
  }

  /// الحصول على عدد الأعمدة في شبكة المنتجات
  static int getGridColumnCount(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 900) {
      return 4; // 4 منتجات في الصف للشاشات الكبيرة جداً
    } else if (size.width > 600) {
      return 3; // 3 منتجات في الصف للأجهزة اللوحية
    }
    return 2; // منتجان في الصف للهواتف
  }

  /// الحصول على نسبة العرض إلى الارتفاع لبطاقات المنتجات
  static double getProductCardAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return 0.8; // بطاقات أطول قليلاً للشاشات الكبيرة
    }
    return 0.7; // النسبة العادية للهواتف
  }

  /// الحصول على حجم الخط الأساسي
  static double getBaseFontSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return 16.sp; // حجم خط أكبر للشاشات الكبيرة
    }
    return 14.sp; // حجم الخط العادي للهواتف
  }

  /// الحصول على ارتفاع عارض الشرائح
  static double getCarouselHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 900) {
      return 300.h; // ارتفاع أكبر للشاشات الكبيرة جداً
    } else if (size.width > 600) {
      return 250.h; // ارتفاع متوسط للأجهزة اللوحية
    }
    return 180.h; // الارتفاع العادي للهواتف
  }

  /// الحصول على عرض بطاقة الفئة
  static double getCategoryCardWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return 120.w; // عرض أكبر للشاشات الكبيرة
    }
    return 85.w; // العرض العادي للهواتف
  }

  /// الحصول على المسافة بين العناصر في الشبكة
  static double getGridSpacing(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 600) {
      return 24.w; // مسافة أكبر للشاشات الكبيرة
    }
    return 16.w; // المسافة العادية للهواتف
  }
}
