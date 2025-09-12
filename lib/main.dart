import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:poke_api/core/di/service_locator.dart';
import 'package:poke_api/features/main_screen/presentation/manager/pokemon_cubit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poke_api/features/main_screen/presentation/pages/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonCubit>(
          create: (context) => getIt<PokemonCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Poke API',
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
