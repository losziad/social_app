import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/states.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/native_screen.dart';
import 'package:social_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/network/remote/dio_helper.dart';
import 'package:social_app/shared/constant.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:social_app/shared/styles/themes.dart';


// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
// {
//    print('on background message');
//    print(message.data.toString());
//    showToast(text: 'on background message', state: ToastStates.SUCCESS,);
// }
//@dart=2.9
void main() async{
  //بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يفتح الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);


  // foreground fcm
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('on message');
  //   print(event.data.toString());
  //   showToast(text: 'on message', state: ToastStates.SUCCESS,);
  // });

  //when click on notifications to open app
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('on message open app');
  //   print(event.data.toString());
  //   showToast(text: 'on message open app', state: ToastStates.SUCCESS,);
  // });

  //background fcm
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
   DioHelper.init();
  await CacheHelper.init();

  // bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

   uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = SocialLayout();
  }
  else
  {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    // isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget? startWidget;
  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),

    child:  BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp
          (
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          // darkTheme: darkTheme,
          // themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
          //To start shop app put startWidget
          home: SocialLayout(),
        );
      },

    ),

    );
  }
}