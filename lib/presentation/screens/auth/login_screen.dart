import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_providers.dart';
import '../../widgets/ui.dart';
import '../../../data/models/models.dart';

class LoginScreen extends ConsumerStatefulWidget { const LoginScreen({super.key}); @override ConsumerState<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends ConsumerState<LoginScreen> {
  final name=TextEditingController(text:'Олексій Коваль'); UserRole role=UserRole.student;
  @override Widget build(BuildContext c)=>Scaffold(body:GradientPage(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:500),child:GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    const BrandHeader(),const SizedBox(height:18),
    TextField(controller:name,decoration:const InputDecoration(labelText:'Ім’я')),
    const SizedBox(height:12),
    DropdownButtonFormField<String>(value:'Школа №1',items:['Школа №1','Ліцей №2','Гімназія №3'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(_){},decoration:const InputDecoration(labelText:'Школа')),
    const SizedBox(height:14),
    Text('Роль',style:Theme.of(c).textTheme.labelLarge),const SizedBox(height:7),
    Wrap(spacing:8,runSpacing:8,children:UserRole.values.map((r)=>ChoiceChip(label:Text(switch(r){UserRole.student=>'Учень',UserRole.teacher=>'Вчитель',UserRole.parent=>'Батьки',UserRole.admin=>'Адміністратор'}),selected:role==r,onSelected:(_)=>setState(()=>role=r))).toList()),
    const SizedBox(height:12),Chip(avatar:const Icon(Icons.verified,size:16),label:Text('Підтверджено через Дію')),
    const SizedBox(height:14),
    FilledButton(onPressed:()=>ref.read(authProvider.notifier).login(name:name.text,role:role),child:const Text('Увійти')),
  ]))));
}
