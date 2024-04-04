import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horecah_assignment/views/create_personal_form.dart';

import 'constant/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");

  Gemini.init(apiKey: dotenv.env["GOOGLE_API_KEY"].toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horecah Assignment',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor.withOpacity(0.99),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
          dialogTheme: const DialogTheme(
            surfaceTintColor: AppColors.whiteColor,
          )),
      home: const CreatePersonalForm(),
    );
  }
}
