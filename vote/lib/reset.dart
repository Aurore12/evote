import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réinitialisation du mot de passe'),
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Réinitialiser le mot de passe',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Entrez votre adresse e-mail pour réinitialiser votre mot de passe.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Adresse e-mail',
                      icon: Icon(Icons.email, color: Colors.blue),
                    ),
                    style: TextStyle(color: Colors.blue),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre adresse e-mail';
                      } else if (!value.contains('@')) {
                        return 'Veuillez entrer une adresse e-mail valide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Ajoutez ici la logique pour réinitialiser le mot de passe
                      print('Réinitialisation du mot de passe pour ${_emailController.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: Size(200.0, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Réinitialiser',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ResetPasswordPage(),
  ));
}
