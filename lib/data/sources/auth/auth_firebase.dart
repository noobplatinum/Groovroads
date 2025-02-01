import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovroads/core/configs/constants/appurls.dart';
import 'package:groovroads/data/models/auth/createuser.dart';
import 'package:groovroads/data/models/auth/signinreq.dart';
import 'package:groovroads/data/models/auth/user.dart';
import 'package:groovroads/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {

      var data = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);

        FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set(
          {
            'name' : data.user?.displayName,
            'email' : data.user?.email,
          }
        );

      return Right('Signed in successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if(e.code == 'invalid-email'){
        message = 'The email address is invalid.';
      } else if(e.code == 'invalid-credential'){
        message = 'Wrong password!';
      }
      
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      return Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if(e.code == 'weak-password'){
        message = 'The password provided is too weak.';
      } else if(e.code == 'email-already-in-use'){
        message = 'The account already exists for that email.';
      }
      
      return Left(message);
    }
  }
  
  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
        firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppURLs.blankProfile;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
  } catch(e) {
    return Left('Error fetching user');
  }
  }
}