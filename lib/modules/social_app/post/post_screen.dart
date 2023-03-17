
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);
   var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title:'Create posts',
            actions: [
              TextButton(onPressed: () {
                var now=DateTime.now();
                if(SocialCubit.get(context).postImage == null){
                  SocialCubit.get(context).createPost(text: textController.text, dateTime: now.toString());
                }else {
                  SocialCubit.get(context).uploadPostImage(text: textController.text, dateTime: now.toString());
                }
                  

              }, child: Text('Posts'),),
              SizedBox(width: 5.0,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/close-up-portrait-gorgeous-young-woman_273609-40597.jpg?t=st=1678018276~exp=1678018876~hmac=6e7e62911c251b986131f79336249c052139ae33759f5276b142d40a70d48ae5'),

                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: Text('hussein said',
                        style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind , hussein',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,


                          )
                      ),
                    ),
                    IconButton(onPressed: () {
                      SocialCubit.get(context).removePostImage();

                    }, icon: CircleAvatar(
                        child: Icon(Icons.close,size: 16.0,)),

                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {
                        SocialCubit.get(context).getPostImage();

                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 10.0,),
                          Text('Add photo'),
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {

                      }, child: Text('# Tags'),),
                    )

                  ],
                ),
              ],
            ),
          ),



        );
      },
    );
  }
}
