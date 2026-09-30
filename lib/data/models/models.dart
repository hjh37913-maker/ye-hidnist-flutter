enum UserRole { student, teacher, parent, admin }
enum ChatType { personal, classChat, community, announce }
enum ReportStatus { newReport, closed, rejected }
enum QrStatus { active, expired, cancelled }

class UserModel {
  UserModel({required this.id, required this.name, required this.role, this.classId, this.className, this.avatarUrl, this.isOnline=false, this.diiaVerified=false, this.phone});
  final String id, name;
  final UserRole role;
  final String? classId, className, avatarUrl, phone;
  final bool isOnline, diiaVerified;
}

class ChatModel {
  ChatModel({required this.id, required this.name, required this.type, required this.membersCount, this.unreadCount=0, this.lastMessage, this.lastMessageTime, this.schoolId});
  final String id, name;
  final ChatType type;
  final int membersCount, unreadCount;
  final String? lastMessage, schoolId;
  final DateTime? lastMessageTime;
}

class MessageModel {
  MessageModel({required this.id, required this.chatId, required this.authorId, required this.authorName, required this.text, required this.createdAt, this.replyToId, this.replyToText, this.imageUrl, this.isEdited=false, Map<String,int>? reactions})
      : reactions = reactions ?? {};
  final String id, chatId, authorId, authorName, text;
  final DateTime createdAt;
  final String? replyToId, replyToText, imageUrl;
  final bool isEdited;
  final Map<String,int> reactions;
}

class SchoolClassModel {
  SchoolClassModel({required this.id, required this.name, required this.membersCount, this.homeroomTeacherId, this.homeroomTeacherName, this.subjects=const []});
  final String id, name;
  final int membersCount;
  final String? homeroomTeacherId, homeroomTeacherName;
  final List<String> subjects;
}

class NewsItemModel {
  NewsItemModel({required this.id, required this.title, required this.text, required this.createdAt, this.imageUrl});
  final String id, title, text;
  final DateTime createdAt;
  final String? imageUrl;
}

class ReportModel {
  ReportModel({required this.id, required this.description, required this.status, required this.createdAt, this.schoolId});
  final String id, description;
  final ReportStatus status;
  final DateTime createdAt;
  final String? schoolId;
}

class AppEventModel {
  AppEventModel({required this.id, required this.text, required this.createdAt});
  final String id, text;
  final DateTime createdAt;
}

class QrSessionModel {
  QrSessionModel({required this.token, required this.createdAt, required this.expiresAt, this.status=QrStatus.active});
  final String token;
  final DateTime createdAt, expiresAt;
  final QrStatus status;
}
