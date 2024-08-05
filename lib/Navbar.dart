import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_notebook_project/HomePage/Home.dart';
import 'package:my_notebook_project/chat/chatPage.dart';
import 'package:my_notebook_project/todo/todoPage.dart';
import 'package:my_notebook_project/voice/voice_notes.dart';

class NavbarPage extends StatefulWidget {
  @override
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [

    NoteHome(),
    ChatPage(),
    SpeechText(),
    TodoPage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white60,
        buttonBackgroundColor: Colors.purple[50],
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: _navigateBottomBar,
        items: const [
          Icon(Icons.home_filled, size: 30),
          Icon(Icons.chat_rounded, size: 30),
          Icon(Icons.record_voice_over, size: 30),
          Icon(Icons.today_outlined, size: 30),
        ],
      ),
    );
  }
}
