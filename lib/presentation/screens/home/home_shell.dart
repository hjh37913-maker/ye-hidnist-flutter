import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_providers.dart';
import '../../widgets/glass_bottom_nav.dart';
import '../../../data/models/models.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key,required this.child}); final Widget child;
  int _index(String p)=>p.contains('/chats')?0:p.contains('/communities')?1:p.contains('/news')?2:p.contains('/profile')?3:4;
  @override Widget build(BuildContext c,WidgetRef ref){
    final u=ref.watch(authProvider); final i=_index(GoRouterState.of(c).uri.path);
    return Scaffold(body:Row(children:[
      if(MediaQuery.sizeOf(c).width>760) SizedBox(width:236,child:_Sidebar(admin:u?.role==UserRole.admin,index:i)),
      Expanded(child:Column(children:[
        Container(height:56,color:Theme.of(c).brightness==Brightness.dark?const Color(0xFF060D18):const Color(0xFF0C3563),padding:const EdgeInsets.symmetric(horizontal:20),child:Row(children:[const Text('Є-Гідність',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w800)),const Spacer(),Text(u?.name??'',style:const TextStyle(color:Colors.white70))])),
        Expanded(child:child),
        if(MediaQuery.sizeOf(c).width<=760) GlassBottomNav(index:i,isAdmin:u?.role==UserRole.admin),
      ])),
    ]));
  }
}
class _Sidebar extends StatelessWidget { const _Sidebar({required this.admin,required this.index}); final bool admin; final int index; @override Widget build(BuildContext c)=>Container(color:Theme.of(c).brightness==Brightness.dark?const Color(0xFF060D18):const Color(0xFF0C3563),padding:const EdgeInsets.all(10),child:Column(children:[
  for(final x in [(Icons.chat_outlined,'Чати','/home/chats'),(Icons.groups_outlined,'Спільноти','/home/communities'),(Icons.newspaper_outlined,'Новини','/home/news'),(Icons.person_outline,'Профіль','/home/profile')]) ListTile(leading:Icon(x.$1,color:Colors.white70),title:Text(x.$2,style:const TextStyle(color:Colors.white)),onTap:()=>GoRouter.of(c).go(x.$3)),
  const Spacer(),if(admin) ListTile(leading:const Icon(Icons.admin_panel_settings_outlined,color:Colors.white70),title:const Text('Адмін',style:TextStyle(color:Colors.white)),onTap:()=>GoRouter.of(c).go('/admin')),
]));}
