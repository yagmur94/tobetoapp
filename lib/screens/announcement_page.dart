import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobetoapp/bloc/announcements/announcement_bloc.dart';
import 'package:tobetoapp/bloc/announcements/announcement_event.dart';
import 'package:tobetoapp/bloc/announcements/announcement_state.dart';
import 'package:tobetoapp/screens/add_announcement.dart';
import 'package:tobetoapp/screens/announcement_detail.dart';


class AnnouncementsPage extends StatelessWidget {
  final String role; // 'admin' veya 'student' olacak

  const AnnouncementsPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        actions: role == 'admin' || role == 'teacher'
            ? [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAnnouncementPage()),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: BlocConsumer<AnnouncementBloc, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementOperationSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Operation Successful')));
          } else if (state is AnnouncementOperationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Operation Failed')));
          }
        },
        builder: (context, state) {
          print("Current state: $state"); // Durumu kontrol etmek için
          if (state is AnnouncementsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnnouncementsLoaded) {
            print("Announcements loaded: ${state.announcements}");
            if (state.announcements.isEmpty) {
              return const Center(child: Text('Duyuru bulunmamaktadır'));
            } else {
              final reversedAnnouncements = state.announcements.reversed.toList();
              return ListView.builder(
                itemCount: reversedAnnouncements.length,
                itemBuilder: (context, index) {
                  final announcement = reversedAnnouncements[index];
                  final formattedDate = announcement.createdAt != null
                      ? DateFormat('dd.MM.yyyy').format(announcement.createdAt!)
                      : 'Tarih yok';
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnnouncementDetailPage(
                                announcement: announcement),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Duyuru',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              announcement.title!,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(formattedDate),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnnouncementDetailPage(
                                                announcement: announcement),
                                      ),
                                    );
                                  },
                                  child: const Text('Detaylar'),
                                ),
                                if (role == 'admin' || role == 'teacher')
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      BlocProvider.of<AnnouncementBloc>(context)
                                          .add(DeleteAnnouncement(announcement.id!));
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is AnnouncementOperationFailure) {
            print("Error: ${state.error}");
            return const Center(child: Text('Failed to load announcements'));
          } else {
            print("Unknown state: $state");
            return const Center(child: Text('Failed to load announcements'));
          }
        },
      ),
    );
  }
}


