import 'package:flutter/material.dart';
import 'accueil_admin.dart'; // Assurez-vous d'importer la page d'accueil_admin

class ConnexionPageAdmin extends StatefulWidget {
  @override
  _ConnexionPageAdminState createState() => _ConnexionPageAdminState();
}

class _ConnexionPageAdminState extends State<ConnexionPageAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordForgottenClicked = false;

  // Fonction pour vérifier les informations de connexion
  void _checkLogin() {
    // Simuler la vérification des informations de connexion
    String email = _emailController.text;
    String password = _passwordController.text;

    // Vérifier si les informations sont valides
    if (email == 'admin@gmail.com' && password == 'root') {
      // Informations valides, rediriger vers la page d'accueil admin
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccueilPageAdmin()),
      );
    } else {
      // Informations invalides, afficher un message d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur de connexion'),
            content: Text('Veuillez vérifier vos informations de connexion.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de connexion', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white, // Couleur de fond de l'AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue], // Choisissez vos couleurs
            ),
          ),
        ),
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
                          // Valider le formulaire
                          _checkLogin();
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

void main() {
  runApp(MaterialApp(
    home: ConnexionPageAdmin(),
  ));
}
