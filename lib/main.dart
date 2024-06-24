import 'package:flutter/material.dart';
import 'package:mirror_wall_app/provider/web_provider.dart';
import 'package:mirror_wall_app/screens/bookmark_page/bookmark_page.dart';
import 'package:mirror_wall_app/screens/history_page/history_page.dart';
import 'package:mirror_wall_app/screens/web_view_page/web_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MirrorWall());
}

class MirrorWall extends StatelessWidget {
  const MirrorWall({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => const WebPage(),
          '/bookmark': (context) => const BookmarkPage(),
          '/history': (context) => const HistoryPage(),
        },
      ),
    );
  }
}
