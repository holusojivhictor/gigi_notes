import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gigi_notes/data/sqlite/sqlite_repository.dart';

import 'package:gigi_notes/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final repository = SqliteRepository();
    await repository.init();
    await tester.pumpWidget(GigiNotes(repository: repository));
  });
}
