import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tobetoapp/bloc/announcements/announcement_event.dart';
import 'package:tobetoapp/bloc/announcements/announcement_state.dart';
import 'package:tobetoapp/models/announcement_model.dart';
import 'package:tobetoapp/repository/announcements_repo.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository _announcementRepository;
  StreamSubscription<List<Announcements>>? _announcementsSubscription;

  AnnouncementBloc(this._announcementRepository)
      : super(AnnouncementsLoading()) {
    on<LoadAnnouncements>(_loadAnnouncements);
    on<AddAnnouncement>(_addAnnouncement);
    on<DeleteAnnouncement>(_deleteAnnouncement);
    on<AnnouncementsUpdated>(_onAnnouncementsUpdated);
  }

  Future<void> _loadAnnouncements(
      LoadAnnouncements event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementsLoading());
    _announcementsSubscription?.cancel();
    _announcementsSubscription =
        _announcementRepository.getAnnouncementsStream().listen(
      (announcements) {
        print("Received announcements: $announcements");
        add(AnnouncementsUpdated(announcements));
      },
      onError: (error) {
        print("Error receiving announcements: $error");
        emit(AnnouncementOperationFailure(error.toString()));
      },
    );
  }

  void _onAnnouncementsUpdated(
      AnnouncementsUpdated event, Emitter<AnnouncementState> emit) {
    emit(AnnouncementsLoaded(event.announcements));
  }

  Future<void> _addAnnouncement(
      AddAnnouncement event, Emitter<AnnouncementState> emit) async {
    try {
      await _announcementRepository.addAnnouncement(event.announcement);
      emit(AnnouncementOperationSuccess());
      add(LoadAnnouncements());
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }

  Future<void> _deleteAnnouncement(
      DeleteAnnouncement event, Emitter<AnnouncementState> emit) async {
    try {
      await _announcementRepository.deleteAnnouncement(event.id);
      emit(AnnouncementOperationSuccess());
      add(LoadAnnouncements());
    } catch (e) {
      emit(AnnouncementOperationFailure(e.toString()));
    }
  }
}
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tobeto_app/bloc/announcements/announcement_state.dart';
// import 'package:tobeto_app/bloc/announcements/announcement_event.dart';
// import 'package:tobeto_app/repositories/announcements_repo.dart';

// class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
//   final AnnouncementRepository _announcementRepository;

//   AnnouncementBloc(this._announcementRepository)
//       : super(AnnouncementsLoading()) {
//     on<LoadAnnouncements>(_loadAnnouncements);
//     on<AddAnnouncement>(_addAnnouncement);
//     on<DeleteAnnouncement>(_deleteAnnouncement);
//   }

//   Future<void> _loadAnnouncements(
//       LoadAnnouncements event, Emitter<AnnouncementState> emit) async {
//     emit(AnnouncementsLoading());
//     try {
//       final announcements = await _announcementRepository.getAnnouncements();
//       emit(AnnouncementsLoaded(announcements));
//     } catch (e) {
//       emit(AnnouncementOperationFailure(e.toString()));
//     }
//   }

//   Future<void> _addAnnouncement(
//       AddAnnouncement event, Emitter<AnnouncementState> emit) async {
//     try {
//       await _announcementRepository.addAnnouncement(event.announcement);
//       emit(AnnouncementOperationSuccess());
//       add(LoadAnnouncements()); // Duyuruları yeniden yükle
//     } catch (e) {
//       emit(AnnouncementOperationFailure(e.toString()));
//     }
//   }

//   Future<void> _deleteAnnouncement(
//       DeleteAnnouncement event, Emitter<AnnouncementState> emit) async {
//     try {
//       await _announcementRepository.deleteAnnouncement(event.id);
//       emit(AnnouncementOperationSuccess());
//       add(LoadAnnouncements()); // Duyuruları yeniden yükle
//     } catch (e) {
//       emit(AnnouncementOperationFailure(e.toString()));
//     }
//   }
// }
