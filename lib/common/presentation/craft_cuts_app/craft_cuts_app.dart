import 'package:craft_cuts_mobile/auth/presentation/pages/login_page.dart';
import 'package:craft_cuts_mobile/auth/presentation/pages/register_page.dart';
import 'package:craft_cuts_mobile/auth/presentation/pages/sign_in_page.dart';
import 'package:craft_cuts_mobile/common/presentation/injector/widgets/injection_container.dart';
import 'package:craft_cuts_mobile/common/presentation/navigation/route_names.dart';
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
            // Used in login page app logo
            headline1: GoogleFonts.montserrat(
              fontSize: 43.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),

            // Used in page titles
            headline2: GoogleFonts.inter(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
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
              minimumSize: MaterialStateProperty.all(
                Size(double.infinity, 50),
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
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color(0xFFF6F6F6),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE8E8E8),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        initialRoute: RouteNames.loginPage,
        routes: {
          RouteNames.loginPage: (_) => LoginPage(),
          RouteNames.signInPage: (_) => SignInPage(),
          RouteNames.registerPage: (_) => RegisterPage(),
        },
      ),
    );
  }
}
