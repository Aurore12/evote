// connexion_page.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'accueil.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordForgottenClicked = false;

  Future<void> _login(UserProvider userProvider) async {
    Map<String, dynamic> userData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    String jsonData = jsonEncode(userData);

    try {
      final response = await http.post(
          Uri.parse('http://vvvootee.000webhostapp.com/api/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          // Remplacez VOTRE_ADRESSE_IP par l'adresse IP de votre serveur
          body: jsonData);
      print('Réponse du serveur: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userId = data['user_id'];

        print('Connexion réussie: $data');
        print('ID de l\'utilisateur: $userId');

        userProvider.setUserId(userId);

        Navigator.pushReplacementNamed(context, '/accueil');
      } else {
        print('Échec de la connexion: ${response.body}');
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de connexion',
            style: TextStyle(color: Colors.black)),
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
                  'assets/logo.png',
                  height: 400.0,
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
                    'Connectez-vous',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordForgottenClicked = true;
                        });
                        Navigator.pushNamed(context, '/reset');
                        print('Mot de passe oublié');
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          color: _isPasswordForgottenClicked
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login(userProvider);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(200.0, 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'SE CONNECTER',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// main.dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => ConnexionPage(),
          '/accueil': (context) => AccueilPage(),
        },
      ),
    ),
  );
}
