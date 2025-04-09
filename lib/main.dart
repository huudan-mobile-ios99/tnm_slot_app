import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_client/navigation/navigation_page.dart';
import 'package:tournament_client/service/service_ip.dart';
import 'package:tournament_client/xpage/admin/admin_verify.dart';
import 'package:tournament_client/xpage/container/containerpage.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_client/utils/mycolors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;


  final ServiceIP serviceIP = ServiceIP();
  late String ipAddress='';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    serviceIP.getPublicIp().then((ip){
      setState(() {
        ipAddress = ip;
      });
    });

  }

  Future<void> _checkLoginStatus() async {
    isLoggedIn = await UserLoginManager.isLoggedIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyString.APP_NAME,
        theme: ThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          cardColor: MyColor.grey_tab,
          platform: TargetPlatform.windows,
          hoverColor: Colors.grey.shade200,
          primaryColor: MyColor.appBar,
          dividerColor: Colors.grey,
          indicatorColor: MyColor.appBar,
          scaffoldBackgroundColor: Colors.white,
          highlightColor: Colors.grey,
          hintColor: Colors.grey,
          disabledColor: Colors.grey,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(hoverColor: MyColor.grey_tab),
          colorScheme: ColorScheme.fromSeed(seedColor: MyColor.red),
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/containerPage': (context) => ContainerPage(
                url: MyString.BASEURL,
                selectedIndex: MyString.DEFAULTNUMBER,
          ),
        },

        ////ADMIN AND GAME PAGE
        home: isLoggedIn == false ? const AdminVerify() :  const NavigationPage());
        // home:const MachineTopPageRealTime(
        //     selectedNumber: '${MyString.DEFAULTNUMBER}',
        // ));


        //TOP RANKING PAGE
        // home:MachineViewContainer());




        //ONLY GAME PAGE
        // home: GamePage(
        //         isChecked: false,
        //         selectedNumber: "",
        //         uniqueId:ipAddress,
        //       )
        // );
  }
}

//user login
class UserLoginManager {
  static const String _loggedInKey = 'isLoggedIn';
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }
}
