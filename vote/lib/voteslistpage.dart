import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VotesListPage extends StatefulWidget {
  @override
  _VotesListPageState createState() => _VotesListPageState();
}

class _VotesListPageState extends State<VotesListPage> {
  List<dynamic> votes = [];

  @override
  void initState() {
    super.initState();
    _fetchVotes();
  }

  Future<void> _fetchVotes() async {
    try {
      final response = await http.get(Uri.parse('http://vvvootee.000webhostapp.com/api/votes'));
      if (response.statusCode == 200) {
        setState(() {
          votes = json.decode(response.body);
        });
      } else {
        print('Failed to load votes');
      }
    } catch (e) {
      print('Error fetching votes: $e');
    }
  }

  Future<void> _publishVote(int voteId) async {
    try {
      final response = await http.post(
        Uri.parse('http://vvvootee.000webhostapp.com/api/publish-vote/$voteId'),
      );

      if (response.statusCode == 200) {
        print('Vote $voteId publié avec succès');
        _fetchVotes(); // Rafraîchissez la liste des votes après la publication
      } else {
        print('Échec de la publication du vote');
      }
    } catch (e) {
      print('Erreur lors de la publication du vote: $e');
    }
  }

  Future<void> _deleteVote(int voteId) async {
    // Mettez en œuvre la logique de suppression ici
    print('Suppression du vote $voteId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Votes'),
      ),
      body: ListView.builder(
        itemCount: votes.length,
        itemBuilder: (context, index) {
          final vote = votes[index];
          return ListTile(
            title: Text(vote['nom']),
            subtitle: Text(vote['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.publish),
                  onPressed: () {
                    _publishVote(vote['id']);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteVote(vote['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
