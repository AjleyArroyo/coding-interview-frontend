import 'package:coding_interview_frontend/modules/calculator/data/repositories/calculator_repository_imp.dart';
import 'package:coding_interview_frontend/modules/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:coding_interview_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/calculator',
      builder: (context, state) {
        // Import the Calculator widget here to avoid circular dependencies
        // and to ensure that the widget is only loaded when this route is accessed.
        return BlocProvider(
          create: (_) =>
              CalculatorBloc(CalculatorRepositoryImpl())..add(LoadCurrencies()),
          child: CalculatorPage(),
        );
      },
    ),
  ],
  initialLocation: '/calculator',
  errorBuilder: (context, state) {
    // Handle errors gracefully, e.g., show an error page or a message.
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Error: ${state.error}')),
    );
  },
);
