import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultatsVotePage extends StatefulWidget {
  final int? voteId;

  ResultatsVotePage({required this.voteId});

  @override
  _ResultatsVotePageState createState() => _ResultatsVotePageState();
}

class _ResultatsVotePageState extends State<ResultatsVotePage> {
  List<dynamic> resultatsVote = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.voteId != null) {
      _fetchResultatsVote();
    } else {
      // Si voteId est null, on arrête le chargement et on affiche un message d'erreur
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchResultatsVote() async {
    try {
      final response = await http.get(
          Uri.parse('http://vvvootee.000webhostapp.com/api/resultats-vote/${widget.voteId}'));
      if (response.statusCode == 200) {
        setState(() {
          resultatsVote = json.decode(response.body)['results'];
          isLoading = false;
        });
      } else {
        print('Échec du chargement des résultats du vote');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur lors du chargement des résultats du vote : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats du Vote'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.voteId != null
              ? resultatsVote.isEmpty
                  ? Center(
                      child: Text('Aucun résultat disponible pour cet ID de vote.'),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Résultats du Vote',
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          Expanded(
                            child: ListView.builder(
                              itemCount: resultatsVote.length,
                              itemBuilder: (context, index) {
                                final resultat = resultatsVote[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      resultat['nom'] ?? '',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    subtitle: Text('Score: ${resultat['score'] ?? ''}'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
              : Center(
                  child: Text('Aucun ID de vote disponible.'),
                ),
    );
  }
}
