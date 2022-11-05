
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(
                context,
                SocialLayout(),
            );
          }
        },
        builder: (context, state) {

          return Scaffold(
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
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return ('please enter your  name');
                            }
                            return null;

                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
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
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          onSubmit: (value){

                          },
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return ('password is too short');
                            }
                            return null;
                          },
                          isPassword:SocialRegisterCubit.get(context).isPassword ,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return ('please enter your phone number');
                            }
                            return null;

                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        //Condition
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) =>  defaultButton(
                            function:()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name:nameController.text,
                                  phone: phoneController.text,
                                );

                              }
                            },
                            text:'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>Center(child: CircularProgressIndicator(),),
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
