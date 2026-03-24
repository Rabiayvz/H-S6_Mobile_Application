import 'package:flutter/material.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/object_search/presentation/pages/object_search_page.dart';
import '../features/obstacle_detection/presentation/pages/obstacle_detection_page.dart';
import '../features/video_call/presentation/pages/video_call_page.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3 Container Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.obstacleDetection: (context) => const ObstacleDetectionPage(),
        AppRoutes.objectSearch: (context) => const ObjectSearchPage(),
        AppRoutes.videoCall: (context) => const VideoCallPage(),
      },
    );
  }
}
