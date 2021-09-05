import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import 'shared_preferences.mocks.dart';

// @GenerateMocks([SharedPreferences])
void main() {
  late AyahSearchLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AyahSearchLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
}
