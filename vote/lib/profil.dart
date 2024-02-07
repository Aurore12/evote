import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userFirstName;
  late String userLastName;
  late String userPhoneNumber;
  late String userEmail;
  late String userPassword;
  DateTime? userBirthDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _birthDateController = TextEditingController();

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Profil sauvegardé');
      print('Nom et Prénom: $userFirstName $userLastName');
      print('Date de Naissance: $userBirthDate');
      print('Numéro de Téléphone: $userPhoneNumber');
      print('Adresse E-mail: $userEmail');
      print('Mot de Passe: $userPassword');

      _showSuccessMessage();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

      _birthDateController.text = formattedDate;
      setState(() {
        userBirthDate = pickedDate;
      });
    }
  }

  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Profil créé avec succès',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 48.0,
                ),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Fermer'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Prendre une photo'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text('Choisir depuis la galerie'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                 child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.blue,
                  child: _photo != null
                      ? ClipOval(
                          child: Image.file(
                            _photo!,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
                onSaved: (value) => userFirstName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
                onSaved: (value) => userLastName = value!,
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(labelText: 'Date de Naissance'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre date de naissance';
                  }
                  return null;
                },
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numéro de Téléphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSaved: (value) => userPhoneNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Adresse E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  }
                  return null;
                },
                onSaved: (value) => userEmail = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de Passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
                onSaved: (value) => userPassword = value!,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Créer Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
