import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _notificationsActives = true;
  bool _sonNotificationActif = false;
  bool _notificationsPrioriteActives = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSwitch(
              text: 'Notifications',
              value: _notificationsActives,
              onChanged: (value) {
                setState(() {
                  _notificationsActives = value;
                });
              },
            ),
            NotificationSwitch(
              text: 'Son de notification',
              value: _sonNotificationActif,
              onChanged: (value) {
                setState(() {
                  _sonNotificationActif = value;
                });
              },
            ),
            NotificationSwitch(
              text: 'Notifications de priorité',
              value: _notificationsPrioriteActives,
              onChanged: (value) {
                setState(() {
                  _notificationsPrioriteActives = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationSwitch({
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
            inactiveTrackColor: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
