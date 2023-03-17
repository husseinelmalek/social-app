
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:untitled/shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var cubit=SocialCubit.get(context).socialUserModel;
        // var userModel=cubit.socialUserModel;
        // print('${SocialCubit.get(context).socialUserModel}');
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${cubit?.cover}'),
                              fit: BoxFit.cover,


                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${cubit?.image}'),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Text('${cubit?.name}',
                style: Theme.of(context).textTheme.bodyText1,

              ),
              Text('${cubit?.bio}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                  height: 1.7,
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style: Theme.of(context).textTheme.subtitle2,

                            ),
                            Text('posts',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.7,
                              ),

                            ),

                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children: [
                            Text('120',
                              style: Theme.of(context).textTheme.subtitle2,

                            ),
                            Text('photos',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.7,
                              ),

                            ),

                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children: [
                            Text('67',
                              style: Theme.of(context).textTheme.subtitle2,

                            ),
                            Text('followers',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.7,
                              ),

                            ),

                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children: [
                            Text('54',
                              style: Theme.of(context).textTheme.subtitle2,

                            ),
                            Text('following',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.7,
                              ),

                            ),

                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {

                      },
                      child: Text('Add Photos'),
                    ),
                  ),
                  SizedBox(width: 13.0,),
                  OutlinedButton(onPressed:() {
                    navigateTo(context, EditProfileScreen());
                  },
                      child:Icon(Icons.edit,
                      size: 16.0,
                      ),

                  ),
                ],
              ),
            ],
          ),
        );
      },

    );
  }
}
