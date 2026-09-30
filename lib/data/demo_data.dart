import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class DemoData {
  static const boxName = 'ye_hidnist';
  static Future<void> ensureInitialized() async {
    final box = await Hive.openBox(boxName);
    if (box.get('seeded') == true) return;

    final users = List.generate(18, (i) => {
      'id': 'u$i',
      'name': ['Олексій Коваль','Марія Шевченко','Дмитро Бондар','Анна Мельник','Ірина Ткач','Максим Романюк'][i % 6],
      'role': ['student','student','student','teacher','parent','admin'][i % 6],
      'className': '${5 + (i % 4)}-${'АБВГ'[i % 4]}',
      'online': i % 3 != 0,
      'diia': i % 2 == 0,
    });
    final chats = List.generate(12, (i) => {
      'id':'chat$i','name':['8-Б • Клас','Учительська','Батьки 8-Б','Математика','Шкільні новини','Дирекція','Шаховий клуб','9-А • Клас','Історія','Медіацентр','Паралель 8-х','Адміністрація'][i],
      'members': 8 + i * 2,'unread': i % 4 == 0,'last':'Останнє демонстраційне повідомлення №${i+1}',
      'time': DateTime.now().subtract(Duration(minutes:i*17)).toIso8601String(),
    });
    final messages = <String, List<Map<String,dynamic>>>{};
    for (final c in chats) {
      messages[c['id'] as String] = List.generate(7, (i) => {
        'id':'${c['id']}_m$i','chatId':c['id'],'authorId':i%2==0?'u0':'u3',
        'authorName':i%2==0?'Олексій Коваль':'Анна Мельник',
        'text':['Привіт!','Нагадую про подію.','Все готово.','Дякую!','Зустрічаємось після уроків.','Оновив інформацію.','Гарного дня!'][i],
        'createdAt':DateTime.now().subtract(Duration(minutes:i*13)).toIso8601String()
      });
    }
    final news = List.generate(6, (i) => {
      'id':'n$i','title':['Олімпіада з математики','День школи','Новий гурток робототехніки','Тиждень безпеки','Спортивні змагання','Відкриття медіацентру'][i],
      'text':'Демонстраційна новина Є-Гідності з повним локальним контентом.',
      'createdAt':DateTime.now().subtract(Duration(days:i)).toIso8601String()
    });
    final reports = List.generate(6, (i) => {
      'id':'r$i','description':'Демонстраційна скарга/звернення №${i+1}',
      'status':['new','closed','rejected'][i%3],
      'createdAt':DateTime.now().subtract(Duration(days:i)).toIso8601String()
    });
    final events = List.generate(25, (i) => {
      'id':'e$i','text':'Подія журналу №${i+1}: демонстраційна дія користувача.',
      'createdAt':DateTime.now().subtract(Duration(hours:i*3)).toIso8601String()
    });

    await box.putAll({
      'seeded': true,
      'users': jsonEncode(users),
      'chats': jsonEncode(chats),
      'messages': jsonEncode(messages),
      'news': jsonEncode(news),
      'reports': jsonEncode(reports),
      'events': jsonEncode(events),
      'classes': jsonEncode(List.generate(7,(i)=>{'id':'c$i','name':'${5+i}-А','members':18+i})),
    });
  }
}
