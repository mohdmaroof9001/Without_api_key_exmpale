import 'dart:collection';
import 'dart:convert';
// import 'dart:html';

import 'package:cricketteam/teamsclassmodal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  var teamName = [];
  var playersName = [];
  List<Afghanistan> namesArr = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Cricket Teams"),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Container(
          color: Colors.amber,
          child: ListView.builder(
              itemCount: teamName.length,
              itemBuilder: (context, indexNo) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(namesArr[indexNo].name);
                          // print("hello ${indexNo}");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              teamName[indexNo],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }

  getData() async {
    var resp = await http.get(Uri.parse("http://test.oye.direct/players.json"));
    Map<String, dynamic> teamDict = HashMap();
    teamDict = jsonDecode(resp.body);
    List<String> cityName = [];
    cityName = teamDict.keys.toList();

    List<TeamPlayers> a = [];

    for (var item in teamDict["Bangladesh"]) {
      a.add(TeamPlayers.fromJson(item));
    }

    print(a[0].name);

    var AllTeamsName = json.decode(resp.body);
    var jsonresp = AllTeams.fromJson(AllTeamsName);
    if (jsonresp.india != null) {
      setState(() {
        namesArr = jsonresp.india!.cast<Afghanistan>();
      });
    }
    // namesArr = AllTeams().afghanistan!;

    teamName = AllTeamsName.keys.toList();
    // print(AllTeamsName);
    for (var item in teamName) {
      // print(item);
      // print("$item --> ${AllTeamsName[item]}");
      setState(() {
        teamName = AllTeamsName.keys.toList();
        playersName = AllTeamsName[item];
        //   // print(item + playersName);
      });
    }
  }
}

class TeamPlayers {
  TeamPlayers({
    required this.name,
    required this.captain,
  });
  late final String name;
  late final bool captain;

  TeamPlayers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    captain = json['captain'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['captain'] = captain;
    return _data;
  }
}
