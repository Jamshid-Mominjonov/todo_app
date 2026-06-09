import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewTasksButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewTasksButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: const BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}