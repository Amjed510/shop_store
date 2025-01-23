import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import '../utils/responsive_config.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // الحصول على القياسات المتجاوبة
    final baseFontSize = ResponsiveConfig.getBaseFontSize(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // صورة المنتج
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // علامة الخصم
                  if (product.isOnSale)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'خصم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: baseFontSize * 0.85,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // تفاصيل المنتج
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // اسم المنتج
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: baseFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    
                    // التقييم
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: product.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: baseFontSize * 0.9,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            fontSize: baseFontSize * 0.8,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // السعر
                    Row(
                      children: [
                        if (product.isOnSale) ...[
                          Text(
                            '\$${product.salePrice}',
                            style: TextStyle(
                              fontSize: baseFontSize * 1.1,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontSize: baseFontSize * 0.85,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        ] else
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontSize: baseFontSize * 1.1,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
