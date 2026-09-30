import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/ui.dart';

class AccessScreen extends StatelessWidget {
  const AccessScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:GradientPage(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:560),child:GlassCard(padding:const EdgeInsets.all(28),child:Column(mainAxisSize:MainAxisSize.min,children:[
    const BrandHeader(),
    Text('Спочатку підтвердіть, хто ви.',style:Theme.of(context).textTheme.bodyMedium,textAlign:TextAlign.center),
    const SizedBox(height:20),
    Row(children:[
      Expanded(child:ChoiceCard(icon:Icons.qr_code_2,title:'Учень або батьки',subtitle:'Показати свій QR-код для підключення до шкільного середовища.',onTap:()=>context.go('/login'))),
      const SizedBox(width:12),
      Expanded(child:ChoiceCard(icon:Icons.verified_user_outlined,title:'Педагог або директор',subtitle:'Підтвердити особу через Дію у демонстраційному сценарії.',onTap:()=>context.go('/diia'))),
    ]),
    const SizedBox(height:18),
    Text('DEMO • QR та Дія відтворені як анімаційний прототип.',style:Theme.of(context).textTheme.bodySmall),
  ]))));
}

class DiiaFlowScreen extends StatefulWidget { const DiiaFlowScreen({super.key}); @override State<DiiaFlowScreen> createState()=>_DiiaFlowScreenState(); }
class _DiiaFlowScreenState extends State<DiiaFlowScreen> {
  int step=0; bool qr=false;
  @override Widget build(BuildContext context)=>Scaffold(body:GradientPage(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:560),child:GlassCard(padding:const EdgeInsets.all(22),child:Column(children:[
    const BrandHeader(),
    SegmentedButton<bool>(segments:const [ButtonSegment(value:false,label:Text('Дія.Підпис')),ButtonSegment(value:true,label:Text('QR'))],selected:{qr},onSelectionChanged:(v)=>setState(()=>qr=v.first)),
    const SizedBox(height:16),
    if(!qr) ...[
      Icon(Icons.account_balance_wallet_rounded,size:76,color:Theme.of(context).colorScheme.primary),
      const SizedBox(height:12),
      InfoCard(title:'Підпис документа',rows:{'Назва':'Є-Гідність • підтвердження особи','Дата':'${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}','Статус':'Очікує підпис'}),
      const SizedBox(height:8),
      OtpRow(step:step),
      const SizedBox(height:8),
      FilledButton(onPressed:step<3?()=>setState(()=>step++):()=>context.go('/login'),child:Text(step<3?'Підтвердити':'Продовжити')),
    ] else ...[
      DiiaQr(),
      FilledButton(onPressed:()=>setState(()=>step=3),child:const Text('Сканувати')),
    ],
    const SizedBox(height:16),
    Steps(active:step),
    if(step>=3) const IdCard(),
  ]))));
}
class OtpRow extends StatelessWidget { const OtpRow({super.key,required this.step}); final int step; @override Widget build(BuildContext c)=>Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(6,(i)=>Container(width:36,height:44,margin:const EdgeInsets.all(3),alignment:Alignment.center,decoration:BoxDecoration(color:Theme.of(c).colorScheme.surfaceContainerHighest,border:Border.all(color:i<step?Theme.of(c).colorScheme.primary:Theme.of(c).colorScheme.outline),borderRadius:BorderRadius.circular(10)),child:Text(i<step?['4','2','8','6','1','9'][i]:'',style:const TextStyle(fontSize:18,fontWeight:FontWeight.w800))))); }
class Steps extends StatelessWidget { const Steps({super.key,required this.active}); final int active; @override Widget build(BuildContext c)=>Column(children:List.generate(5,(i)=>ListTile(dense:true,leading:CircleAvatar(radius:10,backgroundColor:i<=active?Theme.of(c).colorScheme.primary:Theme.of(c).colorScheme.surfaceContainerHighest,child:i<=active?const Icon(Icons.check,size:12,color:Colors.white):null),title:Text(['Метод підтвердження','Документ','OTP','QR/перевірка','ID-картка'][i])))); }
