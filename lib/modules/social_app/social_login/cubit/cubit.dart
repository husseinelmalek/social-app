import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/social_app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit():super(SocialLoginInitialState());
  static SocialLoginCubit get(context) =>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password
  }){
    emit(SocialLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password).then((value) {
         print(value.user?.email);
         print(value.user?.uid);
         emit(SocialLoginSuccessState(value.user?.uid));

   }).catchError((onError){
     print (onError.toString());
     emit(SocialLoginErrorState(onError.toString()));

   });
  }

bool isShow = true;
  void changePasswordIcon(){
    isShow =! isShow;
    emit(SocialChangePasswordIconState());
  }

}