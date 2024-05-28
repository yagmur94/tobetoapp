
import 'package:tobetoapp/models/announcement_model.dart';

abstract class AnnouncementEvent {}

class LoadAnnouncements extends AnnouncementEvent {}

class AddAnnouncement extends AnnouncementEvent {
  final Announcements announcement;

  AddAnnouncement(this.announcement);
}

class DeleteAnnouncement extends AnnouncementEvent {
  final String id;

  DeleteAnnouncement(this.id);

  
}
class AnnouncementsUpdated extends AnnouncementEvent {
  final List<Announcements> announcements;

  AnnouncementsUpdated(this.announcements);
}
