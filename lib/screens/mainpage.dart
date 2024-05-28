import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:tobetoapp/bloc/auth/auth_bloc.dart';
import 'package:tobetoapp/bloc/auth/auth_state.dart';


// Bottom Navigation Bar sayfasi 

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          setState(() {
            _selectedIndex = 0;
          });
        } else if (state is AuthSuccess) {
          setState(() {
            _selectedIndex = 0; // Ana sayfaya yönlendirme
          });
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthSuccess) {
          return Scaffold(
            body: _buildContentForLoggedInUser(state.role!),
            bottomNavigationBar: _buildBottomNavigationBarForRole(state.role!),
          );
        } else {
          return Scaffold(
            body: _buildContentForNotLoggedInUser(),
            bottomNavigationBar: _buildBottomNavigationBarForNotLoggedInUser(),
          );
        }
      },
    );
  }

  Widget _buildContentForLoggedInUser(String role) {
    switch (role) {
      case 'teacher':
        return _buildTeacherContent(role);
      case 'student':
        return _buildStudentContent(role);
      case 'admin':
        return _buildAdminContent(role);
      default:
        return Scaffold();
    }
  }

  // Yorum satiri olan Announcement sayfalari rollere gore dagilimin yapildigi sayfadir

  Widget _buildTeacherContent(String role) {
    switch (_selectedIndex) {
      case 0:
        return Scaffold(); // Öğretmen için sınıflar sayfası
      case 1:
        //return AnnouncementsPage(role: role); // Öğretmen için duyurular sayfası
      case 2:
        return Scaffold(); // Profil sayfası
      default:
        return Scaffold();
    }
  }

  Widget _buildStudentContent(String role) {
    switch (_selectedIndex) {
      case 0:
        return Scaffold(); // Öğrenci için eğitim sayfası
      case 1:
       // return AnnouncementsPage(role: role); // Öğrenci için duyurular sayfası
      case 2:
        return Scaffold(); // Öğrenci için favoriler sayfası
      case 3:
        return Scaffold(); // Profil sayfası
      default:
        return Scaffold();
    }
  }

  Widget _buildAdminContent(String role) {
    switch (_selectedIndex) {
      case 0:
        return Scaffold(); // Admin için ana sayfa
      case 1:
       // return AnnouncementsPage(role: role); // Admin için duyurular sayfası
      case 2:
        return Scaffold(); // Admin için profil sayfası
      // Diğer admin sayfalarını buraya ekleyebilirsiniz
      case 3:
        return Scaffold();
      default:
        return Scaffold();
    }
  }

  Widget _buildContentForNotLoggedInUser() {
    switch (_selectedIndex) {
      case 0:
        return Scaffold();// Giriş yapmamış kullanıcılar için ana sayfa
      case 1:
        return Scaffold(); // Bilgi sayfası
      default:
        return Scaffold();
    }
  }

  BottomNavigationBar _buildBottomNavigationBarForRole(String role) {
    List<BottomNavigationBarItem> items;
    // Student rolunde 3'ten fazla tab oldugu ıcın type kullanıyoruz.
    BottomNavigationBarType? type;
    switch (role) {
      case 'teacher':
        items = [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ];
        type = BottomNavigationBarType.fixed;
        break;
      case 'student':
        items = [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ];
        type = BottomNavigationBarType.fixed;
        break;
      case 'admin':
        items = [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          // Diğer admin öğelerini buraya ekleyebilirsiniz
        ];
        type = BottomNavigationBarType.fixed;
        break;
      default:
        items = [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ];
    }
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type:type, // Type parametresini girdigimizde butun bottomNavigationBar lar ayni ozellikte oluyor.

      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: items,
    );
  }

  BottomNavigationBar _buildBottomNavigationBarForNotLoggedInUser() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
      ],
    );
  }
}
