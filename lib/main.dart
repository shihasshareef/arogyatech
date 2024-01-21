import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:arogya/screens/appointment_screen.dart';
import 'package:arogya/providers/appointment_provider.dart';

import 'common/environment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ArogyaEnvironment().setEnvironment();
    return ScreenUtilInit(
      designSize: const Size(360, 789),
      minTextAdapt: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AppointmentProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Arogya Tech',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AppointmentScreen(title: 'Arogya Tech'),
        ),
      ),
    );
  }
}
