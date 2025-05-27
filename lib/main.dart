import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:omerta_block_app/router/app_router.dart';
import 'package:omerta_block_app/screens/game/models/player.dart';
import 'package:omerta_block_app/theme/app_themes.dart';

import 'screens/result/models/game_result.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PlayerAdapter());
  await Hive.openBox<Player>('players');

  Hive.registerAdapter(GameResultAdapter());
  await Hive.openBox<GameResult>('results');

  runApp(const ProviderScope(child: OmertaApp()));
}

class OmertaApp extends StatelessWidget {
  const OmertaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final goRouter = ref.watch(goRouterProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Omerta Blok',
          theme: AppThemes.primary(),
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
