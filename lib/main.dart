import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_routes.dart';
import 'package:flutter_pos_printing/pages/splashPage/screen_splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('bn')],
        path: 'assets/changed_languages',
        fallbackLocale: const Locale('en'),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// routing
      initialRoute: AppRoutes.splashPageAddress,
      onGenerateRoute: AppRoutes.allRoutes,

      ///localizations
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,

      home: SplashPage(),
    );
  }
}