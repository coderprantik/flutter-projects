import 'package:ayah_search/features/ayah_search/presentation/controller/ayah_search_controller.dart';
import 'package:ayah_search/features/ayah_search/presentation/widgets/end_drawer.dart';
import 'package:ayah_search/features/ayah_search/presentation/widgets/error_message_display.dart';
import 'package:ayah_search/features/ayah_search/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyahSearchPage extends GetWidget<AyahSearchController> {
  const AyahSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              ControlWidget(),
              Obx(
                () => Expanded(
                  child: getState(controller.state.value),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: controller.getInvertedAyahType() != null,
          child: FloatingButton(),
        ),
      ),
      endDrawer: EndDrawer(),
    );
  }

  Widget getState(AyahSearchState state) {
    switch (state.runtimeType) {
      case Loading:
        return Center(child: CircularProgressIndicator());
      case Loaded:
        return AyahDisplay(ayah: (state as Loaded).ayah);
      case Error:
        return ErrorMessageDisplay(message: (state as Error).message);
      default:
        return Center(
          child: Text('Assalamualaikum', style: TextStyle(fontSize: 20)),
        );
    }
  }
}
