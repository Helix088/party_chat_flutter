import 'package:camera/camera.dart';
import 'package:flash_chat_flutter/components/protected_route.dart';
import 'package:flash_chat_flutter/components/theme_provider.dart';
import 'package:flash_chat_flutter/screens/chats/list_chats_screen.dart';
import 'package:flash_chat_flutter/screens/forgot_password.dart';
import 'package:flash_chat_flutter/screens/settings.dart';
import 'package:flash_chat_flutter/screens/take_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chats/chat_screen.dart';
import 'screens/people_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(), child: const PartyChat()));
}

class PartyChat extends StatelessWidget {
  const PartyChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          return MaterialApp(
            initialRoute: WelcomeScreen.id,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ChatScreen.id: (context) => ChatScreen(
                    chatId: ChatScreen.id,
                    users: [],
                  ),
              ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
              ListChatsScreen.id: (context) => ProtectedRoute(
                    screen: ListChatsScreen(),
                  ),
              SettingsScreen.id: (context) => SettingsScreen(),
              ImagePickerScreen.id: (context) => ImagePickerScreen(),
              // TakePictureScreen.id: (context) => TakePictureScreen(
              //       camera: CameraDescription(
              //           lensDirection: CameraLensDirection.back,
              //           name: 'Back Camera',
              //           sensorOrientation: 0),
              //     ),
              PeopleScreen.id: (context) => PeopleScreen(),
            },
            builder: EasyLoading.init(),
          );
        },
      );
}
