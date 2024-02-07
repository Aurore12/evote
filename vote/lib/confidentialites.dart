import 'package:flutter/material.dart';

class ConfidentialitePage extends StatefulWidget {
  @override
  _ConfidentialitePageState createState() => _ConfidentialitePageState();
}

class _ConfidentialitePageState extends State<ConfidentialitePage> {
  bool _voterEnAnonymat = true;
  bool _verrouillageEmpreinte = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidentialité'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConfidentialiteSwitch(
              text: 'Voter en anonymat',
              value: _voterEnAnonymat,
              onChanged: (value) {
                setState(() {
                  _voterEnAnonymat = value;
                });
              },
            ),
            ConfidentialiteSwitch(
              text: 'Verrouillage par empreinte digitale',
              value: _verrouillageEmpreinte,
              onChanged: (value) {
                setState(() {
                  _verrouillageEmpreinte = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConfidentialiteSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ConfidentialiteSwitch({
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Colors.blue,
            inactiveThumbColor: Colors.white, // Couleur du cercle lorsqu'il est désactivé
            inactiveTrackColor: Colors.grey.withOpacity(0.5), // Couleur du fond lorsqu'il est désactivé
          ),
        ],
      ),
    );
  }
}
