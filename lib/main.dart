import 'package:date_bloc/dependency_injector.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:date_bloc/features/date/presentation/screens/home_screen.dart';
import 'package:date_bloc/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:date_bloc/dependency_injector.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => sl<DateBloc>(),
        child: MyHomeScreen(),
      ),
    );
  }
}
