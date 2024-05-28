import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Announcements {
  String? id;
  String? title;
  String? content;
  DateTime? createdAt;
  Announcements({
    this.id,
    this.title,
    this.content,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Announcements.fromMap(Map<String, dynamic> map) {
    return Announcements(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcements.fromJson(String source) =>
      Announcements.fromMap(json.decode(source) as Map<String, dynamic>);
}
