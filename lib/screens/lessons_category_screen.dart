import 'package:flutter/material.dart';
import 'package:tobetoapp/services/firebase_firestore_services.dart';
import 'package:tobetoapp/screens/lesson_detail_screen.dart';
import 'package:tobetoapp/models/catalog_model.dart';
import 'package:tobetoapp/repository/catalog_repository.dart'; 

class LessonsCategoryScreen extends StatefulWidget {
  const LessonsCategoryScreen({super.key});

  @override
  _LessonsCategoryScreenState createState() => _LessonsCategoryScreenState();
}

class _LessonsCategoryScreenState extends State<LessonsCategoryScreen> {
  List<Catalog> filteredCatalogs = [];
  List<String> categories = [];
  List<String> levels = [];
  List<String> subjects = [];
  List<String> languages = [];
  List<String> instructors = [];
  List<String> certificationStatuses = [];

  String? selectedCategory;
  String? selectedLevel;
  String? selectedSubject;
  String? selectedLanguage;
  String? selectedInstructor;
  String? selectedCertificationStatus;
  bool isFree = false;

  bool isLoading = true;
  FirebaseFirestoreService firestoreService = FirebaseFirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchDropdownData();
  }

  void _fetchDropdownData() async {
    try {
      categories = await firestoreService.getCategories();
      levels = await firestoreService.getLevels();
      subjects = await firestoreService.getSubjects();
      languages = await firestoreService.getLanguages();
      instructors = await firestoreService.getInstructors();
      certificationStatuses = await firestoreService.getCertificationStatuses();
    } catch (e) {
      // Handle the error properly
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error fetching data')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eğitimler'),
      ),
      body: isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildDropdown(
                    hint: 'Kategori Seçin',
                    value: selectedCategory,
                    items: categories,
                    onChanged: (value) => setState(() => selectedCategory = value),
                  ),
                  _buildDropdown(
                    hint: 'Seviye Seçin',
                    value: selectedLevel,
                    items: levels,
                    onChanged: (value) => setState(() => selectedLevel = value),
                  ),
                  _buildDropdown(
                    hint: 'Konu Seçin',
                    value: selectedSubject,
                    items: subjects,
                    onChanged: (value) => setState(() => selectedSubject = value),
                  ),
                  _buildDropdown(
                    hint: 'Yazılım Dili Seçin',
                    value: selectedLanguage,
                    items: languages,
                    onChanged: (value) => setState(() => selectedLanguage = value),
                  ),
                  _buildDropdown(
                    hint: 'Eğitmen Seçin',
                    value: selectedInstructor,
                    items: instructors,
                    onChanged: (value) => setState(() => selectedInstructor = value),
                  ),
                  _buildDropdown(
                    hint: 'Sertifika Durumu Seçin',
                    value: selectedCertificationStatus,
                    items: certificationStatuses,
                    onChanged: (value) => setState(() => selectedCertificationStatus = value),
                  ),
                  SwitchListTile(
                    title: const Text('Ücretsiz'),
                    value: isFree,
                    onChanged: (value) => setState(() => isFree = value),
                  ),
                  ElevatedButton(
                    onPressed: _applyFilters,
                    child: const Text('Filtrele'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCatalogs.length,
                      itemBuilder: (context, index) {
                        Catalog catalog = filteredCatalogs[index];
                        return VideoCard(
                          imageUrl: catalog.imageUrl,
                          title: catalog.title,
                          rating: catalog.rating,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonDetailScreen(
                                  videoUrl: catalog.imageUrl,
                                  videoTitle: catalog.title,
                                  videoRating: catalog.rating,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      hint: Text(hint),
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _applyFilters() async {
    List<Catalog> catalogs = await CatalogRepository().getCatalog();
    setState(() {
      filteredCatalogs = catalogs.where((catalog) {
        return (selectedCategory == null || selectedCategory == catalog.category) &&
               (selectedLevel == null || selectedLevel == catalog.level) &&
               (selectedSubject == null || selectedSubject == catalog.subject) &&
               (selectedLanguage == null || selectedLanguage == catalog.language) &&
               (selectedInstructor == null || selectedInstructor == catalog.instructor) &&
               (selectedCertificationStatus == null || selectedCertificationStatus == catalog.certificationStatus) &&
               (!isFree || catalog.isFree);
      }).toList();
    });
  }
}

class VideoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final VoidCallback onTap;

  const VideoCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Image.network(imageUrl),
          title: Text(title),
          subtitle: Text('Rating: $rating'),
        ),
      ),
    );
  }
}
