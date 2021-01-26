
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


class FirstTab extends StatefulWidget{

  @override
  _FirstTabState createState()=> _FirstTabState();
}



class _FirstTabState extends State<FirstTab> with AutomaticKeepAliveClientMixin<FirstTab> {

   List<String>postContent =[];
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return 
         
         SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
              //   print(postsList.postModel[0].content);
                     });

                    return message;
              

       }

       });
  
}

removeLineBreaks(String pContent) {
 //pContent = "hello\nworld";
 pContent = pContent.replaceAll("\n", " ");
  return pContent;
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
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);

          
   
            
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

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211;", "-");
   String g = f.replaceAll("&#8217;", "\'");
  return g;

}


}

//Second Tab

class SecondTab extends StatefulWidget{

  @override
  _SecondTabState createState()=> _SecondTabState();
}



class _SecondTabState extends State<SecondTab> with AutomaticKeepAliveClientMixin<SecondTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=5&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }

  removeLineBreaks(String pContent) {
 //pContent = "hello\nworld";
 pContent = pContent.replaceAll("\n", " ");
  return pContent;
}



    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  

        child: GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(img:postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
     child: Card(  
      child: Column(children: [

       GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(img:  postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
       child: ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ),
// using image provider
SizedBox(height: 20,),

 GestureDetector(
    onTap: ()=>{  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPost(img:  postsListTotal.postModel[index].featuredImage.toString(), title: sanitizeTitle(postsListTotal.postModel[index].title.toString()), content:removeLineBreaks(postsListTotal.postModel[index].content.toString()))
                       ),)

},
 child:Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

 ),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           ));
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}

//Third Tab

class ThirdTab extends StatefulWidget{

  @override
  _ThirdTabState createState()=> _ThirdTabState();
}



class _ThirdTabState extends State<ThirdTab> with AutomaticKeepAliveClientMixin<ThirdTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=13&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}

class FourthTab extends StatefulWidget{

  @override
  _FourthTabState createState()=> _FourthTabState();
}



class _FourthTabState extends State<FourthTab> with AutomaticKeepAliveClientMixin<FourthTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=11&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}

//Fifth Tab

class FifthTab extends StatefulWidget{

  @override
  _FifthTabState createState()=> _FifthTabState();
}



class _FifthTabState extends State<FifthTab> with AutomaticKeepAliveClientMixin<FifthTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=3&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}

//Sixth Tab

class SixthTab extends StatefulWidget{

  @override
  _SixthTabState createState()=> _SixthTabState();
}



class _SixthTabState extends State<SixthTab> with AutomaticKeepAliveClientMixin<SixthTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=7&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}


class SevenTab extends StatefulWidget{

  @override
  _SevenTabState createState()=> _SevenTabState();
}



class _SevenTabState extends State<SevenTab> with AutomaticKeepAliveClientMixin<SevenTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=6&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}


//Eight Tab

class EightTab extends StatefulWidget{

  @override
  _EightTabState createState()=> _EightTabState();
}



class _EightTabState extends State<EightTab> with AutomaticKeepAliveClientMixin<EightTab> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=4&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}


//Tab Nine

//Eight Tab

class TabNine extends StatefulWidget{

  @override
  _TabNineState createState()=> _TabNineState();
}



class _TabNineState extends State<TabNine> with AutomaticKeepAliveClientMixin<TabNine> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=14&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}


class TabTen extends StatefulWidget{

  @override
  _TabTenState createState()=> _TabTenState();
}



class _TabTenState extends State<TabTen> with AutomaticKeepAliveClientMixin<TabTen> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=4&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}


class TabEleven extends StatefulWidget{

  @override
  _TabElevenState createState()=> _TabElevenState();
}



class _TabElevenState extends State<TabEleven> with AutomaticKeepAliveClientMixin<TabEleven> {

  
   final AsyncMemoizer _memoizer = AsyncMemoizer(); List<PostsList> listModel = []; PostsList postsList;   ScrollController _controller = new ScrollController(); 

 bool received;  Future  _postsFuture;

 @override
  void initState() {
     _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&categories[]=14&fields=id,title,featured_image_url,date,author_meta");

    super.initState();

  }


    @override
     bool get wantKeepAlive =>true;

     Widget build(BuildContext context){
       super.build(context);

         return SingleChildScrollView(
                         child: FutureBuilder(
        future: _postsFuture,//_getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=50&fields=id,title,featured_image_url,date,author_meta"),
        builder: (context, snapshot) {
          if((snapshot.connectionState==ConnectionState.done)&&(snapshot.hasData)){
         print("has data");
         return loadPosts(postsList);
         
          }
         else if(snapshot.connectionState==ConnectionState.waiting) {
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
         }}),
                   
                  );

    }

    Future<dynamic>  _getPosts(String baseurl) {

  return this._memoizer.runOnce(() async {
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
                         postsList = new PostsList();
                 postsList = new PostsList.fromJson(message);


                  listModel.add(postsList);
                  
                 // print(postsList.postModel[0].title);
                     });

                    return message;
              

       }

       });
  
}

 Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
          //  print("Image:"+ postsListTotal.postModel[index].featuredImage);
            
          
   
            
    return Container( 
      width:double.maxFinite, margin: EdgeInsets.only(bottom:20), padding:EdgeInsets.only(bottom:10,top:5),  


     child: Card(  
      child: Column(children: [
        ClipRRect(
    borderRadius: BorderRadius.circular(5.0),

    child:  TransitionToImage(
 
      
          image: AdvancedNetworkImage(
                    postsListTotal.postModel[index].featuredImage.toString(), 
                     height:300,  
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
// using image provider
SizedBox(height: 20,),

 Text(sanitizeTitle(postsListTotal.postModel[index].title.toString()), textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[700],  fontSize: 20)),

SizedBox(height: 20,),

Container(height: 1,color:Colors.red, width:double.maxFinite, margin: EdgeInsets.only(left:20,right:20),),

SizedBox(height: 10,),

  Text(postsListTotal.postModel[index].authorName.toString(), textAlign:TextAlign.center, style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15),), 

   SizedBox(width: 20,), 

   Text("24mins Ago",textAlign:TextAlign.end, style:TextStyle(color:Colors.blueAccent,  fontWeight: FontWeight.bold, fontSize: 15),),

   SizedBox(height: 10,),
            
         ],) 
            
            )
          
           );
            
          },
        );
          


  }

  String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}


}

