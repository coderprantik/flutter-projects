import 'package:ayah_search/app/responsive/responsive_builder.dart';
import 'package:ayah_search/app/router/app_pages.dart';
import 'package:ayah_search/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await setUp();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ayah Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik', primarySwatch: Colors.green),
      initialRoute: Routes.AYAH_SEARCH,
      builder: (context, child) => ResponsiveBuilder(child: child),
      getPages: AppPages.pages,
    );
  }
}
