import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyahSearchPage extends StatelessWidget {
  const AyahSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Search here... (e.g. 2:255)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Card(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.translate),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                text,
                style: TextStyle(fontSize: 32),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final text = '''
\u0627\u0644\u0644\u0651\u064e\u0647\u064f \u0644\u064e\u0627 \u0625\u0650\u0644\u064e\u0670\u0647\u064e \u0625\u0650\u0644\u0651\u064e\u0627 \u0647\u064f\u0648\u064e \u0627\u0644\u0652\u062d\u064e\u064a\u0651\u064f \u0627\u0644\u0652\u0642\u064e\u064a\u0651\u064f\u0648\u0645\u064f \u06da \u0644\u064e\u0627 \u062a\u064e\u0623\u0652\u062e\u064f\u0630\u064f\u0647\u064f \u0633\u0650\u0646\u064e\u0629\u064c \u0648\u064e\u0644\u064e\u0627 \u0646\u064e\u0648\u0652\u0645\u064c \u06da \u0644\u064e\u0647\u064f \u0645\u064e\u0627 \u0641\u0650\u064a \u0627\u0644\u0633\u0651\u064e\u0645\u064e\u0627\u0648\u064e\u0627\u062a\u0650 \u0648\u064e\u0645\u064e\u0627 \u0641\u0650\u064a \u0627\u0644\u0652\u0623\u064e\u0631\u0652\u0636\u0650 \u06d7 \u0645\u064e\u0646\u0652 \u0630\u064e\u0627 \u0627\u0644\u0651\u064e\u0630\u0650\u064a \u064a\u064e\u0634\u0652\u0641\u064e\u0639\u064f \u0639\u0650\u0646\u0652\u062f\u064e\u0647\u064f \u0625\u0650\u0644\u0651\u064e\u0627 \u0628\u0650\u0625\u0650\u0630\u0652\u0646\u0650\u0647\u0650 \u06da \u064a\u064e\u0639\u0652\u0644\u064e\u0645\u064f \u0645\u064e\u0627 \u0628\u064e\u064a\u0652\u0646\u064e \u0623\u064e\u064a\u0652\u062f\u0650\u064a\u0647\u0650\u0645\u0652 \u0648\u064e\u0645\u064e\u0627 \u062e\u064e\u0644\u0652\u0641\u064e\u0647\u064f\u0645\u0652 \u06d6 \u0648\u064e\u0644\u064e\u0627 \u064a\u064f\u062d\u0650\u064a\u0637\u064f\u0648\u0646\u064e \u0628\u0650\u0634\u064e\u064a\u0652\u0621\u064d \u0645\u0650\u0646\u0652 \u0639\u0650\u0644\u0652\u0645\u0650\u0647\u0650 \u0625\u0650\u0644\u0651\u064e\u0627 \u0628\u0650\u0645\u064e\u0627 \u0634\u064e\u0627\u0621\u064e \u06da \u0648\u064e\u0633\u0650\u0639\u064e \u0643\u064f\u0631\u0652\u0633\u0650\u064a\u0651\u064f\u0647\u064f \u0627\u0644\u0633\u0651\u064e\u0645\u064e\u0627\u0648\u064e\u0627\u062a\u0650 \u0648\u064e\u0627\u0644\u0652\u0623\u064e\u0631\u0652\u0636\u064e \u06d6 \u0648\u064e\u0644\u064e\u0627 \u064a\u064e\u0626\u064f\u0648\u062f\u064f\u0647\u064f \u062d\u0650\u0641\u0652\u0638\u064f\u0647\u064f\u0645\u064e\u0627 \u06da \u0648\u064e\u0647\u064f\u0648\u064e \u0627\u0644\u0652\u0639\u064e\u0644\u0650\u064a\u0651\u064f \u0627\u0644\u0652\u0639\u064e\u0638\u0650\u064a\u0645\u064f''';
