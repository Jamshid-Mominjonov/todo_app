import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TaskTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.r)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),

      ),
    );
  }
}