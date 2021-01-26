
import 'package:absnews/main_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:absnews/model.dart';
import 'dart:async';

import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:async/async.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';



class Search extends StatefulWidget{
  @override
  _SearchState createState() => _SearchState();

  // final String id;
  //Search({Key key, @required this.id}) :  super(key: key);

}

class _SearchState extends State<Search>  {
   List<String>postContent =[];
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture; bool loading; int searchOperation;  var searchboxVal;  int charLength = 0; int iconType = 1;

   
   String search;
   @override
  void initState() {
  searchOperation = 0;
  //_postsFuture = 
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color:Colors.white,), onPressed: ()=>{Navigator.pop(context)},),
        backgroundColor: Colors.black,

          title:(searchBox()  ),
      ),

      body:
      SingleChildScrollView(
      child:FutureBuilder(future: _postsFuture,builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print(" it has data"); 
        
       
         return loadPosts(postsList);
         
          }

           else if((snapshot.connectionState==ConnectionState.waiting)&&(searchOperation == 1)) {
           print("connection waiting");
              return Container(
             child: Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
             children:[

               SizedBox(height:250),
               
               CircularProgressIndicator(),
              ],
              )
              
              )
              
            );
         }

         else if(searchOperation == 0){
           return Container(child:Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
             children:[

               SizedBox(height:250),
               
               Text("Searched text will appear here",  textAlign: TextAlign.center, style:TextStyle(fontSize: 22, color: Colors.grey),),
              ],
              )
              ));
         }
      }
      
      
    )));

  }

  Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

   }

     _onChanged(String value) {
    setState(() {
      charLength = value.length;
      if(charLength > 0)
      iconType = 0;
      else if(charLength == 0)
      iconType = 1;
    });
  }
    

   Widget searchBox(){



  return 
    Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
      onChanged: _onChanged,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) {
   print("search $value");
      
  setState(() {
   // listModel.clear(); 
    searchboxVal = value;
    print('array length ${listModel.length.toString()}');
     searchOperation = 1;
   //  print('search operation:  {$searchOperation.toString()}');
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?per_page=50&search=$searchboxVal");

  });
  },
        
       
        autofocus: false,
        obscureText: false,
        style: TextStyle(
          fontSize: 14,
          color:Colors.black,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13,color:Colors.grey,),
            hintText: "Search posts...", filled: true,
             fillColor: _colorFromHex("#F0F0F0"),
                        
                        focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: _colorFromHex("#000000")),
   ),
   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.orange),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.white),
   ),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 0, color: Colors.grey)
   ),
   errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.black)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
   ),

   
            prefixIcon: iconType==1? Padding(
              child: IconTheme(
                data: IconThemeData(color: Colors.black),
                child: Icon(Icons.search),
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            ):Padding(
              child: IconTheme(
                data: IconThemeData(color: Colors.black),
                child: Icon(Icons.close),
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }


  //Class to display all results

   Future<dynamic>  _getPosts(String baseurl) async {

  
  final response = await http.get(baseurl);

  //return compute(parsePosts, response.body);

    var file = await DefaultCacheManager().getSingleFile(baseurl);
    if (file != null && await file.exists()) {
      var res = await file.readAsString();
     // return Response(res, 200);
    }
   // return Response(null, 404);

   var message = jsonDecode(response.body);
  // If Web call Success than Hide the CircularProgressIndicator.
       if(response.statusCode == 200){
      
              //    print(listModel.toString()); 
                  
                     setState(() {
                       received = true;
                        loading = false; searchOperation = 0;

                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
              //   print(postsList.postModel[0].content);
                     });

                    return message;
              

       }

       
  
}

removeLineBreaks(String pContent) {
 //pContent = "hello\nworld";
 pContent = pContent.replaceAll("\n", " ");
  return pContent;
}

String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211;", "-");
   String g = f.replaceAll("&#8217;", "\'");
  return g;

}

formatDate(String f)
{
 String dateFormated = DateFormat("EEEE d MMMM , y ").add_jm().format(DateTime.parse(f));
 print(dateFormated);

DateTime dob = DateTime.parse(f);

print(dob.toString());
var durInMinutes =  DateTime.now().difference(dob).inMinutes.floor().toInt();
var durInHours =  DateTime.now().difference(dob).inHours.floor().toInt();
var durInMonths =  DateTime.now().difference(dob).inDays/30.floor().toInt();
var durInDays =  DateTime.now().difference(dob).inDays.floor().toInt();
/**String differenceInYears = (dur.inDays/365).floor().toString();
String diffInMonths = (dur.inDays/30).floor().toString();
String diffInHours = (dur.inHours/24).floor().toString();*/
//return new Text(differenceInYears + ' years');

//final differenceInDays = .difference(dateTimeCreatedAt).inDays;
//print('$differenceInDays');

   if(durInMinutes < 60 ) 
  return durInMinutes.toString()+ "  minutes ago";
  else if((durInMinutes > 60)&(durInMinutes < 130))
    return "About 2 hours ago"; //durInMinutes.toString()+ "  minutes ago";
  else if((durInMinutes >130)&(durInMinutes < 200))
   return "3 hours ago";
   else if((durInMinutes >200)&(durInMinutes < 250))
   return "4 hours ago";
    else if((durInMinutes >250)&(durInMinutes < 310))
   return "5 hours ago";
    else if((durInMinutes >310)&(durInMinutes < 370))
   return " 6 hours ago";
   else if((durInMinutes >370)&(durInMinutes < 430))
   return " 7 hours ago";
   else if((durInMinutes >430)&(durInMinutes < 465))
   return "8 hours ago";
   else if((durInMinutes >465)&(durInMinutes < 510))
   return "9 hours ago";
   else if((durInMinutes >510)&(durInMinutes < 580))
   return "10 hours ago";
   else if((durInMinutes >580)&(durInMinutes < 650))
   return "11 hours ago";
   else if((durInMinutes >650)&(durInMinutes < 710))
   return "12 hours ago";
   else if((durInMinutes >650)&(durInMinutes < 710))
   return "13 hours ago";
    else if((durInMinutes >710)&(durInMinutes < 800))
   return "14 hours ago";
   else if((durInMinutes >800)&(durInMinutes < 870))
   return "15 hours ago";
    else if((durInMinutes >870)&(durInMinutes < 950))
   return "16 hours ago";
   else if((durInMinutes >870)&(durInMinutes < 950))
   return " 17 hours ago";
   else if((durInMinutes >950)&(durInMinutes < 1010))
   return "18 hours ago";
   else if((durInMinutes >1010)&(durInMinutes < 1080))
   return "19 hours ago";
    else if((durInMinutes >1080)&(durInMinutes < 1150))
   return "20 hours ago";
    else if((durInMinutes >1150)&(durInMinutes < 1220))
   return "21 hours ago";
   else if((durInDays > 0)&&(durInDays < 2))
   return "Yesterday";

    else if((durInMinutes > 1220)&&(durInMinutes < 1290))
   return "22 hours ago";

   else if((durInMinutes > 1280)&&(durInDays < 1))
   return "Several hours ago";

    else if(durInDays ==2)
   return "2 Days Ago";
    else if(durInDays ==3)
   return "3 Days Ago";
    else if(durInDays ==4)
   return "4 Days Ago";
    else if(durInDays ==5)
   return "5 Days Ago";
    else if(durInDays ==6)
   return "6 Days Ago";
    else if(durInDays ==7)
   return "One Week Ago";
   else if((durInDays > 13)&(durInDays <20))
   return "About Two Weeks Ago";
   else if((durInDays > 20)&(durInDays <32))
   return "About Three Weeks Ago";
    else if((durInDays > 32)&(durInDays <50))
   return "About A Month  Ago";
   else if((durInDays > 50)&(durInDays <65))
   return "About Two Months  Ago";
   else if(durInDays > 65)
   return "Months Ago";
   else return dateFormated;
}


 Widget loadPosts(PostsList postsListTotal){

  
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
            print("title:"+ postsListTotal.postModel[index].title);

          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), color:Colors.grey[200], padding:EdgeInsets.only(bottom:10,top:5),  

      child: GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(date:formatDate(postsListTotal.postModel[index].date.toString()),author:postsListTotal.postModel[index].authorName,img:  postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
     child: Card(  
       elevation: 10,
      child: Column(children: [

        GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(date:formatDate(postsListTotal.postModel[index].date.toString()),author:postsListTotal.postModel[index].authorName, img:  postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
       child: ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 300),
                    retryLimit: 20,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ),
// using image provider
SizedBox(height: 20,),

 GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(date:formatDate(postsListTotal.postModel[index].date.toString()),author:postsListTotal.postModel[index].authorName,img:  postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
    child:Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), 
    textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20))),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text(formatDate(postsListTotal.postModel[index].date.toString()),textAlign:TextAlign.end, style:TextStyle(color:Colors.red,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           ));
            
          },
        );
          


  }
}



