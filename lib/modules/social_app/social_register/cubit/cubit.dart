import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/social_register/cubit/states.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) =>BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then(
            (value) {
              // print(value.user?.email);
               print(value.user?.uid);
              userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);

            }).catchError((onError) {
              print(onError.toString());
              emit(SocialRegisterErrorState(onError));

    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

}){
    SocialUserModel model = SocialUserModel(
      name: name,
        email: email,
        phone: phone,
        uId: uId,
      image: 'https://img.freepik.com/free-photo/cheerful-attractive-unshaved-dark-haired-guy-with-short-haircut-keeping-palm-his-heart_295783-9352.jpg?w=740&t=st=1678094128~exp=1678094728~hmac=c84a62201b0f5b172d9e5366d37ddabffdbf5797b236e026a504d29671349583',

      bio:'create your bio....',
      cover:'https://img.freepik.com/free-photo/happy-attractive-young-unshaved-brunette-man-with-trendy-hairstyle-showing-happily-himself-looking-joyfully-front-dressed-white-shirt-while-standing-against-pink-wall_295783-9345.jpg?t=st=1678094128~exp=1678094728~hmac=316c812a258104f039ad877a7b60ba9ac1a36a7279dab20d2276fa2c66431947',
      isEmailVerified:false,

    );
    FirebaseFirestore.instance.
    collection('users')
        .doc(uId)
        .set(model.toJson()).then((value) {
          emit(SocialCreateSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialCreateErrorState(onError.toString()));
    });

}

bool isShow = true;
  void changePasswordIcon(){
    isShow =! isShow;
    emit(SocialRegisterChangePasswordIconState());
  }

}