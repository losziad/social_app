

//POST
//UPDATE
//DELETE

//GET
// base url: https://newsapi.org/
// method (url) : v2/everything?
// queries : q=apple&from=2022-09-19&to=2022-09-19&sortBy=popularity&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Apple
//https://newsapi.org/v2/everything?q=apple&from=2022-09-19&to=2022-09-19&sortBy=popularity&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Tesla
//https://newsapi.org/v2/everything?q=tesla&from=2022-08-21&sortBy=publishedAt&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Business
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4



//To print all text
import 'package:social_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/components/components.dart';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token = '';

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value){
    if(value)
    {
      navigateAndFinish(context, SocialLoginScreen());
    }
  });
}