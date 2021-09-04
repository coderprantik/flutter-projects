// @GenerateMocks([ConnectionChecker])
import 'package:ayah_search/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockConnectionChecker);
  });

  group('hasConnection', () {
    test(
      'should forward the call to ConnectionChecker.hasConnection',
      () async {
        // arrange
        when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
        // act
        final result = await networkInfoImpl.hasConnection;
        // assert
        verify(mockConnectionChecker.hasConnection);
        expect(result, true);
      },
    );
  });
}
