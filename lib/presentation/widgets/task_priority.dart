import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskPriority extends StatelessWidget {
  final String txt;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  const TaskPriority({super.key, required this.color, required this.txt, required this.onPressed, required this.textColor, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(right: 8.w),
        height: 40.h,
        width: 100.w,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5.w),
            borderRadius: BorderRadius.circular(10.r),
          color: color,
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
