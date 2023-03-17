import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/social_post_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/chats/chats_screen.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/post/post_screen.dart';
import 'package:untitled/modules/social_app/settings/settings_screen.dart';
import 'package:untitled/modules/social_app/users/users_screen.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitialState());
static SocialCubit get(context) => BlocProvider.of(context);

   SocialUserModel? socialUserModel;
void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
            socialUserModel =SocialUserModel.fromJson(value.data());
              // socialUserModel=SocialUserModel(name: value.get('name'), email: value.get('email'),
              // phone: value.get('phone'), uId: value.get('uId'), image: value.get('image'), bio: value.get('bio'),
              // cover: value.get('cover'), isEmailVerified: value.get('isEmailVerified'));
             // print(socialUserModel?.isEmailVerified);
          emit(SocialGetUserSuccessState());
    }).catchError((onError){
      print('this is the errrorrororororo ${onError.toString()}');
      emit(SocialGetUserErrorState(onError.toString()));
    });

  }

int currentIndex=0;
List<String> titles=[
  'Feeds',
  'chats',
  'posts',
  'users',
  'setting',
];
List<Widget> screens =[
  FeedsScreen(),
  ChatsScreen(),
  PostScreen(),
  UserScreen(),
  SettingScreen(),

];
void changeSocialBottomNav(int index){
  if(index ==1) {
    getAllUsers();
  }
  if(index==2){
    emit(SocialAddPostState());
  }else {
    currentIndex=index;
  emit(SocialChangeBottomNavState());
}
}
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        emit(SocialEditProfileImageSuccessState());
      } else {
        print('No image selected.');
        emit(SocialEditProfileImageErrorState());
      }

  }
  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialEditCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialEditCoverImageErrorState());
    }

  }
  // String profileImageUrl='';
  void uploadingImage ({
    required String name,
    required String bio,
    required String phone,
  }){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            // emit(SocialUploadingProfileImageSuccessState());
            // print(value);
            // profileImageUrl=value;
            updateUser(name: name, bio: bio, phone: phone,image: value);
          }).catchError((error){
            emit(SocialUploadingProfileImageErrorState());
          });
    }).catchError((error){
         emit(SocialUploadingProfileImageErrorState());
    });
  }


  // String coverImageUrl='';
  void uploadingCover ({
    required String name,
    required String bio,
    required String phone,
  }){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadingProfileImageSuccessState());
        // coverImageUrl=value;
        updateUser(name: name, bio: bio, phone: phone,cover: value);
      }).catchError((error){
        emit(SocialUploadingProfileImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadingProfileImageErrorState());
    });
  }

//   void updateUserImages({
//   required String name,
//   required String bio,
//     required String phone
// }){
//     emit(SocialUpdateLoadingState());
//     if(profileImage !=null){
//       uploadingImage();
//     }else if(coverImage !=null){
//       uploadingCover();
//     }else if (profileImage !=null && coverImage !=null){
//
//     }else
//     {
//       updateUser(name: name, bio: bio, phone: phone);
//
//   }
//   }

  void updateUser ({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }){
    emit(SocialUpdateLoadingState());
    SocialUserModel model=SocialUserModel(
        name: name,
        phone: phone,
        uId: socialUserModel?.uId,
        image:image??socialUserModel?.image,
        bio: bio,
        email: socialUserModel?.email,
        cover: cover??socialUserModel?.cover,
        isEmailVerified: socialUserModel?.isEmailVerified);
    FirebaseFirestore.instance.collection('users').doc(uId).update(model.toJson()).
    then((value) {
      getUserData();
    }).
    catchError((error){
      emit(SocialUpdateErrorState());
    });

  }

  // newwwwwwww post

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }

  }
  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage ({
    required String text,
    required String dateTime,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadingProfileImageSuccessState());
        // coverImageUrl=value;
        createPost(text: text, dateTime: dateTime,postImage: value);
        // updateUser(name: name, bio: bio, phone: phone,cover: value);
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost ({
    required String text,
    required String dateTime,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel model=PostModel(
        name: socialUserModel?.name,
        uId: socialUserModel?.uId,
        image:socialUserModel?.image,
        text: text,
        postImage: postImage??'',
        dateTime: dateTime,
    );
    FirebaseFirestore.instance.collection('posts').add(model.toJson()).
    then((value) {
      emit(SocialCreatePostSuccessState());
    }).
    catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }

List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];
  List<int> comments=[];
  void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          emit(SocialGetPostsSuccessState());
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            emit(SocialGetPostsSuccessState());
        }).catchError((error){});

        }).catchError((error){});
      });
emit(SocialGetPostsSuccessState());
    }).catchError((onError){
      emit(SocialGetPostsErrorState(onError));
    });

  }

  void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(socialUserModel?.uId).
    set({
      'like':true
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState(error));

    });
  }

  void commentPost(String postId,String text){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(socialUserModel?.uId).
    set({
      'comment':text,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error){
      emit(SocialCommentPostErrorState(error));

    });
  }

  List<SocialUserModel> users=[];

  void getAllUsers(){
    if(users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != socialUserModel?.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUserSuccessState());

    }).catchError((error){
      emit(SocialGetAllUserErrorState(error));

    });
    }
  }

  void sendMessage({
  required String receiverId,
    required String dateTime,
    required String text,
}){
    MessageModel messageModel=MessageModel(
        senderId: socialUserModel?.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text
    );
    FirebaseFirestore.instance.collection('users')
    .doc(socialUserModel?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toJson()).then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error){
      emit(SocialSendMessageErrorState(error));
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(socialUserModel?.uId)
        .collection('messages')
        .add(messageModel.toJson()).then((value) {
      emit(SocialReceiveMessageSuccessState());

    }).catchError((error){
      emit(SocialReceiveMessageErrorState(error));
    });

  }

List<MessageModel> messages=[];

  void getMessages({
    required String receiverId,
}){
    FirebaseFirestore.instance.collection('users')
        .doc(socialUserModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages=[];
      event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
           emit(SocialGetMessageSuccessState());
    });


  }


}