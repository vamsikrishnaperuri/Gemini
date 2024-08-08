import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}


class _ChatbotState extends State<Chatbot> {

  ChatUser myself = ChatUser(id: '1',firstName: 'Vamsi');
  ChatUser bot = ChatUser(id: '2',firstName: 'Gemini');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing=[];

  final oururl = 'Enter your API here.....';
  final header={
    'Content-Type': 'application/json'
  };
  getData(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {

    });
    var data = {"contents":[{"parts":[{"text":m.text}]}]};

    await http.post(Uri.parse(oururl),headers: header,body: jsonEncode(data))
        .then((value){
          if(value.statusCode==200){
            var result = jsonDecode(value.body);
            print(result['candidates'][0]['content']['parts'][0]['text']);
            ChatMessage m1 = ChatMessage(
              text: result['candidates'][0]['content']['parts'][0]['text'],
                user: bot,
                createdAt: DateTime.now());
            
            allMessages.insert(0, m1);
          }else{
            print("Error occured");
          }
    })
        .catchError((e){});
    typing.remove(bot);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(centerTitle: true,backgroundColor: Colors.white10,title: Text("Google Gemini",
        style:GoogleFonts.salsa(textStyle: TextStyle(color: Colors.amber[800],fontSize: 30,)),),),
      backgroundColor: Colors.black,

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/images/newbg.jpg'),fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: DashChat(
            typingUsers: typing,
              currentUser: myself,
              onSend: (ChatMessage m){
                getData(m);
              },
              messages: allMessages,
            inputOptions: const InputOptions(
              alwaysShowSend: true,
              cursorStyle: CursorStyle(color: Colors.black54),
            ),
            messageOptions: MessageOptions(
              currentUserContainerColor: Colors.amber[900],
              avatarBuilder: yourAvatarbuilder,
            ),
          ),
        ),
      ),
    );
  }

  Widget yourAvatarbuilder(ChatUser user,Function? onAvatarTap,Function? onAvatarLongPress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Image.asset('lib/images/chatbot.png',height: 40,width: 40,)),
    );
  }
}
