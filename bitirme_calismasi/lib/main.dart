import 'package:bitirme_calismasi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_calismasi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:bitirme_calismasi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_calismasi/ui/views/anasayfa.dart';
import 'package:bitirme_calismasi/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

