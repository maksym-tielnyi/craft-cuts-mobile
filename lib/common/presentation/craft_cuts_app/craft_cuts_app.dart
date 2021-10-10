import 'package:craft_cuts_mobile/auth/presentation/pages/login_page.dart';
import 'package:craft_cuts_mobile/common/presentation/injector/widgets/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CraftCutsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectionContainer(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFB02222),
          textTheme: TextTheme(
            headline1: GoogleFonts.montserrat(
              fontSize: 43.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.light(
            primary: Color(0xFFB02222),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                GoogleFonts.inter(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => LoginPage(),
        },
      ),
    );
  }
}
