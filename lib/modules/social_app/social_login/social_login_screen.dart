import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_login/cubit/states.dart';
import 'package:social_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState)
            {
              showToast(
                text: state.error,
                state: ToastStates.ERROR,
              );
            }
          if(state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value)
              {
                navigateAndFinish(context, SocialLayout());
              });
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(

            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to communicate with friends ',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return ('please enter your email address');
                            }
                            return null;

                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value){
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                            }
                          },
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return ('password is too short');
                            }
                            return null;
                          },
                          isPassword:SocialLoginCubit.get(context).isPassword ,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        //Condition
                        state is! SocialLoginLoadingState?  defaultButton(
                          function:()
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                            }
                          },
                          text:'login',
                          isUpperCase: true,
                        ):Center(child: CircularProgressIndicator(),),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t hava an account?',
                            ),
                            defaultTextButton(
                              function:(){
                                navigateTo(context, SocialRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
