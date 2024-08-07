import 'package:flutter_test/flutter_test.dart';
import 'package:rideshare/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FirServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
