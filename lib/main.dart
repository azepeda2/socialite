import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/blocs/simple_bloc_observer.dart';
import 'package:social_media/repositories/repositories.dart';
import 'package:social_media/screens/screens.dart';

import 'blocs/blocs.dart';
import 'config/custom_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        RepositoryProvider<PostRepository>(
          create: (_) => PostRepository(),
        ),
      ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => 
                    AuthBloc(authRepository: context.read<AuthRepository>()),
              ),
            ],
                      child: MaterialApp(
        title: 'Socialite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(
              brightness: Brightness.light, 
              color: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
        ),onGenerateRoute: CustomRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
          ),
    );
  }
}


