import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/routes/routes_generators.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/theme/app_theme.dart';
import 'package:lmg_todo/todo%20app%20/domain/core/bindings/all_bindings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'LMG TODO',
        debugShowCheckedModeBanner: false,
        initialBinding: AllControllerBindings(),
        theme: AppThemes.lightTheme(),
        darkTheme: AppThemes.lightTheme(),
        getPages: RouteGenerator.routes,
      ),
    );
  }
}
