import 'package:ayah_search/features/ayah_search/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
      height: Get.height * .92,
      width: 100 + Get.width * .4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 3),
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset('assets/icons/app_icon.png'),
          ),
          Spacer(),
          GithubItem(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
