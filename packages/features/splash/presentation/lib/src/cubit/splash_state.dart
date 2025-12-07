part of 'splash_cubit.dart';

sealed class SplashState {}

class SplashInitial extends SplashState {}

class SplashChecking extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}
