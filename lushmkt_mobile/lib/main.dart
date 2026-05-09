import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/views/splash/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LushMktApp());
}

class LushMktApp extends StatelessWidget {
  const LushMktApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LushMKT',
      debugShowCheckedModeBanner: false,
      
      // Theme Mode default to Dark for the Cyber/MMO premium aesthetic
      themeMode: ThemeMode.dark,
      
      // Premium Cyber Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0F14), // Deep Space Blue/Black
        primaryColor: const Color(0xFF00E5FF), // Cyber Neon Cyan
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF7000FF), // Neon Purple
          background: Color(0xFF0D0F14),
          surface: Color(0xFF161B22), // Card dark background
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          error: Color(0xFFFF2D55),
        ),
        textTheme: GoogleFonts.orbitronTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF161B22).withOpacity(0.8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: const Color(0xFF00E5FF).withOpacity(0.15),
              width: 1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF161B22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      
      home: const SplashView(),
    );
  }
}
