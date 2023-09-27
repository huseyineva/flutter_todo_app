import 'package:flutter/material.dart';

class CategorySelected extends StatefulWidget {
  const CategorySelected({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<CategorySelected> createState() => _CategorySelectedState();
}

class _CategorySelectedState extends State<CategorySelected> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Category Selected!"),
          ),
        );
      },
      child: Image.asset(widget.imagePath),
    );
  }
}
