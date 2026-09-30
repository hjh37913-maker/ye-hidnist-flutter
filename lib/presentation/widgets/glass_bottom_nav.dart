import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlassBottomNav extends StatelessWidget {
  const GlassBottomNav({super.key, required this.index, required this.isAdmin});
  final int index;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final items = [
      (IconsaxProxy.chat, 'Чати', '/home/chats'),
      (IconsaxProxy.people, 'Спільноти', '/home/communities'),
      (IconsaxProxy.news, 'Новини', '/home/news'),
      (IconsaxProxy.profile, 'Профіль', '/home/profile'),
      if (isAdmin) (IconsaxProxy.shield, 'Адмін', '/admin'),
    ];
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          height: 62,
          margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withValues(alpha:.08) : Colors.white.withValues(alpha:.42),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha:.28)),
            boxShadow: const [BoxShadow(blurRadius:28,offset:Offset(0,14),color:Color(0x24102B4A))],
          ),
          child: LayoutBuilder(builder:(context,box){
            final width = box.maxWidth/items.length;
            return Stack(children:[
              AnimatedPositioned(
                duration: const Duration(milliseconds:450),
                curve: Curves.easeOutCubic,
                left: width*index,
                top:0,bottom:0,width:width,
                child: DecoratedBox(decoration:BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha:.14),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha:.18)),
                )),
              ),
              Row(children:[
                for(int i=0;i<items.length;i++)
                  Expanded(child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: ()=>context.go(items[i].$3),
                    child: Column(mainAxisAlignment:MainAxisAlignment.center,children:[
                      Icon(items[i].$1,size:22,color:i==index?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onSurfaceVariant),
                      Text(items[i].$2,style:TextStyle(fontSize:10.5,fontWeight:FontWeight.w600,color:i==index?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onSurfaceVariant)),
                    ]),
                  )),
              ]),
            ]);
          }),
        ),
      ),
    );
  }
}
class IconsaxProxy {
  static const chat=Icons.chat_bubble_outline, people=Icons.groups_outlined, news=Icons.newspaper_outlined, profile=Icons.person_outline, shield=Icons.admin_panel_settings_outlined;
}
