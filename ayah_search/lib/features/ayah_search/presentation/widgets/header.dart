import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_business_outlined,
                size: 30,
              ),
              const SizedBox(width: 8),
              Text(
                'Al-Fatiha',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The opening',
                style: Get.textTheme.subtitle1,
              ),
              const SizedBox(width: 8),
              Icon(Icons.ad_units_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

