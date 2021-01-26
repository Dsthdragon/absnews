import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:text/text.dart" as text;


class MyPost extends StatefulWidget {


     MyPost({Key key,@required this.date, this.author, @required this.img,@required this.title,  this.content,}) : super(key: key);

       final img; final title,content; final author,date;

  @override
  _MyPostState createState() => _MyPostState();
}



class _MyPostState extends State<MyPost>  {

void _close(){

}

String toStr(List<int> characters) => new String.fromCharCodes(characters);


  Widget build(BuildContext context) {

    
  
      
    return Scaffold(
      
   body: 

   NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0, leading: Icon(Icons.arrow_back_ios, color:Colors.black),
              backgroundColor: Colors.white,

              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true, 
                  
                  background: 

     TransitionToImage(
     
       
          image: AdvancedNetworkImage(
          
                    widget.img.toString(), 
                     height:double.maxFinite.toInt(),  width: double.maxFinite.toInt(),
                    fallbackAssetImage: "assets/error2.png", 
                    timeoutDuration: Duration(seconds: 20),
                    retryLimit: 3,
                  //  loadedCallback: () => print('It works!'),
                   loadFailedCallback: () => print('Image failed to load properly, discarding...'),
                  ),)
) ,
            ),
          ];
        },

   
   
   body: SingleChildScrollView(
     child: Column(children: [

//post Title

SizedBox(height:20), Container(height:2,color: Colors.red, width: double.maxFinite-20,),

SizedBox(height:20),

Text(widget.title, 
    textAlign: TextAlign.center, style:TextStyle(color: Colors.blue[600],  fontSize: 22)),

    SizedBox(height:10),

Text("By:"+" "+widget.author,style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold,  fontSize: 17)),
   SizedBox(height:10),
   Text(widget.date,style:TextStyle(color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 17)),
   SizedBox(height:10),
Html(
  data: widget.content,

  
  onImageTap: (src) {
        // Display the image in large form.
        print(src.toString());
      },

      style: {
            "p": Style(
              fontSize: FontSize(18),
              margin: EdgeInsets.only(left:10,right:10,top:20, bottom:20),

//              color: Colors.white,

               
            ),


            "img": Style(margin:EdgeInsets.only(left:10,right:10,top:10,bottom:20),
            padding: EdgeInsets.only(left:10,right:10,top:10,bottom:20),
            //borderRadius: BorderRadius.circular(num)
            
            )

       },


  onImageError: (exception, stackTrace) {
            print(exception);
          },

  onLinkTap: (url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  },
),





],)


),
   
   
   ));
    
    

  }

}