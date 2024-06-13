import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// initialize GoogleSignIn with scopes
const List<String> scopes = <String>[
  'email',
  'profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);


class LoginPage extends StatefulWidget {
  
  const LoginPage({super.key});


  @override
  LoginPageState createState() => LoginPageState();
  
}

class LoginPageState extends State<LoginPage> {
  
  @override
  void initState() {
    super.initState();

    // listen onCurrentUserChanged  and call keyycloak login

    _googleSignIn.onCurrentUserChanged.listen((event) {
      event?.authentication.then((value) {
        String accessToken = value.accessToken!;

        print('Access Token $accessToken');

        _login('google', accessToken);
      });
    }).onError((error) {
      print(error);
    });
  }

  

  void _login(String provider, String token) async {
    //Dio to call keycloak login endpoint
    Dio dio = Dio();
    Map<String, String> data = {};

    data['grant_type'] = 'urn:ietf:params:oauth:grant-type:token-exchange';
    data['subject_token_type'] =
        'urn:ietf:params:oauth:token-type:access_token';
    data['client_id'] = 'pohapp';
    data['subject_token'] = token;
    data['subject_issuer'] = provider;

    final response = await dio.post(
        'http://192.168.100.6:5002/realms/realm_pohapp/protocol/openid-connect/token',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType));

    print('Status ${response.statusCode}');
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Social Login Example",style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/2560px-Google-flutter-logo.svg.png"),
            height: 100,
          ),
          const SizedBox(
            height: 70,
          ),
          const Image(
            image: NetworkImage(
                "https://www.xpand-it.com/wp-content/uploads/2020/06/Keycloak-logo.png"),
            height: 100,
          ),
          const SizedBox(
            height: 70,
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(10.0),
              onPressed: () => _googleSignIn.signIn(),
              color: Colors.white,
              elevation: 5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_videoposter_006.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Login with Google    "),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}