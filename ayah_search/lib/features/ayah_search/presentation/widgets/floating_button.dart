import 'package:ayah_search/features/ayah_search/presentation/controller/ayah_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  final controller = Get.find<AyahSearchController>();
  double paddingQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.switchType,
      onTapDown: (_) => setState(() {
        paddingQuantity = 1.3;
      }),
      onTapUp: (_) => setState(() {
        paddingQuantity = 1;
      }),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 20 * paddingQuantity,
          vertical: 12 * paddingQuantity,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 6),
              blurRadius: 8,
              color: Colors.grey.withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.translate),
            const SizedBox(width: 6),
            Text(controller.getInvertedAyahType()?.toUpperCase() ?? ''),
          ],
        ),
      ),
    );
  }
}
