import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fruit_basket/services/model_hud.dart';
import 'package:provider/provider.dart';
import 'services/admin_mode.dart';
import 'app.dart';
import 'package:fruit_basket/models/auth_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (context)=>AuthViewModel(),
        ),
        ChangeNotifierProvider<Modelhud>(
          create: (context)=>Modelhud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context)=>AdminMode(),
        ),
      ],
      child: App()));
}

