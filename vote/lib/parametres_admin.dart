import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ParametresPageAdmin(),
  ));
}

class ParametresPageAdmin extends StatefulWidget {
  @override
  _ParametresPageAdminState createState() => _ParametresPageAdminState();
}

class _ParametresPageAdminState extends State<ParametresPageAdmin> {
  String _selectedLangue = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ParametreButton(
              icon: Icons.security,
              text: 'Confidentialité',
              onPressed: () {
                Navigator.pushNamed(context, '/confidentialites');
                print('Page de confidentialité');
              },
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.notifications,
              text: 'Notifications',
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
                print('Page de notifications');
              },
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.language,
              text: 'Langue',
              onPressed: _showLangueModal,
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.report_problem,
              text: 'Signaler un problème',
              onPressed: () {
                // Ajoutez ici la logique pour la page de signalement de problème
                print('Page de signalement de problème');
              },
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.help,
              text: 'Aide et assistance',
              onPressed: () {
                Navigator.pushNamed(context, '/aide');
                print('Page d\'aide et d\'assistance');
              },
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.login,
              text: 'Se connecter en tant qu\'utilisateur',
              onPressed: () {
                Navigator.pushNamed(context, '/connexion');
                print('Connexion en tant qu\'utilisateur');
              },
            ),
            SizedBox(height: 16.0),
            ParametreButton(
              icon: Icons.logout,
              text: 'Se déconnecter',
              onPressed: _showDeconnexionModal,
            ),
          ],
        ),
      ),
    );
  }

  void _showLangueModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text(
                      'Français',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: 'Français',
                    groupValue: _selectedLangue,
                    onChanged: (value) {
                      setState(() {
                        _selectedLangue = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<String>(
                    title: Text(
                      'Anglais',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: 'Anglais',
                    groupValue: _selectedLangue,
                    onChanged: (value) {
                      setState(() {
                        _selectedLangue = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Appliquer la langue choisie
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text(
                      'Appliquer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDeconnexionModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Voulez-vous vraiment vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Annuler la déconnexion
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour la déconnexion
                Navigator.pushNamed(context, '/connexion');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Fond du bouton en bleu
              ),
              child: Text(
                'Se déconnecter',
                style: TextStyle(
                  color: Colors.white, // Texte en blanc
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ParametreButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ParametreButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(color: Colors.blue),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 16.0),
            Text(text, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
