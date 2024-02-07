import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'user_provider.dart';

class CandidatesPage extends StatefulWidget {
  final int voteId;

  CandidatesPage({required this.voteId});

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  List<dynamic> candidats = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _chargerCandidats();
  }

  Future<void> _chargerCandidats() async {
    setState(() {
      isLoading = true;
    });

    try {
      final reponse = await http.get(
          Uri.parse('http://vvvootee.000webhostapp.com/api/candidats/${widget.voteId}'));
      if (reponse.statusCode == 200) {
        setState(() {
          candidats = json.decode(reponse.body);
        });
      } else {
        print('Échec du chargement des candidats');
      }
    } catch (e) {
      print('Erreur lors du chargement des candidats : $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _voterPourCandidat(int idCandidat, int? userId) async {
    if (userId == null) {
      print('L\'ID de l\'utilisateur est nul.');
      return;
    }

    try {
      print('UserId: $userId');
      final response = await http.post(
      Uri.parse('http://vvvootee.000webhostapp.com/api/voteForCandidate/$userId/$idCandidat'),
      body: {'userId': userId.toString(), 'idCandidat': idCandidat.toString()},
    );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Vote enregistré avec succès.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: 'Vous avez déjà voté pour ce candidat dans ce vote.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Erreur lors du vote.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print('Erreur lors du vote : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Candidats'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: candidats.length,
              itemBuilder: (context, index) {
                final candidat = candidats[index];
                return ListTile(
                  title: Text(candidat['nom']),
                  subtitle: Text(candidat['description']),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _voterPourCandidat(candidat['id'], userId);
                    },
                    child: Text('Vote'),
                  ),
                );
              },
            ),
    );
  }
}
