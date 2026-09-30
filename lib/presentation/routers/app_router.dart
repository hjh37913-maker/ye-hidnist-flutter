import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_providers.dart';
import '../screens/access/access_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_shell.dart';
import '../screens/chats/chat_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/qr_screen.dart';
import '../screens/teacher/scan_qr_screen.dart';
import '../screens/admin/admin_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    initialLocation: auth == null ? '/access' : '/home/chats',
    refreshListenable: GoRouterRefreshStream(ref.watch(authProvider.notifier).stream),
    redirect: (context,state) {
      final logged = ref.read(authProvider) != null;
      if (!logged && !['/access','/diia','/login'].contains(state.matchedLocation)) return '/access';
      if (logged && ['/access','/login','/diia'].contains(state.matchedLocation)) return '/home/chats';
      return null;
    },
    routes: [
      GoRoute(path:'/access',builder:(c,s)=>const AccessScreen()),
      GoRoute(path:'/diia',builder:(c,s)=>const DiiaFlowScreen()),
      GoRoute(path:'/login',builder:(c,s)=>const LoginScreen()),
      ShellRoute(builder:(c,s,child)=>HomeShell(child:child),routes:[
        GoRoute(path:'/home/chats',builder:(c,s)=>const ChatsListScreen()),
        GoRoute(path:'/home/chats/:chatId',builder:(c,s)=>ChatScreen(chatId:s.pathParameters['chatId']!)),
        GoRoute(path:'/home/communities',builder:(c,s)=>const CommunitiesScreen()),
        GoRoute(path:'/home/news',builder:(c,s)=>const NewsScreen()),
        GoRoute(path:'/home/profile',builder:(c,s)=>const ProfileScreen()),
        GoRoute(path:'/home/profile/settings',builder:(c,s)=>const SettingsScreen()),
        GoRoute(path:'/home/profile/security',builder:(c,s)=>const SecurityScreen()),
        GoRoute(path:'/home/profile/qr',builder:(c,s)=>const QrScreen()),
        GoRoute(path:'/home/profile/scan',builder:(c,s)=>const ScanQrScreen()),
      ]),
      GoRoute(path:'/admin',builder:(c,s)=>const AdminScreen()),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) { stream.listen((_)=>notifyListeners()); }
}
