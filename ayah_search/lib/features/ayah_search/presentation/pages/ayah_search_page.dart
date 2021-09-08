import 'package:ayah_search/features/ayah_search/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyahSearchPage extends StatelessWidget {
  const AyahSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              ControlWidget(),
              const SizedBox(height: 16),
              Header(),
              const SizedBox(height: 20),
              AyahDisplay(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
