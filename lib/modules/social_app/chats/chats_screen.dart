
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/chats/chat_screen_details.dart';
import 'package:untitled/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  ConditionalBuilder(
          condition:SocialCubit.get(context).users.isNotEmpty,
          builder: (context) =>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model , context) =>InkWell(
    onTap: () {
      navigateTo(context, ChatDetailsScreen(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 10.0,),
          Text('${model.name}',
            style: TextStyle(
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    ),
  );
}
