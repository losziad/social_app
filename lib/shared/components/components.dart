
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 3.0,
  bool isUpperCase = true,
  // anonymous function
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        }, //() he not put it
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  required FormFieldValidator<String>? validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  GestureTapCallback? onTap,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged:onChange,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget taskBuilder({
  required List<Map> tasks,
}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Task Yet, Please Add Some Tasks',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        // navigateTo(context, WebViewScreen(article['url']),);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => list.lenght > 0
    ? ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      )
    : isSearch
        ? Container()
        : Center(child: CircularProgressIndicator());

//Push and Replacement
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function!();
      },
      child: Text(text.toUpperCase()),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates
{
  SUCCESS,
  ERROR,
  WARNING,
}
Color chooseToastColor(ToastStates state)
{
  Color? color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


const defaultColor = Colors.blue;

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>  AppBar(
  leading: IconButton(
    onPressed:()
    {
      Navigator.pop(context);
    },
    icon:Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  title: Text(
    title!,
  ),
  actions: actions,
);

// ConditionalBuilder(
//   condition: list.length > 0,
//   builder: (context) =>
//       ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: 10,),
//   fallback: (context) => Center(child: CircularProgressIndicator()),
// );
