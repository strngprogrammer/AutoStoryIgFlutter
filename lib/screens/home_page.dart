import 'dart:convert';
import 'dart:io';

import 'package:auto_story/scripts/login.dart';
import 'package:auto_story/scripts/start_loop.dart';
import 'package:auto_story/shared/buttons.dart';
import 'package:auto_story/shared/textediting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_story/globals.dart' as glo;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _hashtag = TextEditingController();
  late List<String> items = [];
  var value = "";
  void LoadHashtags(List<dynamic> hashs) async {
    var user_ids = [];
    glo.stop = false;
    while (!glo.stop) {
      for (var hash in hashs) {
        user_ids.clear();
        var headers = {
          'accept-language': 'en-US,en;q=0.9',
          'content-type': 'application/x-www-form-urlencoded',
          'origin': 'https://www.instagram.com',
          'referer': 'https://www.instagram.com/',
          'User-Agent':
              'Instagram 148.0.0.33.121 Android (28/9; 480dpi; 1080x2137; HUAWEI; JKM-LX1; HWJKM-H; kirin710; en_US; 216817344)',
          'x-csrftoken': 'missing',
          'cookie': 'sessionid=${glo.sessionid}',
          'sec-ch-ua-mobile': '?0',
          'sec-ch-ua-platform': "Windows",
          'sec-fetch-dest': 'empty',
          'sec-fetch-mode': 'cors',
          'sec-fetch-site': 'same-site'
        };
        var url = Uri.parse(
            'https://i.instagram.com/api/v1/users/web_profile_info/?username=$hash');
        var res = await http.get(url, headers: headers);
        try {
          var userid = jsonDecode(res.body)['data']['user']['id'];
          var url = Uri.parse(
              'https://i.instagram.com/api/v1/friendships/$userid/followers/?count=100&search_surface=follow_list_page');
          var res2 = await http.get(url, headers: headers);
          try {
            var json_body = json.decode(res2.body);
            for (var user in json_body['users']) {
              if (user['is_private'] == false) {
                user_ids.add(user['pk']);
              }
            }
            var counter = 0;
            while (counter < user_ids.length) {
              var user = user_ids[counter];
              counter += 1;
              try {
                var url = Uri.parse(
                    'https://i.instagram.com/api/v1/feed/user/$user/story/');
                var headers = {
                  'accept-language': 'en-US,en;q=0.9',
                  'content-type': 'application/x-www-form-urlencoded',
                  'origin': 'https://www.instagram.com',
                  'referer': 'https://www.instagram.com/',
                  'User-Agent':
                      'Instagram 148.0.0.33.121 Android (28/9; 480dpi; 1080x2137; HUAWEI; JKM-LX1; HWJKM-H; kirin710; en_US; 216817344)',
                  'x-csrftoken': 'missing',
                  'cookie': 'sessionid=${glo.sessionid}',
                  'sec-ch-ua-mobile': '?0',
                  'sec-ch-ua-platform': "Windows",
                  'sec-fetch-dest': 'empty',
                  'sec-fetch-mode': 'cors',
                  'sec-fetch-site': 'same-site'
                };

                var res = await http.get(url, headers: headers);
                var json_body = json.decode(res.body);
                for (var item in json_body['reel']['items']) {
                  var story_id = item['pk'];
                  var taken_it = item['taken_at'];
                  var url2 = Uri.parse(
                      'https://i.instagram.com/api/v1/stories/reel/seen');
                  var head = {
                    'user-agent':
                        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36',
                    'x-csrftoken': 'missing',
                    'cookie': 'sessionid=${glo.sessionid}',
                    'content-type': 'application/x-www-form-urlencoded'
                  };
                  var data = {
                    'reelMediaId': story_id.toString(),
                    'reelMediaOwnerId': user.toString(),
                    'reelId': user.toString(),
                    'reelMediaTakenAt': taken_it.toString(),
                    'viewSeenAt': taken_it.toString()
                  };
                  var req3 = await http.post(url2, body: data, headers: head);
                  // ignore: avoid_print
                  setState(() {
                    if (req3.body.contains('{"status":"ok"}')) {
                      glo.done += 1;
                    } else {
                      glo.error += 1;
                    }
                  });
                }
                await Future.delayed(const Duration(seconds: 3));
              } catch (e) {}
              await Future.delayed(const Duration(seconds: 2));
            }
          } catch (e) {}
        } catch (e) {}
      }
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: const Color.fromARGB(255, 59, 36, 100),
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Auto Story Watch",
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, right: 15, left: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.white, width: 1, style: BorderStyle.solid)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  TextEditField(context, "username", false, _username),
                  TextEditField(context, "password", true, _password),
                  MyTallButton(
                      "Login",
                      () =>
                          MakeRequest(context, _username.text, _password.text))
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                        isExpanded: true,
                        style: GoogleFonts.cairo(color: Colors.white),
                        hint: const Text(
                          "usernames",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.black,
                        value: value,
                        items: items.map((String e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        items.remove(e);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic v) {
                          value = v;
                        },
                      ),
                      TextEditField(context, "new user", false, _hashtag),
                      // ignore: void_checks
                      MyTallButton("Add", () {
                        setState(() {
                          value = _hashtag.text;
                          items.add(_hashtag.text);
                        });
                      })
                    ])),
            Container(
                margin: const EdgeInsets.only(
                    top: 10, right: 15, left: 15, bottom: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyShortButton("START", () {
                            LoadHashtags(items);
                            // while (true) {
                            //   sleep(Duration(seconds: 2));
                            //   setState(() {});
                            // }
                          }),
                          MyShortButton("STOP", () {
                            glo.stop = true;
                          }),
                        ],
                      ),
                      Container(
                          margin:
                              const EdgeInsets.only(top: 10, right: 5, left: 5),
                          child: Text(
                            "total watched : ${glo.done}   error : ${glo.error}",
                            style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ))
                    ]))
          ],
        ),
      )),
    );
  }
}
