import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywallet/controller/imageController.dart';
import 'package:mywallet/pages/main_page.dart';
import 'package:mywallet/pages/start%20up%20pages/auth/login_page.dart';
import 'package:mywallet/pages/start%20up%20pages/splash%20screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_)=> ImageController()),
      ],

      child: GetMaterialApp(
      
        debugShowCheckedModeBanner: false,
      
        title: 'My wallet',
      
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      
        home: const SplashScreen(),//FirebaseAuth.instance.currentUser != null ? const MainPage() : const LoginPage(),
      
      ),
    );
  }
}
