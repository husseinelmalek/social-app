
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/social_post_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({Key? key}) : super(key: key);

// List<String> commentController=[];
//    var commentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context, state) {

     },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(image: NetworkImage('https://img.freepik.com/free-photo/portrait-young-beautiful-woman-gesticulating_273609-40303.jpg?t=st=1678016380~exp=1678016980~hmac=1711d7ee46fe0b84e580e54e16483899f83a6d70cdb0f60d62590e84bf0734d5'),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('communicate with friends',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color: Colors.white,
                              )
                          ),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                      separatorBuilder: (context, index) => SizedBox(height: 8.0,),
                      itemCount: SocialCubit.get(context).posts.length),
                  SizedBox(height: 8.0,)
                ],
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

//  ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
//  List<TextEditingController> commentControl=
//  [
//    // TextEditingController(),
//    // TextEditingController.fromValue(TextEditingValue),
//    // TextEditingController(),
//    // TextEditingController(),
//    // TextEditingController(),
//    // TextEditingController(),
//    for (int i = 1; i < SocialCubit.get(context).posts.length; i++)
//      TextEditingController()
//  ];
  Widget buildPostItem( PostModel model,context,index) {
    List<TextEditingController> commentControl=
    [
      // TextEditingController(),
      for (int i = 1; i <= SocialCubit.get(context).posts.length; i++)
        TextEditingController()
    ];
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(width: 10.0,),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Row(
                      children: [
                      Text('${model.name}',
                      style: TextStyle(
                     height: 1.4,
                      fontWeight: FontWeight.w600,
                         ),
                        ),
                       SizedBox(width: 5.0,),
                       Icon(Icons.check_circle,
                       color: defaultColor,
                       size: 16.0,
                         ),
                           ],
                       ),
                      Text('${model.dateTime}',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.4,
                          ),
                    )
                    ],

    ),
    ),
    SizedBox(width: 10.0,),
    IconButton(onPressed: () {

    }, icon: Icon(Icons.more_horiz,size: 16.0,)
    ),

    ],
    ),
    Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,

    ),
    ),
    Text('${model.text}',
    style: Theme.of(context).textTheme.subtitle1,

    ),
    // Padding(
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 5.0,
    //   ),
    //   child: Container(
    //     width: double.infinity,
    //     child: Wrap(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsetsDirectional.only(
    //               end: 5.0
    //           ),
    //           child: Container(
    //             height: 25.0,
    //             child: MaterialButton(
    //                 minWidth: 1.0,
    //                 padding: EdgeInsets.zero,
    //                 onPressed: () {
    //
    //                 }, child: Text('#software',
    //               style: Theme.of(context).textTheme.caption?.copyWith(
    //                 color: defaultColor,
    //               ),
    //             )
    //             ),
    //           ),
    //         ),
    //         Container(
    //           height: 25.0,
    //           child: MaterialButton(
    //               minWidth: 1.0,
    //               padding: EdgeInsets.zero,
    //               onPressed: () {
    //
    //               }, child: Text('#flutter',
    //             style: Theme.of(context).textTheme.caption?.copyWith(
    //               color: defaultColor,
    //             ),
    //           )
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    if(model.postImage != '')
    Padding(
    padding: const EdgeInsetsDirectional.only(
    top: 15.0,
    ),
    child: Container(
    height: 400.0,
    width: double.infinity,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4.0),
    image: DecorationImage(
    image: NetworkImage('${model.postImage}'),
    fit: BoxFit.cover,


    )
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(
    vertical: 8.0,
    ),
    child: Row(
    children: [
    Expanded(
    child: InkWell(
    child: Padding(
    padding: const EdgeInsets.symmetric(
    vertical: 5.0,
    ),
    child: Row(
    children: [
    Icon(Icons.favorite_border,size: 16.0,color: Colors.red,),
    SizedBox(width: 5.0,),
    Text('${SocialCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,)
    ],
    ),
    ),
    onTap: () {

    },
    ),
    ),
    Expanded(
    child: InkWell(
    child: Padding(
    padding: const EdgeInsets.symmetric(
    vertical: 5.0,
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    Icon(Icons.message,size: 16.0,color: Colors.red,),
    SizedBox(width: 5.0,),
    Text('${SocialCubit.get(context).comments[index]}',
      style: Theme.of(context).textTheme.caption?.copyWith(
      color: Colors.red,
    ),),
    Text('comments',style: Theme.of(context).textTheme.caption,)
    ],
    ),
    ),
    onTap: () {

    },
    ),
    ),

    ],
    ),

    ),
    Padding(
    padding: const EdgeInsets.only(
    bottom: 10
    ),
    child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,

    ),
    ),
    Row(
    children: [
    Expanded(
    child: Row(
    children: [
    CircleAvatar(
    radius: 18.0,
    backgroundImage: NetworkImage('${SocialCubit.get(context).socialUserModel?.image}'),

    ),
    SizedBox(width: 10.0,),
    // Text('write a comment....',
    //   style: Theme.of(context).textTheme.caption,
    // ),
    Expanded(
    child: TextFormField(
    controller: commentControl[index],
    decoration: InputDecoration(
    border: InputBorder.none,
    hintText: 'write your comment',
    ),
    onFieldSubmitted: (value) {
    if(value.isNotEmpty){
    SocialCubit.get(context).commentPost(SocialCubit.get(context).postId[index],commentControl[index].text);
    }
    },
    ),
    ),


    ],
    ),
    ),
    InkWell(
    child: Row(
    children: [
    Icon(Icons.favorite_border,size: 16.0,color: Colors.red,),
    SizedBox(width: 5.0,),
    Text('like',style: Theme.of(context).textTheme.caption,)
    ],
    ),
    onTap: () {
    SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);

    },
    ),

    ],
    ),
    ],
    ),
    )
    ,
    );
  }
  }

