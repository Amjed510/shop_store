import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/responsive_config.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveConfig.getHorizontalPadding(context);
    final baseFontSize = ResponsiveConfig.getBaseFontSize(context);

    // قائمة الإشعارات للعرض
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'تم شحن طلبك',
        'message': 'تم شحن طلبك رقم #123456 وسيصل خلال 2-3 أيام عمل',
        'time': 'منذ 5 دقائق',
        'type': 'shipping',
        'isRead': false,
      },
      {
        'title': 'خصم خاص',
        'message': 'استمتع بخصم 25% على جميع المنتجات الإلكترونية لمدة 24 ساعة فقط!',
        'time': 'منذ ساعتين',
        'type': 'offer',
        'isRead': false,
      },
      {
        'title': 'تم تأكيد طلبك',
        'message': 'تم تأكيد طلبك رقم #123455 وجاري تجهيزه',
        'time': 'منذ 5 ساعات',
        'type': 'order',
        'isRead': true,
      },
      {
        'title': 'منتجات جديدة',
        'message': 'تصفح أحدث المنتجات التي تم إضافتها لدينا',
        'time': 'منذ يوم',
        'type': 'product',
        'isRead': true,
      },
      {
        'title': 'تقييم المنتج',
        'message': 'كيف كانت تجربتك مع المنتج الذي اشتريته؟ شاركنا رأيك!',
        'time': 'منذ يومين',
        'type': 'review',
        'isRead': true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'الإشعارات',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: تنفيذ وظيفة تحديد الكل كمقروء
            },
            child: Text(
              'تحديد الكل كمقروء',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: baseFontSize * 0.9,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64.r,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'لا توجد إشعارات',
                    style: TextStyle(
                      fontSize: baseFontSize * 1.2,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 8.h,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(
                  context,
                  notification,
                  baseFontSize,
                );
              },
            ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    Map<String, dynamic> notification,
    double baseFontSize,
  ) {
    IconData getNotificationIcon() {
      switch (notification['type']) {
        case 'shipping':
          return Icons.local_shipping_outlined;
        case 'offer':
          return Icons.local_offer_outlined;
        case 'order':
          return Icons.shopping_bag_outlined;
        case 'product':
          return Icons.new_releases_outlined;
        case 'review':
          return Icons.star_outline;
        default:
          return Icons.notifications_outlined;
      }
    }

    Color getNotificationColor() {
      switch (notification['type']) {
        case 'shipping':
          return Colors.blue;
        case 'offer':
          return Colors.orange;
        case 'order':
          return Colors.green;
        case 'product':
          return Colors.purple;
        case 'review':
          return Colors.amber;
        default:
          return Colors.grey;
      }
    }

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          // TODO: تنفيذ وظيفة عند النقر على الإشعار
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: notification['isRead'] ? Colors.white : Colors.blue[50],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: getNotificationColor().withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getNotificationIcon(),
                  color: getNotificationColor(),
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification['title'],
                          style: TextStyle(
                            fontSize: baseFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: baseFontSize * 0.8,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        fontSize: baseFontSize * 0.9,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
