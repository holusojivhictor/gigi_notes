import 'package:flutter/material.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/models.dart';
import 'package:gigi_notes/models/profile_manager.dart';
import 'package:gigi_notes/screens/home/home_screen.dart';
import 'package:gigi_notes/theme.dart';
import 'package:provider/provider.dart';
import 'data/sqlite/sqlite_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = SqliteRepository();
  await repository.init();
  runApp(GigiNotes(repository: repository));
}

class GigiNotes extends StatelessWidget {
  final Repository repository;
  GigiNotes({Key? key, required this.repository}) : super(key: key);

  final _profileManager = ProfileManager();
  final _noteManager = NoteManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          lazy: false,
          create: (_) => repository,
          dispose: (_, Repository repository) => repository.close(),
        ),
        ChangeNotifierProvider(create: (context) => _profileManager),
        ChangeNotifierProvider(create: (context) => _noteManager),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = GigiNotesTheme.dark();
          } else {
            theme = GigiNotesTheme.light();
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gigi Notes',
            theme: theme,
            home: HomeScreen(user: profileManager.getUser),
          );
        },
      ),
    );
  }
}
