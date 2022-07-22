import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:auto_story/globals.dart' as glo;

void MakeRequest(BuildContext context, String username, String password) async {
  var headers = {
    'accept-language': 'en-US,en;q=0.9',
    'content-type': 'application/x-www-form-urlencoded',
    'origin': 'https://www.instagram.com',
    'referer': 'https://www.instagram.com/',
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
    'x-csrftoken': 'missing',
  };

  var data =
      'enc_password=#PWD_INSTAGRAM_BROWSER:0:1658344227:$password&username=$username';

  var url = Uri.parse('https://www.instagram.com/accounts/login/ajax/');
  var res = await http.post(url, headers: headers, body: data);
  if (res.body.contains("userId")) {
    var head = (res.headers['set-cookie']);
    var sessionId = (RegExp(r'sessionid=(.*?);').firstMatch(head!)?.group(1));

    var headers = {
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/x-www-form-urlencoded',
      'origin': 'https://www.instagram.com',
      'referer': 'https://www.instagram.com/',
      'User-Agent':
          'Instagram 148.0.0.33.121 Android (28/9; 480dpi; 1080x2137; HUAWEI; JKM-LX1; HWJKM-H; kirin710; en_US; 216817344)',
      'x-csrftoken': 'missing',
      'cookie': 'sessionid=$sessionId',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': "Windows",
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-site'
    };
    var url = Uri.parse(
        'https://i.instagram.com/api/v1/users/web_profile_info/?username=$username');
    var res2 = await http.get(url, headers: headers);
    if (res2.body.contains("biography")) {
      glo.sessionid = sessionId;
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (ctx) {
            return AlertDialog(
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
              title: Text(
                "SPAMV4 FREE",
                style: GoogleFonts.cairo(
                  color: Colors.black,
                ),
              ),
              content: Text(
                "Logged in as @$username",
                style: GoogleFonts.cairo(
                  color: Colors.black,
                ),
              ),
            );
          });
    } else {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (ctx) {
            return AlertDialog(
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
              title: Text(
                "SPAMV4 FREE",
                style: GoogleFonts.cairo(
                  color: Colors.black,
                ),
              ),
              content: Text(
                "account banned or secure !",
                style: GoogleFonts.cairo(
                  color: Colors.black,
                ),
              ),
            );
          });
    }
  } else if (res.body.contains("challenge")) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
            title: Text(
              "SPAMV4 FREE",
              style: GoogleFonts.cairo(
                color: Colors.black,
              ),
            ),
            content: Text(
              "challenge requierd accept and login again!",
              style: GoogleFonts.cairo(
                color: Colors.black,
              ),
            ),
          );
        });
  } else {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
            title: Text(
              "SPAMV4 FREE",
              style: GoogleFonts.cairo(
                color: Colors.black,
              ),
            ),
            content: Text(
              "username or password is incorrect!",
              style: GoogleFonts.cairo(
                color: Colors.black,
              ),
            ),
          );
        });
  }
}
