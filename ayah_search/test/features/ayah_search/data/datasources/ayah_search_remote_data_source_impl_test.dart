import 'package:ayah_search/features/ayah_search/data/datasources/ayah_search_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dio.mocks.dart';

// @GenerateMocks([Dio])
void main() {
  late AyahSearchRemoteDataSourceImpl dataSource;
  late MockDio mockClient;

  setUp(() {
    mockClient = MockDio();
    dataSource = AyahSearchRemoteDataSourceImpl(client: mockClient);
  });
}
