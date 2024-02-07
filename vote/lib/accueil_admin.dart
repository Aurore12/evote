//accueil_admin.dart
import 'package:flutter/material.dart';
import 'creation_vote.dart';
import 'voteslistpage.dart';
import 'profil.dart';
import 'dart:ui';
import 'parametres_admin.dart';

void main() {
  runApp(MaterialApp(
    home: AccueilPageAdmin(),
  ));
}

class AccueilPageAdmin extends StatefulWidget {
  @override
  _AccueilPageAdminState createState() => _AccueilPageAdminState();
}

class _AccueilPageAdminState extends State<AccueilPageAdmin> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          // Page d'accueil
          AccueilContent(),

          // Page profil
          ProfilePage(),

          // Page paramètres
          ParametresPageAdmin(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.white : Colors.grey[350]),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _currentIndex == 1 ? Colors.white : Colors.grey[350]),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _currentIndex == 2 ? Colors.white : Colors.grey[350]),
            label: 'Paramètres',
          ),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}

class BoutonVote extends StatelessWidget {
  final String texte;

  const BoutonVote({Key? key, required this.texte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (texte == 'Créer Vote') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateVotePage()),
          );
        } else if (texte == 'Voir les votes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VotesListPage()),
          );
        } else {
          print('Type de vote sélectionné : $texte');
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        minimumSize: Size(200.0, 0),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        shadowColor: Colors.blue,
        elevation: 5.0,
      ),
      child: Text(
        texte,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}

class AccueilContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/election.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.blue),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Rechercher...',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoutonVote(texte: 'Créer Vote'),
                    SizedBox(height: 16.0),
                    BoutonVote(texte: 'Voir les votes'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
