import 'package:absnews/search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:absnews/model.dart';
import 'dart:async';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:async/async.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'tabscreens.dart';
import 'package:absnews/video_screens/home_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABSRADIOTV',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
       
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ABS NEWS'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static final _myTabbedPageKey = new GlobalKey<_MyHomePageState>();

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin<MyHomePage>, SingleTickerProviderStateMixin {
    final _drawerController = ZoomDrawerController();  List<PostsList> listModel = []; 
    ScrollController _controller = new ScrollController(); 
    final AsyncMemoizer _memoizer = AsyncMemoizer();final AsyncMemoizer _memoizer1 = AsyncMemoizer();
    final AsyncMemoizer _memoizer2 = AsyncMemoizer();
    final AsyncMemoizer _memoizer3 = AsyncMemoizer();   final AsyncMemoizer _memoizer6 = AsyncMemoizer();  final AsyncMemoizer _memoizer8 = AsyncMemoizer();
    final AsyncMemoizer _memoizer4 = AsyncMemoizer();   final AsyncMemoizer _memoizer5 = AsyncMemoizer();final AsyncMemoizer _memoizer7 = AsyncMemoizer();
     bool received; PostsList postsList; PostsList postsList1; PostsList postsList2; PostsList postsList3; PostsList postsList7;
     PostsList postsList4;PostsList postsList5; PostsList postsList6; PostsList postsList8;
     Future  _postsFuture,_postsFuture1,_postsFuture2,_postsFuture3,_postsFuture4,_postsFuture5,_postsFuture6,_postsFuture7,_postsFuture8;
     String number_of_posts="50";


     @override
     bool get wantKeepAlive =>true;


   BoxDecoration myBoxDecoration() {
  return BoxDecoration(
   border: Border.all(width:2,color: Colors.red),
   
    
  );
}

String sanitizeTitle(String u){
  String f = u.replaceAll("&#8211; ", "-");
   String g = f.replaceAll("&#8217; ", "'");
  return g;

}

final player = AudioPlayer();   var refreshKey = GlobalKey<RefreshIndicatorState>();

bool drawState; double fontSize = 20.0; bool radioState;   TabController tabController;

 Future<dynamic> _loadAudio() async {

   // return duration;
  await player.setUrl("http://sirius.shoutca.st:8044/;");

 }

 void playAudio(){
  
   

    if(radioState == false)
    {
       player.play();

       setState(() {
          radioState = true;
       print("playing...");
       });
      

    }

    else{

      player.pause();
       setState(() {
       radioState = false;
     print("paused");
      });

    }

  
 }

 @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {

   setState(() {
       drawState = false;
       radioState = false;
         tabController = new TabController(vsync: this, length:10);
      
      try{
       _loadAudio() ;
   }
   catch(e){

   }

      /** _postsFuture = _getPosts("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&fields=id,title,featured_image_url,date,author_meta");
        
        _postsFuture1 = _getPosts1("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=5&fields=id,title,featured_image_url,date,author_meta");
     
        _postsFuture2  = _getPosts2("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=13&fields=id,title,featured_image_url,date,author_meta");

        _postsFuture3 = _getPosts3("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=11&fields=id,title,featured_image_url,date,author_meta");

        _postsFuture4 = _getPosts4("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=3&fields=id,title,featured_image_url,date,author_meta");

        _postsFuture5 = _getPosts5("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=7&fields=id,title,featured_image_url,date,author_meta");

        _postsFuture6 = _getPosts6("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=6&fields=id,title,featured_image_url,date,author_meta");
    
        _postsFuture7 = _getPosts7("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=4&fields=id,title,featured_image_url,date,author_meta");

        _postsFuture8 = _getPosts8("http://absradiotv.com/wp-json/wp/v2/posts?&per_page=30&categories[]=14&fields=id,title,featured_image_url,date,author_meta");
    **/
     });
  

    super.initState();
  }

  

 



Color _colorFromHex(String hexColor) {
final hexCode = hexColor.replaceAll('#', '');
return Color(int.parse('FF$hexCode', radix: 16));

   }

   Future<Null> refresh(String passClass) async{
      refreshKey.currentState?.show(atTop: false);
   setState(() {
     new FirstTab();
     print("refresh pulled!");
    
   });  
    return null;

   }

   Widget mainScreen(){
     int number_of_tabs = 10;
     
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
         backgroundColor: Colors.white,
          leading: new IconButton(
    icon: new Icon(Icons.menu, color: Colors.black,),
    onPressed: () {
        
         if(drawState == true)
         {
            _drawerController.close();
            drawState = false;
         }

         
          else
          {
            _drawerController.open();
             drawState = true;
          }
         
    },
  ),
        title: Row(children:[
            SizedBox(width: 40,),

        Center(child: radioState==false? Text("ABS NEWS",style:TextStyle(color:Colors.red)):Text("ABS 88.5 Fm",style:TextStyle(color:Colors.red))),
        SizedBox(width: 60,),

       new IconButton(
    icon: new Icon(Icons.search, color: Colors.black,),
    onPressed: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search(),
                       ),);

    },
  ),
      ])),
      body: DefaultTabController(
        length: number_of_tabs,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.red,
                tabs: [
                Tab(child: Text("LATEST",style: TextStyle(color: _colorFromHex("#151B54")),),),
                 Tab(child: Text("VIDEOS",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("STATE",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("NIGERIA",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("POLITICS",style: TextStyle(color:_colorFromHex("#151B54")),),),
                Tab(child: Text("FOREIGN",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("BUSINESS",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("ENTERTAINMENT",style: TextStyle(color: _colorFromHex("#151B54")),),),
                Tab(child: Text("SPORTS",style: TextStyle(color: _colorFromHex("#151B54")),),),
                 Tab(child: Text("EDITORIALS",style: TextStyle(color: _colorFromHex("#151B54")),),),
              ]),
            ),

            
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: tabController,
                  children: [
  
                 RefreshIndicator(
                    onRefresh: ()=>refresh("first_tab"),
                      key: refreshKey,
                 child:Container(
                   child: GestureDetector(
    onHorizontalDragEnd: (DragEndDetails details) {
      if ((details.primaryVelocity > 0)&&(tabController.index==0)){
       // print("right");
     // print(_tabController.index);
     _drawerController.open();
    
      }  

      else if((details.primaryVelocity < 0)&&(tabController.index>=0)){
            
        setState(() {
           print("swiped left");
        tabController.animateTo(tabController.index+1);
        });
       
           
      }

       else if((details.primaryVelocity > 0)&&(tabController.index>0)){
            
        setState(() {
           print("swiped right");
        tabController.animateTo(tabController.index-1);
        });
       
           
      }

      else if((tabController.index == number_of_tabs)&&((details.primaryVelocity > 0))){
        print("last tab");
        tabController.animateTo(0);
      }
      

       
    },
                   child: FirstTab(),),),),
                
                
                  Container(
                     child: VideoScreen(),
                      ),
                
                      Container(
                 child:SecondTab(),
               
                  ),   
                 Container(
                   child:ThirdTab()     
                  ),

                  Container(
                   child:FourthTab()     
                  ),
                  
              
                   Container(
                    child:FifthTab()     
             
                  ),
                  Container(
                     child:SixthTab()       ),

                  Container(
                      child: SevenTab()                    ),
                     Container(
                       child:EightTab()
                  ),
                  Container(
                   child:TabNine()
                  ),

                 
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _colorFromHex("#151B54"),
        onPressed:()=>playAudio(),// _incrementCounter,
        tooltip: 'Increment',
        child: radioState==false?Icon(Icons.play_arrow):Icon(Icons.pause)
      ), // This trailing comma makes auto-formatting nicer for build methods.
  );
   }

   /*Widget for nav drawer screen*/

   Widget navLinks(){
     return Container(
     
    child: Column(
        children:<Widget>[
           SizedBox(height:20),

     
      ListTile(
        leading:Container(margin:EdgeInsets.only(left:30),child:Icon(Icons.account_circle, color:  _colorFromHex("#ffffff"),size: fontSize,)),
        title: Text('Mdddd',
        style: TextStyle(fontSize: 20,),
        
        ),
        onTap: () {
         
        },
      )
    
        ])
     );
   }
   

    Widget navDrawer() {

    return Stack(children: [

    
    
    Container(decoration: new BoxDecoration(
    image: new DecorationImage(
      image: new NetworkImage("http://www.absradiotv.com/wp-content/uploads/2020/10/anambra-landscape-500x308.jpg"),
      fit: BoxFit.cover,
    ),),
    ),



    Container(color:Colors.black.withOpacity(0.7)),

    /*Row(children: [
      Container(color:Colors.green),  Container(color:Colors.green)
    ],)*/

    Container(child:Row(children: [
      Container(width:250,height:500, 
      child: Center(child: Column(children:[
        SizedBox(height: 50,),

        
        GestureDetector(
                        onTap: ()=>{},
                        child: Text("Videos",style:TextStyle(color: Colors.white, fontSize: fontSize,decoration:TextDecoration.none)),
                        //() async => await _tap1(),
      ),

       SizedBox(height: 30,),

       GestureDetector(
                        onTap: ()=>{},
                        child: Text("Programmes",style:TextStyle(color: Colors.white, fontSize: fontSize,decoration:TextDecoration.none)),
                        //() async => await _tap1(),
      ),

       SizedBox(height: 30,),

       GestureDetector(
                        onTap: ()=>{},
                        child: Text("Presenters",style:TextStyle(color: Colors.white, fontSize: fontSize,decoration:TextDecoration.none)),
                        //() async => await _tap1(),
      ),

       

       SizedBox(height: 30,),

       GestureDetector(
                        onTap: ()=>{},
                        child: Text("Contact Us",style:TextStyle(color: Colors.white, fontSize: fontSize,decoration:TextDecoration.none)),
                        //() async => await _tap1(),
      ),

       SizedBox(height: 30,),

      GestureDetector(
                        onTap: ()=>{},
                        child: Text("Privacy Policy",style:TextStyle(color: Colors.white, fontSize: fontSize,decoration:TextDecoration.none)),
                        //() async => await _tap1(),
      )
        
      ]),)
      
      ),  
      
      Container(color:Colors.green)
    
    ],)),

  
    ],);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

   
      return ZoomDrawer(
      controller: _drawerController,
      menuScreen: navDrawer(),
      mainScreen: mainScreen(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*(ZoomDrawer.isRTL()? .45: 0.65),
      
    );

   
  }

  Widget loadPosts(PostsList postsListTotal){
   
     return ListView.builder(
            shrinkWrap: true,
          itemCount: postsListTotal.postModel.length,
          physics: NeverScrollableScrollPhysics(), // new
          controller: _controller,
          itemBuilder: (context, index) {
            
            
          
   
            
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
}




