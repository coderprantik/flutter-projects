import 'package:ayah_search/features/ayah_search/presentation/controller/ayah_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlWidget extends GetWidget<AyahSearchController> {
  const ControlWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.symmetric(horizontal: 18),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 3),
                  blurRadius: 8,
                  color: Colors.grey.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController,
                    onSubmitted: (_) => controller.getArabicAyah(),
                    decoration: InputDecoration(
                      hintText: "Search here... (2:255)",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      // surffix isn't working properly  with SVG
                      // thats why we use row
                      // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ],
    );
  }
}
