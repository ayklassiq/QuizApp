
import 'package:firebase_auth/firebase_auth.dart';

class  AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInAnon() async{
    try{
      UserCredential userCredential   =await _auth.signInAnonymously();
          return userCredential.user;
    }catch(e){
      print('Error sisgning in anonymously: $e');
      return null;
    }
  }
}