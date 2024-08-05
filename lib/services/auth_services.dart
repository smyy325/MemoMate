
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
final FirebaseAuth _auth=FirebaseAuth.instance;

//in

Future<User?> signInWithEmailAndPassword(String email, String password) async{
try{
UserCredential result =await _auth.signInWithEmailAndPassword(email: email, password: password);
User? user=result.user;
return user;
} catch(e){
print(e.toString());
return null;
}
}

//up

Future<User?> registerWithEmailAndPassword(String name, String email, String password) async{
try{
UserCredential result=await _auth.createUserWithEmailAndPassword(
email:email,password:password
);
User? user=result.user;
return user;
} catch(e){
print(e.toString());
return null;
}
}

//out

Future<void> signOut() async{
try{
return await _auth.signOut();
}
catch(e){
print(e.toString());
return null;
}
}
}