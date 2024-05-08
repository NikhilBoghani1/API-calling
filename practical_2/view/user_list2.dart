import 'package:api_calling_http/practical_2/model/user.dart';import 'package:api_calling_http/practical_2/service/api_service.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';import 'package:lottie/lottie.dart';import 'package:shimmer/shimmer.dart';class UserList2 extends StatefulWidget {  const UserList2({super.key});  @override  State<UserList2> createState() => _UserList2State();}class _UserList2State extends State<UserList2> {  ApiService _service = ApiService();  @override  Widget build(BuildContext context) {    return Scaffold(      backgroundColor: CupertinoColors.white,      appBar: AppBar(        backgroundColor: CupertinoColors.white,        centerTitle: true,        title: Text('User List'),      ),      body: LiquidPullToRefresh(        height: 50,        showChildOpacityTransition: false,        animSpeedFactor: 3,        color: CupertinoColors.white,        backgroundColor: CupertinoColors.destructiveRed,        onRefresh: _handleRefresh,        child: FutureBuilder(          future: _service.getUserList(),          builder: (context, snapshot) {            List<User> userList = snapshot.data ?? [];            if (snapshot.connectionState == ConnectionState.waiting) {              return Shimmer.fromColors(                baseColor: Colors.grey.shade200,                highlightColor: Colors.white54,                child: ListView.builder(                  itemCount: 6,                  itemBuilder: (context, index) {                    User user = userList[index];                    return Container(                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),                      child: Row(                        mainAxisAlignment: MainAxisAlignment.spaceAround,                        crossAxisAlignment: CrossAxisAlignment.center,                        children: [                          CircleAvatar(                            radius: 35,                            backgroundColor: Colors.grey,                          ),                          Container(                            width: 270,                            height: 60,                            decoration: BoxDecoration(                              borderRadius: BorderRadius.circular(10),                              color: Colors.grey,                            ),                          ),                        ],                      ),                    );                  },                ),              );            } else if (snapshot.hasError) {              return Center(                child: Lottie.asset(                  width: 200,                  height: 200,                  'animi/Animation.json',                ),              );            } else {              return ListView.builder(                itemCount: userList.length,                itemBuilder: (context, index) {                  User user = userList[index];                  return Card(                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),                    child: ListTile(                      leading: CircleAvatar(                        radius: 40,                        backgroundColor: Colors.grey.shade200,                        foregroundImage: NetworkImage('${user.avatar}'),                      ),                      title: Text('${user.firstName} ${user.lastName}'),                      subtitle: Text('${user.email}'),                    ),                  );                },              );            }          },        ),      ),    );  }  Future<void> _handleRefresh() async {    return await Future.delayed(Duration(seconds: 3));  }}