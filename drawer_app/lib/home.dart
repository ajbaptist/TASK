import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;
  List userdata;
  Future getdata() async {
    var dio = Dio();
    final response = await dio.get('https://reqres.in/api/users?page=2');
    data = response.data;
    userdata = data["data"];
    print(userdata);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 5),
            child: Text(
              '+ADD',
              style: TextStyle(color: Colors.grey.shade900),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Provider'),
                Text('Staff',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text('Patients'),
              ],
            ),
            Divider(
              height: 20,
              thickness: 3,
              indent: 100,
              endIndent: 100,
              color: Colors.pink,
            ),
            Container(
              color: Colors.pink.shade500,
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    hintText: 'Search for the conversations',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.white,
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userdata[index]["avatar"]),
                          ),
                          title: Text(
                              "${userdata[index]["first_name"]} ${userdata[index]["last_name"]}"),
                          subtitle: Text(userdata[index]["email"]),
                        ));
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: Colors.pink,
            ),
            label: 'conversation'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            label: 'calender'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
              color: Colors.grey,
            ),
            label: 'portifoilo'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'My Profile')
      ]),
    );
  }
}
