import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:blood/providers/auth_provider.dart';
import 'package:blood/screens/home_screen.dart';
import 'package:blood/screens/login_screen.dart';
import 'package:blood/screens/signup_screen.dart';

final goRouter = GoRouter(
  redirect: (context, state) {
    final authState = Provider.of<AuthProvider>(context, listen: false).status;
    final isLoggingIn = state.matchedLocation == LoginScreen.routeName;
    final isSigningUp = state.matchedLocation == SignupScreen.routeName;
    if (authState == AuthStatus.authenticated && (isLoggingIn || isSigningUp)) {
      return HomeScreen.routeName;
    }
    if (authState == AuthStatus.unauthenticated &&
        !isLoggingIn &&
        !isSigningUp) {
      return LoginScreen.routeName;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: SignupScreen.routeName,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
