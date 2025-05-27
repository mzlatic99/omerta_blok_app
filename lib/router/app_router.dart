// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omerta_block_app/router/app_route.dart';
import 'package:omerta_block_app/screens/home/presentation/home_page.dart';

import '../screens/game/presentation/game_page.dart';
import '../screens/result/presentation/score_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoute.start.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/game',
        name: AppRoute.game.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final count = state.extra as int;
          return GamePage(playerCount: count);
        },
      ),
      GoRoute(
        path: '/scores',
        name: AppRoute.scores.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return ScoreScreen();
        },
      ),
    ],
  );
});
