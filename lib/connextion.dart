import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionPage extends StatelessWidget {
  ConnexionPage({super.key});
  final techEmail = TextEditingController();
  final techPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Connexion à Twitter"),
            TextFormField(
              controller: techEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Identifiant"),
              validator: (val){
                if(val == null || val.isEmpty){
                  return "Veuillez remplir le champ";
                }
                if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z.]{2,6}$").hasMatch(val)){
                  return "Vérifier le format (ex: john@kennedy.gov)";
                }
                return null;
              },
            ),
            TextFormField(
              controller: techPwd,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Mot de passe"),
              validator: (val){
                if(val == null || val.isEmpty){
                  return "Veuillez remplir le champ";
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  //context.go("/twitter",extra: techEmail.text);
                  context.go("/twitter");
                },
                child: const Text("Valider"))
          ],
        ),
      ),
    );
  }
}
