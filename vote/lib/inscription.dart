import 'package:flutter/material.dart';
import 'connexion.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> inscription() async {
    // Vérifiez si les mots de passe correspondent
    if (_passwordController.text != _confirmPasswordController.text) {
      // Les mots de passe ne correspondent pas
      return;
    }

    // Créez un objet représentant les données d'inscription
    Map<String, dynamic> userData = {
      'name': _nomController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    // Convertissez l'objet en une chaîne JSON
    String jsonData = jsonEncode(userData);

    // Effectuez une requête HTTP POST vers votre API Laravel
    final response = await http.post(
      Uri.parse('http://vvvootee.000webhostapp.com/api/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 201) {
      // Succès de la requête, l'utilisateur est inscrit
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConnexionPage()),
      );
    } else {
      // Échec de la requête, gestion des erreurs
      print('Erreur lors de l\'inscription: ${response.statusCode}');
      print('Réponse de l\'API: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'inscription'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Image.asset(
                  'assets/logo.png', // Remplacez par le chemin de votre image
                  height: 300.0,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Inscrivez-vous',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      icon: Icon(Icons.person, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre adresse e-mail';
                      } else if (!value.contains('@')) {
                        return 'Veuillez entrer une adresse e-mail valide';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      icon: Icon(Icons.lock, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      icon: Icon(Icons.lock, color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      } else if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          inscription();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(200.0, 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'S\'INSCRIRE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InscriptionPage(),
  ));
}
