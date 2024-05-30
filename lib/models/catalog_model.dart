class Catalog {
  String id;
  String title;
  String instructor;
  String category;
  String level;
  String subject;
  String language;
  String certificationStatus;
  String imageUrl;
  double rating;

  Catalog({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.level,
    required this.subject,
    required this.language,
    required this.certificationStatus,
    required this.imageUrl,
    required this.rating,
  });

  factory Catalog.fromMap(Map<String, dynamic> map) {
    return Catalog(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      instructor: map['instructor'] ?? '',
      category: map['category'] ?? '',
      level: map['level'] ?? '',
      subject: map['subject'] ?? '',
      language: map['language'] ?? '',
      certificationStatus: map['certificationStatus'] ?? '',
      imageUrl: map['imageUrl'] ?? '', 
      rating: map['rating'] ?? 0.0, 
    );
  }
}
