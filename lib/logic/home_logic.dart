import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class RecentlyPlayedStuff{
  String id;
  String type;
  DateTime lastPlayed;
  String thumbnail;
  String title;

  RecentlyPlayedStuff({this.id, this.type, this.lastPlayed, this.thumbnail, this.title});
}

class RecentlyPlayedLogic extends ChangeNotifier{
  
  bool funCalled = false;


  List<RecentlyPlayedStuff> recntlyPlayedStuff = [];
  void getSongHistory() async{
    final User firebaseUser = FirebaseAuth.instance.currentUser;
    print("Getting Data");

    //////
   /* CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'uid': "testing", // John Doe
        'name': "testing" , // Stokes and Sons

      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    await addUser();
    var qsnap1 = await FirebaseFirestore.instance.collection("users").get();
    List<DocumentSnapshot> data1 = qsnap1.docs;

    for(int i=0; i<data1.length; i++) {
      print("Id " + data1[i]['uid']);
    }*/
    ///////

    QuerySnapshot qsnap = await FirebaseFirestore.instance.collection("users").where('uid', isEqualTo: firebaseUser.uid).get();
    QuerySnapshot qsnap2 = qsnap.docs[0].get("songHistory");//firebaseUser.uid
    List<DocumentSnapshot> data = qsnap2.docs;
    recntlyPlayedStuff = [];
    for(int i=0; i<data.length; i++){
      print("Id "+data[i]['songId']);
      await FirebaseFirestore.instance.collection("songs").doc(data[i]['songId']).get().then((documentSnapshot){
        recntlyPlayedStuff.add(
          RecentlyPlayedStuff(
            id: data[i]['songId'],
            lastPlayed: data[i]['lastPlayed'],
            thumbnail: documentSnapshot['songThumbnail'],
            type: 'song',
            title: documentSnapshot['songTitle'],
          )
        );
      });
    
    }
    getPlaylistHis();
  }

  void getPlaylistHis()async{
    final User firebaseUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot qsnap = await FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("playlistHistory").get();
    List<DocumentSnapshot> data = qsnap.docs;
    for(int i=0; i<data.length; i++){
      await FirebaseFirestore.instance.collection("users").doc(data[i]['playlistUserId']).collection("userCreatedPlayLists").doc(data[i]['playListId']).get().then((documentSnapshot){
        recntlyPlayedStuff.add(RecentlyPlayedStuff(
          id: data[i]['playListId'],
          thumbnail: './images/spotify_smaller.png',
          lastPlayed: data[i]['lastPlayed'],
          type: 'playlist',
          title: documentSnapshot['playlistName']
        ));
      });
    }
    funCalled = true;
    notifyListeners();
  }

}