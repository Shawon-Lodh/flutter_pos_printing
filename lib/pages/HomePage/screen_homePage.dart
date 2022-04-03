import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_constants.dart';
import 'package:flutter_pos_printing/pages/HomePage/data_homePage.dart';
import 'package:flutter_pos_printing/pages/HomePage/presenter_homePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';


class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>{

  HomePageScreenData? _homePageScreenData;

  HomePageScreenPresenter? _homePageScreenPresenter;


  @override
  void initState() {
    _homePageScreenData = HomePageScreenData(screenshotController: ScreenshotController());
    _homePageScreenPresenter = HomePageScreenPresenter(context, _homePageScreenData);
    super.initState();
  }

  @override
  void dispose() {
    _homePageScreenData = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        persistentFooterButtons: [
          ///Add Farmer button
          Align(alignment: Alignment.center, child: _getCreateReceiptButton()),
        ],
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(AppConstants.instance.appbarTitle,style: TextStyle(fontSize: 16),),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiceAction,
                icon: const Icon(Icons.language_outlined),
                itemBuilder: (BuildContext context){
                  return AppConstants.instance.popUpChoices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),);
                  }).toList();
                }
                ,)]
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Screenshot(
                  controller: _homePageScreenData!.screenshotControllerValue!,
                  child: Column(
                    children: [
                      SizedBox(height:20),

                      Text("ডিং ডং টেলিকম",  //"Ding Dong Telecom",
                        style : GoogleFonts.mina(
                          textStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                        ),
                      ),

                      SizedBox(height: 10),

                      SvgPicture.asset(
                        'assets/images/telecom.svg',
                        color: Color(0xff424242),
                        // width: 60,
                      ),

                      Text("introduce").tr(),

                      Text("মোবাইল শপ", //"Mobile Shop",
                        style : GoogleFonts.mina(
                          textStyle: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                        ),
                      ),

                      Text("----------------------------------------------------------------------------------"),

                      Text("এস সিও নং : ২১৮, সেক্টর : ১২ডি , চন্ডিগর", //"SCO no : 218, Sector : 12D , Chandigarh",
                        style : GoogleFonts.mina(
                          textStyle: TextStyle(color: Colors.black),
                        ),
                      ),

                      Text("----------------------------------------------------------------------------------"),

                      Text("ট্যাক্স ইনভয়েস" , //"TAX INVOICE"
                        style : GoogleFonts.mina(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),

                      Text("অরিজিনাল" , //"Original"
                        style: GoogleFonts.mina(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),),

                      // Text(
                      //     "----------------------------------------------------------------------------------"),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 20.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         "(  汉字 )",
                      //         style: TextStyle(
                      //             fontSize: 40, fontWeight: FontWeight.bold),
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         "رقم الطلب",
                      //         style: TextStyle(
                      //             fontSize: 30, fontWeight: FontWeight.bold),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      //   child: Text(
                      //       "-------------------------------------------------------------------------------------"),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Center(
                      //         child: Text(
                      //           "التفاصيل",
                      //           style: TextStyle(
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       flex: 6,
                      //     ),
                      //     Expanded(
                      //       child: Center(
                      //         child: Text(
                      //           "السعر ",
                      //           style: TextStyle(
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       flex: 2,
                      //     ),
                      //     Expanded(
                      //       child: Center(
                      //         child: Text(
                      //           "العدد",
                      //           style: TextStyle(
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       flex: 2,
                      //     ),
                      //   ],
                      // ),
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   shrinkWrap: true,
                      //   physics: ScrollPhysics(),
                      //   itemCount: 1,
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       child: Row(
                      //         mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Expanded(
                      //             child: Center(
                      //               child: Text(
                      //                 "臺灣",
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //             ),
                      //             flex: 6,
                      //           ),
                      //           Expanded(
                      //             child: Center(
                      //               child: Text(
                      //                 "تجربة عيوني انتة ",
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //             ),
                      //             flex: 2,
                      //           ),
                      //           Expanded(
                      //             child: Center(
                      //               child: Text(
                      //                 "Test My little pice of huny",
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //             ),
                      //             flex: 2,
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      // Text("----------------------------------------------------------------------------------"),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  /// UI
  Widget _getCreateReceiptButton() {
    return OutlinedButton(
      onPressed: _homePageScreenPresenter!.sendDataForPrinting,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),),
        side: const BorderSide(width: 2,
          color: Colors.redAccent,
          style: BorderStyle.solid,),
      ),
      child: Text(
        AppConstants.instance.printReceipt,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Future<void> choiceAction(String choice) async {
    if(choice == AppConstants.instance.english){
      await context.setLocale(const Locale('en'));
    }
    else if(choice == AppConstants.instance.bangla){
      await context.setLocale(const Locale('bn'));
    }
  }
}