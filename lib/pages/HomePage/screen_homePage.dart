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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SvgPicture.asset(
                            'assets/images/grocerry.svg',
                            color: const Color(0xff424242),
                            // width: 60,
                          ),
                        ),

                        const SizedBox(height:5),

                        Text("address",
                            textAlign: TextAlign.center,
                            style : GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Color(0xff424242)),
                            )).tr(),

                        Text("phone",
                            textAlign: TextAlign.center,
                            style : GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Color(0xff424242)),
                            )).tr(),

                        // Text("email",
                        //     textAlign: TextAlign.center,
                        //     style : GoogleFonts.poppins(
                        //       textStyle: const TextStyle(
                        //           fontSize: 12, color: Color(0xff424242)),
                        //     )).tr(),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text("orderDetails",
                            style : GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                          )).tr(),
                        ),

                        _getDottedLine(),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("invoice_no",
                                  style : GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff424242)),
                                  )).tr(),
                              Text("date",
                                  style : GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff424242)),
                                  )).tr(),
                            ],
                          ),
                        ),

                        _getDottedLine(),


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("#",
                                        style : GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("item",
                                        style : GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("quantity",
                                        style : GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("unit_list_price",
                                        textAlign: TextAlign.center,
                                        style : GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("sale_price",
                                        textAlign: TextAlign.center,
                                        style : GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                        )).tr(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        _getDottedLine(),

                        _getGroceryItemDetails(itemNo: "serial1", itemName: "item_name1", quantity: "quantity_amount1", price: "unit_list_price1", amount: "sale_price1"),

                        const SizedBox(height: 5),

                        _getGroceryItemDetails(itemNo: "serial2",itemName: "item_name2", quantity: "quantity_amount2", price: "unit_list_price2", amount: "sale_price2"),

                        const SizedBox(height: 5),

                        _getGroceryItemDetails(itemNo: "serial3",itemName: "item_name3", quantity: "quantity_amount1", price: "unit_list_price3", amount: "sale_price3"),

                        const SizedBox(height: 5),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "items_count",amount: "items_count_quantity"),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "total_quantity",amount: "total_quantity_amount"),

                        const SizedBox(height: 5),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "discount",amount: "discount_amount"),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "subtotal",amount: "subtotal_amount"),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "tax",amount: "tax_amount"),

                        const SizedBox(height: 5),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "total",amount: "total_amount"),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "round",amount: "round_amount"),

                        const SizedBox(height: 5),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "paid",amount: "paid_amount"),

                        const SizedBox(height: 5),

                        _getQuantityAndPriceDetails(title: "change",amount: "change_amount"),

                        const SizedBox(height: 5),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("amount_in_words",
                                    style : GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff424242)),
                                    )).tr(),
                              ),

                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("amount_in_words_value",
                                      textAlign: TextAlign.right,
                                      style : GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12, color: Color(0xff424242)),
                                      )).tr(),
                                ),
                              ),

                              const SizedBox(height: 5),
                            ],
                          ),
                        ),

                        _getDottedLine(),

                        const SizedBox(height: 5),

                        Text("suggestion",
                            textAlign: TextAlign.center,
                            style : GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Color(0xff424242)),
                            )).tr(),

                        const SizedBox(height: 5),

                        _getDottedLine(),
                        _getDottedLine(),
                        const SizedBox(height: 2),
                        _getDottedLine(),
                        _getDottedLine(),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getOnlySingleDottedLine(),
                            Text("thanks",
                                textAlign: TextAlign.center,
                                style : GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 12, color: Color(0xff424242)),
                                )).tr(),
                            _getOnlySingleDottedLine(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        _getDottedLine(),
                        _getDottedLine(),
                        const SizedBox(height: 2),
                        _getDottedLine(),
                        _getDottedLine(),

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

  Column _getOnlySingleDottedLine() {
    return Column(
      children: const [
        Dash(
            direction: Axis.horizontal,
            length: 5,
            dashLength: 5,
            dashColor: Color(0xff424242)),
        Dash(
            direction: Axis.horizontal,
            length: 5,
            dashLength: 5,
            dashColor: Color(0xff424242)),
        SizedBox(height: 2),
        Dash(
            direction: Axis.horizontal,
            length: 5,
            dashLength: 5,
            dashColor: Color(0xff424242)),
        Dash(
            direction: Axis.horizontal,
            length: 5,
            dashLength: 5,
            dashColor: Color(0xff424242)),
      ],
    );
  }

  Widget _getDottedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dash(
            direction: Axis.horizontal,
            length: constraints.maxWidth,
            dashLength: 5,
            dashGap: 2,
            // dashThickness: 2,
            dashColor: Color(0xff424242));
      },
    );
  }

  Widget _getGroceryItemDetails({String? itemNo, String? itemName, String? quantity, String? price, String? amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemNo!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemName!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 12, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(quantity!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 12, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(price!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 12, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(amount!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 12, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getQuantityAndPriceDetails({String? title, String? amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14,fontWeight: FontWeight.bold, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(amount!,
                  style : GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, color: Color(0xff424242)),
                  )).tr(),
            ],
          ),
        ),
      ],
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
          fontSize: 16,
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