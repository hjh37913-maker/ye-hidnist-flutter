import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local_storage.dart';
import '../../data/models/models.dart';

final themeProvider = StateProvider<bool>((ref) => false);
final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier(): super(null) { _load(); }
  Future<void> _load() async {
    final s = await LocalStorage.session();
    if (s != null) {
      state = UserModel(id: s['id'], name: s['name'], role: UserRole.values.byName(s['role']), className: s['className'], diiaVerified: s['diia'] == true, isOnline: true);
    }
  }
  Future<void> login({required String name, required UserRole role}) async {
    final user = UserModel(id:'session', name:name, role:role, className:'8-Б', diiaVerified:true, isOnline:true);
    state = user;
    await LocalStorage.setSession({'id':user.id,'name':user.name,'role':user.role.name,'className':user.className,'diia':true});
  }
  Future<void> logout() async { state=null; await LocalStorage.clearSession(); }
}

final usersProvider = Provider<List<UserModel>>((ref) => List.generate(18,(i)=>UserModel(id:'u$i',name:['Олексій Коваль','Марія Шевченко','Дмитро Бондар','Анна Мельник'][i%4],role:UserRole.values[i%4],className:'${5+i%4}-А',isOnline:i%3!=0,diiaVerified:i%2==0)));
final classesProvider = Provider<List<SchoolClassModel>>((ref)=>List.generate(7,(i)=>SchoolClassModel(id:'c$i',name:'${5+i}-А',membersCount:18+i,homeroomTeacherName:'Анна Мельник')));
final chatsProvider = Provider<List<ChatModel>>((ref)=>List.generate(12,(i)=>ChatModel(id:'chat$i',name:['8-Б • Клас','Учительська','Батьки 8-Б','Математика','Шкільні новини','Дирекція','Шаховий клуб','9-А • Клас','Історія','Медіацентр','Паралель 8-х','Адміністрація'][i],type:i%3==0?ChatType.classChat:ChatType.personal,membersCount:8+i*2,unreadCount:i%4==0?1:0,lastMessage:'Останнє демонстраційне повідомлення',lastMessageTime:DateTime.now().subtract(Duration(minutes:i*17)))));
final messagesProvider = Provider.family<List<MessageModel>, String>((ref, chatId)=>List.generate(10,(i)=>MessageModel(id:'${chatId}_$i',chatId:chatId,authorId:i%2==0?'session':'u3',authorName:i%2==0?'Олексій Коваль':'Анна Мельник',text:['Привіт!','Нагадую про подію.','Все готово.','Дякую!','Зустрічаємось після уроків.','Оновив інформацію.','Гарного дня!','Є ще питання?','Так, звичайно.','До зустрічі!'][i],createdAt:DateTime.now().subtract(Duration(minutes:i*11)),reactions:i==2?{'❤️':2,'👍':1}:{})));
final newsProvider = Provider<List<NewsItemModel>>((ref)=>List.generate(6,(i)=>NewsItemModel(id:'n$i',title:['Олімпіада з математики','День школи','Новий гурток робототехніки','Тиждень безпеки','Спортивні змагання','Відкриття медіацентру'][i],text:'Демонстраційна новина Є-Гідності з локальним контентом.',createdAt:DateTime.now().subtract(Duration(days:i)))));
final reportsProvider = Provider<List<ReportModel>>((ref)=>List.generate(6,(i)=>ReportModel(id:'r$i',description:'Демонстраційна скарга №${i+1}',status:ReportStatus.values[i%3],createdAt:DateTime.now().subtract(Duration(days:i)))));
final adminStatsProvider = Provider<Map<String,int>>((ref)=>{'Користувачі':18,'Класи':7,'Чати':12,'Повідомлення':84,'Новини':6,'Скарги':6});
