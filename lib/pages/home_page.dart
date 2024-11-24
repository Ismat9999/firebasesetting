import 'package:cached_network_image/cached_network_image.dart';
import 'package:firesetting/models/post_model.dart';
import 'package:firesetting/pages/details_page.dart';
import 'package:firesetting/services/db_service.dart';
import 'package:firesetting/services/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  static const String id ="Home Page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading=false;
  List<Post>items =[];

  Future callDetailsPage()async{
    bool results =await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return const DetailsPage();
    }));
    if(results){
      _apiLoadPosts();
    }
  }

  _apiLoadPosts()async{
    setState(() {
      isLoading=true;
    });

    List<Post>posts =await DbService.loadPosts();
    LogService.i(posts.length.toString());
    setState(() {
      items =posts;
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              return _itemOfPost(items[index]);
            },
          ),
          isLoading
          ?Center(
            child: CircularProgressIndicator(),
          ):SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          callDetailsPage();
        },
          backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
  Widget _itemOfPost(Post post){
    return Container(
      padding:  EdgeInsets.all(20),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 70,
            height: 70,
            imageUrl: post.img_url!,
            placeholder: (context,url)=>Container(
              color: Colors.grey.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context,url, error)=>Container(
              color: Colors.grey.withOpacity(0.5),
            ),
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              Text(post.content,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
            ],
          ),
        ],
      ),
    );
  }
}