
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/social_login/cubit/cubit.dart';
import 'package:untitled/modules/social_app/social_login/cubit/states.dart';
import 'package:untitled/modules/social_app/social_register/social_register_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
var formKey=GlobalKey<FormState>();

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit , SocialLoginStates>(
        listener: (context, state) {
        if(state is SocialLoginErrorState){
          showToast(text: state.error, state: ToastStates.ERROR);
        }
        if(state is SocialLoginSuccessState){
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateAndFinish(context, SocialLayout());
          });
        }
        },
        builder: (context, state) =>  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text('login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      defaultTextField(
                        controller: emailController,
                        label: 'Email Adress',
                        prefix: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if(value.isEmpty){
                            return 'please enter your email adress';
                          }
                        },
                      ),
                      SizedBox(height: 15.0,),
                      defaultTextField(
                        controller: passwordController,
                        label: 'Password',
                        onSubmit: (value) {
                          if(formKey.currentState!.validate()){
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }

                        },
                        prefix: Icons.lock_open_outlined,
                        suffix: SocialLoginCubit.get(context).isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        type: TextInputType.visiblePassword,
                        suffixPressed: () {
                          SocialLoginCubit.get(context).changePasswordIcon();
                        },
                        isPassword: SocialLoginCubit.get(context).isShow,
                        validate: (value) {
                          if(value.isEmpty){
                            return 'please enter your Password';
                          }
                        },
                      ),
                      SizedBox(height: 30.0,),


                      ConditionalBuilder(
                        condition: state is !SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }


                          },
                          text: 'Loin',
                          isUpperCase: true,
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),

                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text('Don\'t Have an acount?'),
                          TextButton(onPressed: () {
                            navigateAndFinish(context, SocialRegisterScreen());
                          }, child: Text('Register Now')),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
