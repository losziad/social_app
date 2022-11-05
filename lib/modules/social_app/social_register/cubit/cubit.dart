import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
   ).then((value)
   {

     userCreate(
       uId: value.user!.uid,
       email: email,
       name: name,
       phone: phone,
     );
     // emit(SocialRegisterSuccessState());
   }).catchError((error)
   {
     emit(SocialRegisterErrorState(error.toString()));

   });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
})
  {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      bio: 'write you bio ...',
      image: 'https://img.freepik.com/free-photo/waist-up-shot-pretty-girl-smiles-pleasantly_273609-28224.jpg?w=1800&t=st=1665939051~exp=1665939651~hmac=379f83b2a0ae2c4e2972c003a3e65a0b8781f4e4f3f81e0b1497aa7580e4f68a',
      cover: 'https://img.freepik.com/free-photo/confused-lovely-female-teenager-holds-chin-looks-thoughtfully-aside-has-dark-hair-wears-striped-sweater-isolated-white-wall_273609-16546.jpg?t=st=1665925610~exp=1665926210~hmac=3ef2f21c3be61eab8b85d0a44d72a33f89af8e5502f733c1bb8d646ce707fbfd',
      isEmailVerified: false,
    );

      FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
        emit(SocialCreateUserSuccessState());
      }).catchError((error){
        emit(SocialCreateUserErrorState(error.toString()));
      });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
