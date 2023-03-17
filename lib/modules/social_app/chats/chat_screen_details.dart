
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
   SocialUserModel? model;
   ChatDetailsScreen({
     this.model
});
   var textMessageController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: model!.uId!);
        return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${model?.image}'),
                    ),
                    SizedBox(width: 10.0,),
                    Text('${model?.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message=SocialCubit.get(context).messages[index];
                                if(SocialCubit.get(context).socialUserModel?.uId == message.senderId ) {
                                  return buildMyMessage(message,context);
                                }
                                return buildMessage(message);

                              },
                              separatorBuilder:(context, index) => SizedBox(height: 15.0,),
                              itemCount: SocialCubit.get(context).messages.length),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textMessageController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: 'type your message here....',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.blue,

                                child: MaterialButton(onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: model!.uId!,
                                      dateTime: DateFormat('MMM d,h:mm a').format(DateTime.now()),
                                      text: textMessageController.text);
                                  textMessageController.text='';
                                }, child: Icon(Icons.send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                                  // minWidth: 1.0,
                                  minWidth: 1.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
  Widget buildMessage(MessageModel message)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      children: [

        GestureDetector(
          onTap: () => Text('data'),
          child: Container(
            child: Text(message.text!),
            padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )
            ),
          ),
        ),
        Text('${message.dateTime}'),
      ],
    ),
  );
  Widget buildMyMessage(MessageModel message,context) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Container(
          child: Text(message.text!),
          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              )
          ),
        ),
        Text('${message.dateTime}',
        style: Theme.of(context).textTheme.caption
        ),
      ],
    ),
  );

}
