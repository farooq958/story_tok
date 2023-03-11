import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storily/components/page_uploader.dart';
import 'package:storily/components/video_uploader_page.dart';

//This page is the author's center
////////////////////////////////////
class MyStorilyAuthorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("My Storily"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 0, 254, 100),
                  Color.fromRGBO(51, 51, 153, 100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: AuthorCenterPageUI(),
        )
    );
  }
}

class AuthorCenterPageUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/bitRead_logo_banner_Placeholder.png', height: MediaQuery.of(context).size.height*0.12,),
          Text("Millions of Stories. \n Free on BitRead.", style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Upload Video", style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                ),),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoUploader()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.mail_outline, color: Colors.black,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("Add Videos", style: TextStyle(//this is a short cut for the author to update videos
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),),
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PageUploader())); //short cut for author to upload their book
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                        child: ChangeNotifierProvider(
                          create: (_)=>Admin(),
                          child: SpotifyAdmin(),
                        ),
                      )));*/
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.mail_outline, color: Colors.black,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("UPLOAD NEW STORIES", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),),
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PageUploader())); //short cut for author to upload their book
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                        child: ChangeNotifierProvider(
                          create: (_)=>Admin(),
                          child: SpotifyAdmin(),
                        ),
                      )));*/
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.mail_outline, color: Colors.black,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("Schedual Reading Event", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),),
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PageUploader())); //short cut for author to upload their book
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
                        child: ChangeNotifierProvider(
                          create: (_)=>Admin(),
                          child: SpotifyAdmin(),
                        ),
                      )));*/
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.mail_outline, color: Colors.black,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("My BOOKS", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
