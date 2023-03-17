
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);

   var nameEditController=TextEditingController();
   var bioEditController=TextEditingController();
   var phoneEditController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state) {

      } ,
      builder:(context, state) {
        var cubit=SocialCubit.get(context).socialUserModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;

        nameEditController.text=cubit?.name as String;
        bioEditController.text=cubit?.bio as String;
        phoneEditController.text=cubit?.phone as String;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title:'Edit Profile',
              actions: [
                TextButton(onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameEditController.text,
                      bio: bioEditController.text,
                      phone: phoneEditController.text
                  );

                }, child: Text('Update')),
                SizedBox(width: 15.0,),
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null ? NetworkImage('${cubit?.cover}'):FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,


                                    )
                                ),
                              ),
                              IconButton(onPressed: () {
                                SocialCubit.get(context).getCoverImage();

                              }, icon: CircleAvatar(
                                  child: Icon(Icons.camera_alt,size: 16.0,)),

                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                profileImage== null ? NetworkImage('${cubit?.image}'): FileImage(profileImage) as ImageProvider,

                              ),
                            ),
                            IconButton(onPressed: () {
                              SocialCubit.get(context).getImage();

                            }, icon: CircleAvatar(
                                child: Icon(Icons.camera_alt,size: 16.0,),
                            ),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(SocialCubit.get(context).profileImage !=null || SocialCubit.get(context).coverImage !=null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(function: () {
                              SocialCubit.get(context).uploadingImage(name: nameEditController.text,
                                  bio: bioEditController.text, phone: phoneEditController.text,);

                            }, text: 'upload profile'),
                            if(state is SocialUpdateLoadingState)
                              SizedBox(height: 4.0,),
                            if(state is SocialUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(width:5.0,),
                      if(SocialCubit.get(context).coverImage !=null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(function: () {
                              SocialCubit.get(context).uploadingCover(name: nameEditController.text, bio: bioEditController.text,
                                  phone: phoneEditController.text);

                            }, text: 'upload cover'),
                            if(state is SocialUpdateLoadingState)
                              SizedBox(height: 4.0,),
                            if(state is SocialUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  defaultTextField(
                      controller: nameEditController,
                      label: 'Name',
                      prefix: Icons.person,
                      type: TextInputType.name,
                      validate: (value) {
                        if(value.isEmpty)
                          {
                            return 'name must not be empty';
                          }
                        return null;
                      },),
                  SizedBox(height: 15,),
                  defaultTextField(
                    controller: bioEditController,
                    label: 'Bio',
                    prefix: Icons.info_outline,
                    type: TextInputType.text,
                    validate: (value) {
                      if(value.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },),
                  SizedBox(height: 15,),
                  defaultTextField(
                    controller: phoneEditController,
                    label: 'Phone',
                    prefix: Icons.phone,
                    type: TextInputType.phone,
                    validate: (value) {
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },)
                ],
              ),
            ),
          ),


        );
      },
    );
  }
}
