import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'voteslistpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class _Candidat {
  String nom = '';
  File? photo;
  String description = '';
}

class CreateVotePage extends StatefulWidget {
  @override
  _CreateVotePageState createState() => _CreateVotePageState();
}

class _CreateVotePageState extends State<CreateVotePage> {
  String _nom = '';
  String _description = '';
  List<_Candidat> _candidats = [];

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _pickImage(int candidatIndex) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _candidats[candidatIndex].photo = File(pickedFile.path);
      });
    }
  }

  void _addCandidat() {
    setState(() {
      _candidats.add(_Candidat());
    });
  }

  void _showSuccessMessage() async {
    try {
      final response = await http.post(
        Uri.parse('http://vvvootee.000webhostapp.com/api/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nom': _nom,
          'description': _description,
          'candidats': _candidats
              .map((candidat) => {
                    'nom': candidat.nom,
                    'description': candidat.description,
                    'photo_path': candidat.photo?.path,
                  })
              .toList(),
        }),
      );

      if (response.statusCode == 200) {
        print('Vote créé avec succès');
        print(response.body);
        Navigator.pop(context); // Retournez à l'écran précédent après la création du vote
        Navigator.pushNamed(context, '/votesList'); // Naviguer vers la liste des votes
      } else {
        print('Échec de la création du vote');
        print(response.body);
        // Gérez les erreurs ici (affichez un message à l'utilisateur, etc.)
      }
    } catch (e) {
      print('Erreur lors de la création du vote: $e');
      // Gérez les erreurs ici (affichez un message à l'utilisateur, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Création de Vote'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Type de vote',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _nom = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description du vote',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              for (int i = 0; i < _candidats.length; i++) ...[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nom du Candidat',
                    contentPadding: EdgeInsets.all(16.0),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _candidats[i].nom = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(i);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: Text('Sélectionner une image'),
                ),
                SizedBox(height: 16.0),
                if (_candidats[i].photo != null) ...[
                  Image.file( // Afficher l'image sélectionnée
                    _candidats[i].photo!,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 16.0),
                ],
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Description du Candidat',
                    contentPadding: EdgeInsets.all(16.0),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _candidats[i].description = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
              ],
              ElevatedButton(
                onPressed: _addCandidat,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                ),
                child: Text('Ajouter un autre candidat'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _showSuccessMessage(); // Appeler la fonction pour créer le vote
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                ),
                child: Text('Créer Vote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateVotePage(),
    routes: {
      '/votesList': (context) => VotesListPage(),
    },
  ));
}
