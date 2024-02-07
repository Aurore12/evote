import 'package:flutter/material.dart';
import 'package:vote/aide.dart';
import 'package:vote/confidentialites.dart';
import 'package:vote/creation_vote.dart';
import 'package:vote/notification.dart';
import 'package:vote/profil.dart';
import 'package:vote/resultatsvote.dart';
import 'connexion.dart';
import 'connexion_admin.dart';
import 'inscription.dart';
import 'accueil.dart';
import 'parametres.dart';
import 'accueil_admin.dart';
import 'reset.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Ajoutez d'autres fournisseurs si nécessaire
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/connexion': (context) => ConnexionPage(),
        '/inscription': (context) => InscriptionPage(),
        '/accueil': (context) => AccueilPage(),
        '/accueil_admin': (context) => AccueilPageAdmin(),
        '/parametres': (context) => ParametresPage(),
        '/connexion_admin': (context) => ConnexionPageAdmin(),
        '/aide': (context) => AidePage(),
        '/confidentialites': (context) => ConfidentialitePage(),
        '/notification': (context) => NotificationPage(),
        '/creation_vote':(context) => CreateVotePage(), 
         '/resulatsvote':(context) => ResultatsVotePage(voteId: null), 
        '/profil':(context) => ProfilePage(),
        '/reset':(context) => ResetPasswordPage(),
        
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      
      body: Center(
        child: Container(
          width: 300.0,
          height: 400.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/connexion');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Colors.blue, width: 2),
                  minimumSize: const Size(200.0, 0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'SE CONNECTER',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/inscription');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size(200.0, 0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'S\'INSCRIRE ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0, // Espace ajouté
              ),
              Text(
                'Inscrivez-vous avec les réseaux sociaux',
                style: TextStyle(
                  color: Colors
                      .blue, // Couleur du texte à ajuster selon vos préférences
                ),
              ),
              const SizedBox(
                height: 15.0, // Espace ajouté
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(
                    onPressed: () {
                      // Gestion de la connexion avec Facebook
                    },
                    icon: 'assets/facebook.svg',
                  ),
                  SocialButton(
                    onPressed: () {
                      // Gestion de la connexion avec Twitter
                    },
                    icon: 'assets/twitter.svg',
                  ),
                  SocialButton(
                    onPressed: () {
                      // Gestion de la connexion avec Google
                    },
                    icon: 'assets/google.svg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;

  const SocialButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 1.0),
      ),
      padding: EdgeInsets.all(0.0), // Ajustez le padding ici
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          icon,
          width: 30.0,
          height: 30.0,
        ),
      ),
    );
  }
}
