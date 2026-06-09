import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TaskButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        //backgroundColor: const Color(0xff62D2C3),
        backgroundColor: Color(0xFF0096C8),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}