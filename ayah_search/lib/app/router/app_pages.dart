import 'package:ayah_search/features/ayah_search/presentation/pages/ayah_search_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.AYAH_SEARCH, page: () => AyahSearchPage())
  ];
}
