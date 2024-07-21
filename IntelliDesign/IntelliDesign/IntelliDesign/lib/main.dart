import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intellidesign/LandArea.dart';
import 'package:intellidesign/firebase_options.dart';
import 'package:intellidesign/genfloorpalndisplay.dart';
import 'package:intellidesign/homepage.dart';
import 'package:intellidesign/inputresidential.dart';
import 'package:intellidesign/mainscreen.dart';
import 'package:intellidesign/optionsearch.dart';
import 'package:intellidesign/signin.dart';
import 'package:intellidesign/signup.dart';
import 'package:intellidesign/successfullysignup.dart';
import 'package:intellidesign/remainingarea.dart';
import 'package:intellidesign/houseoption.dart';
import 'package:intellidesign/preferenceslist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntelliDesign',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 226, 228, 236),
        ),
        useMaterial3: true,
      ),
      initialRoute: mainscreen.screenRoute,
      routes: {
        mainscreen.screenRoute: (context) => const mainscreen(),
        signup.screenRoute: (context) => const signup(),
        successfullysignup.screenRoute: (context) => const successfullysignup(),
        signin.screenRoute: (context) => const signin(),
        homepage.screenRoute: (context) => const homepage(),
        InputResidential.screenRoute: (context) => const InputResidential(),
        houseoption.screenRoute: (context) => const houseoption(housearea: 0),
        // genfloorpalndisplay.screenRoute: (context) =>
        //     const genfloorpalndisplay(imgurl: ),
      },
      onGenerateRoute: (settings) {
        // Handle LandArea routing dynamically
        if (settings.name == LandArea.screenRoute) {
          final args = settings.arguments as Map<String, dynamic>?;

          // Ensure that args is not null and contains 'selectedAreaType'
          if (args != null && args.containsKey('selectedAreaType')) {
            return MaterialPageRoute(
              builder: (context) {
                return LandArea(selectedAreaType: args['selectedAreaType']);
              },
            );
          }
        }
        if (settings.name == RemainingArea.screenRoute) {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args != null && args.containsKey('remainland')) {
            final double remainland = args['remainland'];
            return MaterialPageRoute(
              builder: (context) {
                return RemainingArea(remainland: remainland);
              },
            );
          }
        }
        if (settings.name == houseoption.screenRoute) {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('housearea')) {
            final double housearea = args['housearea'];
            return MaterialPageRoute(
              builder: (context) {
                return houseoption(housearea: housearea);
              },
            );
          }
        }
        if (settings.name == preferenceslist.screenRoute) {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('housearea')) {
            final double housearea = args['housearea'];
            return MaterialPageRoute(
              builder: (context) {
                return preferenceslist(housearea: housearea);
              },
            );
          }
        }
        // Handle other routes...
        if (settings.name == optionsearch.screenRoute) {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('housearea')) {
            final double housearea = args['housearea'];
            return MaterialPageRoute(
              builder: (context) {
                return optionsearch(housearea: housearea);
              },
            );
          }
        }
        return null;

        // If args is null or doesn't contain the required data, return null
        // and handle the error where onGenerateRoute is called
      },
    );
  }
}
