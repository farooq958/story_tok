import 'package:flutter/material.dart';

//Basic UI Classes
class ShowCustomAlertDialog extends ChangeNotifier{
  Future showCustomDialog(BuildContext context, String message){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                //color: Colors.green,
                style:style,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Okay!"),
              ),
            ),
          ],
        );
      }
    );
  }
}
