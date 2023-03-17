
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/post/post_screen.dart';
import 'package:untitled/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      if(state is SocialAddPostState){
        navigateTo(context, PostScreen());

              }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed:() {

              }, icon: Icon(Icons.notifications)),
              IconButton(onPressed:() {

              }, icon: Icon(Icons.search))

            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
              label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_outlined),
                  label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_history),
                  label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'setting'),

            ],
            onTap: (value) {
              cubit.changeSocialBottomNav(value);
            },

          ),

        );
      },

    );
  }
}
