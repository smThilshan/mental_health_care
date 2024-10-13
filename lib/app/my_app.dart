import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bloc/dashboard_view/dashboard_view_bloc.dart';
import 'package:mental_health/presentation/bloc/doctor_appointments/doctor_appointments_bloc.dart';
import 'package:mental_health/presentation/bloc/doctor_chats/doctor_chats_bloc.dart';
import 'package:mental_health/presentation/bloc/public_chats/public_chats_bloc.dart';
import 'package:mental_health/presentation/bloc/saved_appointments/saved_appointments_bloc.dart';
import 'package:mental_health/presentation/bloc/signin_page/signin_page_bloc.dart';
import 'package:mental_health/presentation/bloc/specialists_page/specialists_view_bloc.dart';
import 'package:mental_health/presentation/views/sign_in_page/sign_in_page.dart';

import '../presentation/views/dashboard_view/dashboard_view.dart';
// Import your blocs here

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SavedAppointmentsBloc>(create: (context) => SavedAppointmentsBloc()),
        BlocProvider<DashboardViewBloc>(create: (context) => DashboardViewBloc()),
        BlocProvider<SpecialistsViewBloc>(create: (context) => SpecialistsViewBloc()),
        BlocProvider<SigninPageBloc>(create: (context) => SigninPageBloc()),
        BlocProvider<DoctorChatsBloc>(create: (context) => DoctorChatsBloc()),
        BlocProvider<PublicChatsBloc>(create: (context) => PublicChatsBloc()),
        BlocProvider<DoctorAppointmentsBloc>(create: (context) => DoctorAppointmentsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
      ),
    );
  }
}
