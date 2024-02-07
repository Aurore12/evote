// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditerVotePage extends StatefulWidget {
  @override
  _EditerVotePageState createState() => _EditerVotePageState();
}

class _EditerVotePageState extends State<EditerVotePage> {
  String _voteType = '';
  File? _photo;
  String _description = '';

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
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
                  'Modification effectuée',
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

  void _saveModifications() {
    // Logique pour sauvegarder les modifications
    _showSuccessMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Édition de Vote'),
      ),
      body: Center(
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
                    _voteType = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'Candidats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
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
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description du Candidat',
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              SizedBox(height: 32.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: ElevatedButton(
                  onPressed: _saveModifications,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Enregistrer'),
                ),
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
    home: EditerVotePage(),
  ));
}
