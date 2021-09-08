import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.ayah,
  }) : super(key: key);

  final Ayah ayah;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/${ayah.revelationType}.svg',
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 8),
              Text(
                '${ayah.surahName} : ${ayah.ayahNumber}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ayah.surahNameTranslation,
                style: Get.textTheme.subtitle1,
              ),
              const SizedBox(width: 8),
              Visibility(
                visible: ayah.sajda,
                child: SvgPicture.asset('assets/icons/jainamaz.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
