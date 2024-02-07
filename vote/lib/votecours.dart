import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'candidatespage.dart';

class VoteCoursPage extends StatefulWidget {
  @override
  _VoteCoursPageState createState() => _VoteCoursPageState();
}

class _VoteCoursPageState extends State<VoteCoursPage> {
  List<dynamic> votesEnCours = [];

  @override
  void initState() {
    super.initState();
    _fetchVotesEnCours();
  }

  Future<void> _fetchVotesEnCours() async {
    try {
      final response = await http.get(Uri.parse('http://vvvootee.000webhostapp.com/api/votes-en-cours'));
      if (response.statusCode == 200) {
        setState(() {
          votesEnCours = json.decode(response.body);
        });
      } else {
        print('Failed to load votes en cours');
      }
    } catch (e) {
      print('Error fetching votes en cours: $e');
    }
  }

  void _voirPlus(int voteId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CandidatesPage(voteId: voteId),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votes en Cours'),
      ),
      body: ListView.builder(
        itemCount: votesEnCours.length,
        itemBuilder: (context, index) {
          final vote = votesEnCours[index];
          return ListTile(
            title: Text(vote['nom']),
            subtitle: Text(vote['description']),
            trailing: ElevatedButton(
              onPressed: () {
                _voirPlus(vote['id']);
              },
              child: Text('Voir Plus'),
            ),
          );
        },
      ),
    );
  }
}
