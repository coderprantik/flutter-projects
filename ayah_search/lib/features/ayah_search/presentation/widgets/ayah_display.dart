import 'package:ayah_search/features/ayah_search/data/models/ayah_model.dart';
import 'package:ayah_search/features/ayah_search/domain/entities/ayah.dart';
import 'package:ayah_search/features/ayah_search/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AyahDisplay extends StatelessWidget {
  const AyahDisplay({
    Key? key,
    required this.ayah,
  }) : super(key: key);

  final Ayah ayah;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Header(ayah: ayah),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ayah.type == 'quran'
                    ? SelectableText(
                        ayah.text + '\n\n',
                        style: TextStyle(fontSize: 32),
                        textDirection: TextDirection.rtl,
                      )
                    : SelectableText(
                        ayah.text + '\n\n',
                        style: TextStyle(fontSize: 26),
                      ),
                Visibility(
                  visible: ayah.type == AyahType.TRANSLATION,
                  child: TranslatedBy(name: ayah.editionName),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
