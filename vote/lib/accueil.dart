import 'package:flutter/material.dart';
import 'dart:ui';
import 'votecours.dart';
import 'rvotecours.dart';
import 'parametres.dart';
import 'profil.dart';

class VoteCours extends StatefulWidget {
  @override
  _VoteCoursState createState() => _VoteCoursState();
}

class _VoteCoursState extends State<VoteCours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votes en cours'),
      ),
      body: Center(
        child: Text('Contenu de la page VoteCours'),
      ),
    );
  }
}

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

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
          AccueilContent(),
          // Page profil
          ProfilePage(),
          // Page paramètres
          ParametresPage(),
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
        print('Type de vote sélectionné : $texte');
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
        backgroundColor: Colors.blue, // Couleur de fond de l'appbar
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
                  mainAxisAlignment: MainAxisAlignment.center, // Centrer les boutons
                  children: [
                    Container(
                      width: 200.0, // Ajustez la largeur du bouton selon vos besoins
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VoteCoursPage()),
                          );
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
                          'Votes en cours',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 200.0, // Ajustez la largeur du bouton selon vos besoins
                      child: ElevatedButton(
                        onPressed: () {
                          print('Résultat des votes');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RVoteCoursPage()),
                              );
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
                          'Résultat des votes',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
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
