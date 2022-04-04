import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_constants.dart';
import 'package:flutter_pos_printing/common/widgets/widget_custom_dash.dart';
import 'package:flutter_pos_printing/pages/HomePage/data_homePage.dart';
import 'package:flutter_pos_printing/pages/HomePage/presenter_homePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

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
          backgroundColor: const Color(0xffc88719),
          title: Text(AppConstants.instance.appbarTitle,style: const TextStyle(fontSize: 16),),
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Screenshot(
                    controller: _homePageScreenData!.screenshotControllerValue!,
                    child: Column(
                      children: [
                        const SizedBox(height:20),

                        SvgPicture.asset(
                          'assets/images/grocerry.svg',
                          color: const Color(0xff424242),
                          // width: 60,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("orderDetails",
                            style : GoogleFonts.hindSiliguri(
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff424242)),
                          )).tr(),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bill No : SR5",
                                style : GoogleFonts.hindSiliguri(
                                  textStyle: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xff424242)),
                                )).tr(),
                            Text("Date : 04/04/2022",
                                style : GoogleFonts.hindSiliguri(
                                  textStyle: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xff424242)),
                                )).tr(),
                          ],
                        ),

                        const SizedBox(height: 5),

                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Dash(
                                direction: Axis.horizontal,
                                length: constraints.maxWidth,
                                dashLength: 5,
                                dashGap: 2,
                                // dashThickness: 2,
                                dashColor: Color(0xff424242));
                          },
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text("Item",
                                        style : GoogleFonts.hindSiliguri(
                                          textStyle: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text("Qty",
                                        style : GoogleFonts.hindSiliguri(
                                          textStyle: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("Price",
                                        style : GoogleFonts.hindSiliguri(
                                          textStyle: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("Amount",
                                        style : GoogleFonts.hindSiliguri(
                                          textStyle: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Dash(
                                direction: Axis.horizontal,
                                length: constraints.maxWidth,
                                dashLength: 5,
                                dashGap: 2,
                                // dashThickness: 2,
                                dashColor: Color(0xff424242));
                          },
                        ),


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
          color: Color(0xffc88719),
          style: BorderStyle.solid,),
      ),
      child: Text(
        AppConstants.instance.printReceipt,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          color: Color(0xffc88719),
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