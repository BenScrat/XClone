import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './bo/tweet_contenu.dart';

class TwitterPage extends StatelessWidget {
  const TwitterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Twitter",style: TextStyle(color: Colors.white),),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor:Colors.lightBlue,
      ),
      body:  Column(
        children: [
          const TopNavigationTwitter(),
          FutureBuilder<Response>(
              future: get(Uri.parse('https://raw.githubusercontent.com/Chocolaterie/EniWebService/main/api/tweets.json')),
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.data != null){
                  final listMapJSON = jsonDecode(snapshot.data!.body) as List<dynamic>;
                  final listTweetContenus = listMapJSON.map((mapJSON) => TweetContenu.fromMap(mapJSON)).toList();
                  return Flexible(
                    child: ListView.builder(

                        itemCount: listTweetContenus.length,
                      itemBuilder: (context, index) => TweetWithButtons(tweetContenu: listTweetContenus[index],),
                    ),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              }
          ),
        ],
      ),
      bottomNavigationBar:  const BottomNavigationTwitter(),
    );
  }
}

class TweetWithButtons extends StatelessWidget {
  final TweetContenu tweetContenu;
  const TweetWithButtons( {
    super.key, required this.tweetContenu,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Tweet(tweetContenu: tweetContenu),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonTweetBar(),
          )
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  final TweetContenu tweetContenu;
  const Tweet({super.key, required this.tweetContenu,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          Image.network("https://picsum.photos/150",width: 125,height: 125,),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tweetContenu.author),
                      Text(tweetContenu.message),
                    ],
                  ),],
              ),
            ),
          )
        ]
    );
  }
}

class ButtonTweetBar extends StatefulWidget {

  const ButtonTweetBar({
    super.key,
  });

  @override
  State<ButtonTweetBar> createState() => _ButtonTweetBarState();
}

class _ButtonTweetBarState extends State<ButtonTweetBar> {
  bool _isLiked = false;
  bool _isRT = false;
  bool _isUndo = false;

  void _changeLike(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isLiked = !_isLiked;
    });
  }
  void _changeRT(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isRT = !_isRT;
    });
  }

  void _changeUndo(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isUndo = !_isUndo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _isUndo ?
        IconButton(icon: const Icon(Icons.undo, color: Colors.blue,),onPressed: ()=>_changeUndo(),)
            :
        IconButton(icon: const Icon(Icons.undo),onPressed: ()=>_changeUndo(),),
        _isRT ?
        IconButton(icon: const Icon(Icons.repeat, color: Colors.blue,),onPressed: ()=>_changeRT(),)
            :
        IconButton(icon: const Icon(Icons.repeat),onPressed: ()=>_changeRT(),),
        _isLiked ?
        IconButton(icon: const Icon(Icons.favorite, color: Colors.red,),onPressed: ()=>_changeLike(),)
            :
        IconButton(icon: const Icon(Icons.favorite_border),onPressed: ()=>_changeLike(),)
      ],
    );
  }
}

class TopNavigationTwitter extends StatelessWidget {
  const TopNavigationTwitter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0xFF,0x58,0xB0,0xF0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Colors.white),),
            TextButton(onPressed: (){}, child: const Text("Accueil",
              style: TextStyle(color: Colors.white),)),
            IconButton(onPressed: (){}, icon:const Icon(Icons.search,color: Colors.white),),
          ],),
      ),
    );
  }
}

class BottomNavigationTwitter extends StatelessWidget {
  const BottomNavigationTwitter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: (){}, child: const Text("Fil",
          style: TextStyle(color: Colors.blue),)),
        TextButton(onPressed: (){}, child: const Text("Notification",
          style: TextStyle(color: Colors.grey),)),
        TextButton(onPressed: (){}, child: const Text("Messages",
          style: TextStyle(color: Colors.grey),)),
        TextButton(onPressed: (){}, child: const Text("Moi",
          style: TextStyle(color: Colors.grey),)),
      ],
    );
  }
}