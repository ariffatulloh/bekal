import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/dropdownBasic.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/page/utility_ui/config_wave_widget.dart';
import 'package:bekal/page/utility_ui/wave_widget.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WithdrawlScreen extends StatefulWidget {
  int idStore = -1;
  WithdrawlScreen({required this.idStore});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WithdrawlScreenState();
  }
}

class WithdrawlScreenState extends State<WithdrawlScreen> {
  bool tabReqPayout = true;
  var listStoreDisbursementCard = [];
  bool isLoadingGetlistStoreDisbursementCard = true;
  var listStoreHistoryDisbursement = [];
  bool isLoadingGetListStoreHistoryDisbursement = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: NeumorphicIcon(
              Icons.arrow_drop_down_circle_sharp,
              style: NeumorphicStyle(
                depth: .2.h,
                color: Colors.white,
              ),
              size: 10.w,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                      top: 5.h,
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: WaveWidget(
                          config: CustomConfig(
                            gradients: [
                              [
                                const Color.fromRGBO(63, 142, 252, .4),
                                const Color.fromRGBO(63, 142, 252, .1)
                              ],
                              [
                                const Color.fromRGBO(243, 146, 0, .5),
                                const Color.fromRGBO(243, 146, 0, .1)
                              ],
                              [
                                const Color.fromRGBO(233, 78, 27, .5),
                                const Color.fromRGBO(233, 78, 27, .1)
                              ],
                              [
                                const Color.fromRGBO(231, 48, 42, .5),
                                const Color.fromRGBO(231, 48, 42, .1)
                              ]
                            ],
                            durations: [18000, 9440, 10800, 6000],
                            heightPercentages: [-0.20, -0.23, -.1, -.22],
                            blur: const MaskFilter.blur(BlurStyle.solid, 20),
                            gradientBegin: Alignment.bottomLeft,
                            gradientEnd: Alignment.topRight,
                          ),
                          waveAmplitude: 8,
                          waveFrequency: 2,
                          heightPercentange: 2,
                          isLoop: true,
                          size: Size(100.w, 20.h),
                        ),
                      )),
                  Positioned(
                    top: 5.h,
                    child: Container(
                      height: 15.h,
                      width: 100.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeumorphicText(
                            'Total Uang',
                            style: NeumorphicStyle(
                                color: Colors.white,
                                depth: 1.2,
                                intensity: 1,
                                surfaceIntensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.sp),
                          Center(
                            child: NeumorphicText(
                              'IDR 100.000',
                              style: NeumorphicStyle(
                                  color: Colors.white,
                                  depth: 1.2,
                                  intensity: 1,
                                  surfaceIntensity: 1),
                              textStyle: NeumorphicTextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    child: Container(
                      height: 70.h,
                      width: 100.w,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Neumorphic(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.w),
                            margin: EdgeInsets.only(bottom: 1.h),
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.rect(),
                                depth: 3,
                                intensity: 1,
                                surfaceIntensity: 1,
                                color: Colors.white70),
                            child: Row(
                              children: [
                                Expanded(
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      setState(() {
                                        tabReqPayout = true;
                                      });
                                    },
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.h,
                                      horizontal: 1.w,
                                    ),
                                    style: NeumorphicStyle(
                                        depth: tabReqPayout ? -2 : 1,
                                        intensity: 1,
                                        surfaceIntensity: 1,
                                        color: tabReqPayout
                                            ? Colors.deepOrangeAccent
                                                .withOpacity(.2)
                                            : Colors.white70),
                                    child: Center(
                                      child: Text(
                                        "Penarikan Dana",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp,
                                            color: tabReqPayout
                                                ? Colors.blueAccent
                                                : Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Expanded(
                                  child: NeumorphicButton(
                                    onPressed: () async {
                                      getHistoryDisbursement();
                                      setState(() {
                                        tabReqPayout = false;
                                      });
                                    },
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.h,
                                      horizontal: 1.w,
                                    ),
                                    style: NeumorphicStyle(
                                        depth: !tabReqPayout ? -2 : 1,
                                        intensity: 1,
                                        surfaceIntensity: 1,
                                        color: !tabReqPayout
                                            ? Colors.deepOrangeAccent
                                                .withOpacity(.2)
                                            : Colors.white70),
                                    child: Center(
                                      child: Text(
                                        "Riwayat Penarikan Dana",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp,
                                            color: !tabReqPayout
                                                ? Colors.blueAccent
                                                : Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: tabReqPayout
                                ? ContainerRequestPayout()
                                : ContainerHistoryRequestPayout(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ContainerHistoryRequestPayout() {
    return isLoadingGetListStoreHistoryDisbursement
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : listStoreHistoryDisbursement.length < 1
            ? Center(
                child: Text('Tidak Memiliki Daftar Bank/E-wallet'),
              )
            : ListView.builder(
                itemCount: listStoreHistoryDisbursement.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.w,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.2.w),
                    child: Neumorphic(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.h, horizontal: 1.2.w),
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.rect(),
                          color: Colors.deepOrangeAccent.withOpacity(.2),
                          depth: 2,
                          intensity: 1,
                          surfaceIntensity: 1),
                      child: Row(
                        children: [
                          // Container(
                          //   width: 10.w,
                          //   child: Image.asset(
                          //     'assets/icon_bca.png',
                          //     fit: BoxFit.fitWidth,
                          //   ),
                          // ),
                          // Container(child: NeumorphicText,)
                          // SizedBox(
                          //   width: 2.w,
                          // ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 0).format(listStoreHistoryDisbursement[index]['amount'] ?? 0)}',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  maskCardNumber(
                                      "${listStoreHistoryDisbursement[index]['accountNumber']}",
                                      '#'),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'A/N: ${listStoreHistoryDisbursement[index]['accountHolderName']}',
                                  style: TextStyle(
                                      fontSize: 10.sp, letterSpacing: 1.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Bank / E-wallet: (${listStoreHistoryDisbursement[index]['bankCode']})',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Status: (${listStoreHistoryDisbursement[index]['status']})',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.purple),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return DialogRequestDisbursement(
                                        idDisbursementCard:
                                            listStoreDisbursementCard[index]
                                                ['id'],
                                        idStore: widget.idStore,
                                        onDismiss: (isDismiss) async {
                                          setState(() {
                                            isLoadingGetlistStoreDisbursementCard =
                                                true;
                                          });
                                          await getDisbursementCards();
                                          print('wawa');
                                        });
                                  });
                            },
                            child: NeumorphicIcon(
                              Icons.open_in_new,
                              size: 7.5.w,
                              style: NeumorphicStyle(
                                  color: Colors.black87, depth: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }

  Widget ContainerRequestPayout() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: 100.w,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.2.w),
            child: NeumorphicButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return DialogAddDisbursementCard(
                          idStore: widget.idStore,
                          onDismiss: (isDismiss) async {
                            setState(() {
                              isLoadingGetlistStoreDisbursementCard = true;
                            });
                            await getDisbursementCards();
                            print('wawa');
                          });
                    });
              },
              style: NeumorphicStyle(
                color: Colors.deepOrangeAccent.withOpacity(.2),
                depth: 2,
                intensity: 1,
                surfaceIntensity: 1,
              ),
              child: Column(
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                        color: Colors.transparent,
                        depth: -2,
                        boxShape: NeumorphicBoxShape.circle()),
                    child: NeumorphicIcon(
                      Icons.add,
                      style: NeumorphicStyle(color: Colors.black54, depth: 3),
                      size: 10.w,
                    ),
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Center(
                    child: Text("Tambah Bank Baru"),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: isLoadingGetlistStoreDisbursementCard
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : listStoreDisbursementCard.length < 1
                    ? Center(
                        child: Text('Tidak Memiliki Daftar Bank/E-wallet'),
                      )
                    : ListView.builder(
                        itemCount: listStoreDisbursementCard.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 1.2.w),
                            child: Neumorphic(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 1.2.w),
                              style: NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.rect(),
                                  color:
                                      Colors.deepOrangeAccent.withOpacity(.2),
                                  depth: 2,
                                  intensity: 1,
                                  surfaceIntensity: 1),
                              child: Row(
                                children: [
                                  // Container(
                                  //   width: 10.w,
                                  //   child: Image.asset(
                                  //     'assets/icon_bca.png',
                                  //     fit: BoxFit.fitWidth,
                                  //   ),
                                  // ),
                                  // Container(child: NeumorphicText,)
                                  // SizedBox(
                                  //   width: 2.w,
                                  // ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maskCardNumber(
                                              "${listStoreDisbursementCard[index]['accountNumber']}",
                                              '#'),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'A/N: ${listStoreDisbursementCard[index]['accountHolderName']}',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              letterSpacing: 1.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Bank / E-wallet: (${listStoreDisbursementCard[index]['bankCode']})',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return DialogRequestDisbursement(
                                                idDisbursementCard:
                                                    listStoreDisbursementCard[
                                                        index]['id'],
                                                idStore: widget.idStore,
                                                onDismiss: (isDismiss) async {
                                                  setState(() {
                                                    isLoadingGetlistStoreDisbursementCard =
                                                        true;
                                                  });
                                                  await getDisbursementCards();
                                                  print('wawa');
                                                });
                                          });
                                    },
                                    child: NeumorphicIcon(
                                      Icons.open_in_new,
                                      size: 7.5.w,
                                      style: NeumorphicStyle(
                                          color: Colors.black87, depth: 3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }

  String maskCardNumber(String cardNumber, String mask) {
    // format the number
    String newString = '';
    for (int i = 0; i < cardNumber.length; i++) {
      if (cardNumber.length > 6) {
        if (i > 1 && (i < cardNumber.length - 2)) {
          newString += mask;
        } else {
          newString += cardNumber[i];
        }
      } else {
        newString += cardNumber[i];
      }
    }

    // return the masked number
    return newString;
  }

  Future<void> getFromApi() async {
    await getDisbursementCards();
  }

  Future<void> getDisbursementCards() async {
    var getDisbursementCards = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/disbursement-card"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    print(jsonDecode(getDisbursementCards.body));
    var localListStoreDisbursementCard = [];
    if (getDisbursementCards.statusCode == 200) {
      if (jsonDecode(getDisbursementCards.body)['data'] != null) {
        localListStoreDisbursementCard =
            jsonDecode(getDisbursementCards.body)['data'];
      }
    }
    listStoreDisbursementCard.clear();
    setState(() {
      isLoadingGetlistStoreDisbursementCard = false;
      listStoreDisbursementCard = localListStoreDisbursementCard;
    });
  }

  Future<void> getHistoryDisbursement() async {
    var getDisbursementCards = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/history/request-disbursement"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    print(jsonDecode(getDisbursementCards.body));
    var localListStoreHistoryDisbursement = [];
    if (getDisbursementCards.statusCode == 200) {
      if (jsonDecode(getDisbursementCards.body)['data'] != null) {
        localListStoreHistoryDisbursement =
            jsonDecode(getDisbursementCards.body)['data'];
      }
    }
    listStoreHistoryDisbursement.clear();
    setState(() {
      isLoadingGetListStoreHistoryDisbursement = false;
      listStoreHistoryDisbursement = localListStoreHistoryDisbursement;
    });
  }
}

class DialogAddDisbursementCard extends StatefulWidget {
  int idStore = -1;

  Function(bool) onDismiss;

  DialogAddDisbursementCard({required this.idStore, required this.onDismiss});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogAddDisbursementCardState();
  }
}

class DialogAddDisbursementCardState extends State<DialogAddDisbursementCard> {
  Map<String, dynamic>? selectedDisbursementBank;

  List<Map<String, dynamic>> listBankDisbursements = [];

  Key keyBanksDisbursement = Key('keyBanksDisbursement');

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
            child: Wrap(
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              width: 80.w,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: NeumorphicIcon(
                    Icons.arrow_drop_down_circle_sharp,
                    style: NeumorphicStyle(
                      depth: .2.h,
                      color: Colors.white,
                    ),
                    size: 10.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 80.w,
              height: 1.h,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                  color: Colors.transparent,
                  depth: 1.5,
                  intensity: 1,
                  surfaceIntensity: 1),
              child: Container(
                color: Colors.blue.withOpacity(.5),
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropDownButtonCustom(
                      title: "Pilih Bank:",
                      items: listBankDisbursements
                          .map((Map<String, dynamic> item) =>
                              DropdownMenuItem<Map<String, dynamic>>(
                                  value: item,
                                  child: Text(item['name'],
                                      overflow: TextOverflow.ellipsis)))
                          .toList(),
                      onChanged: (Map<String, dynamic>? newValue) {
                        setState(() {
                          selectedDisbursementBank = newValue!;
                        });
                      },
                      value: selectedDisbursementBank,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    selectedDisbursementBank != null
                        ? Column(
                            children: [
                              WidgetTextField(
                                  controller: accountNumberController,
                                  icon: Icons.credit_card,
                                  title:
                                      '${isEwallet(selectedDisbursementBank!['code']) ? "No Handphone" : "No Rekening"} :',
                                  isError: false,
                                  messageError: "",
                                  onChanged: (value) {
                                    setState(() {
                                      accountNumberController;
                                    });
                                  },
                                  obSecure: false),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  controller: accountHolderNameController,
                                  icon: Icons.person,
                                  title: 'A/N :',
                                  isError: false,
                                  onChanged: (value) {
                                    setState(() {
                                      accountHolderNameController;
                                    });
                                  },
                                  messageError: "",
                                  obSecure: false),
                              accountHolderNameController.text.isNotEmpty &&
                                      accountNumberController.text.isNotEmpty
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            NeumorphicButton(
                                              onPressed: () {
                                                var payload = {
                                                  "bankCode":
                                                      selectedDisbursementBank![
                                                          'code'],
                                                  "accountNumber":
                                                      accountNumberController
                                                          .text,
                                                  "accountHolderName":
                                                      accountHolderNameController
                                                          .text
                                                };
                                                createDisbursementCard(
                                                    payload: payload);
                                              },
                                              style: NeumorphicStyle(
                                                  color: Colors.white,
                                                  depth: 1.2,
                                                  intensity: 1,
                                                  surfaceIntensity: 1),
                                              child: Text('Simpan'),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : Container()
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  bool isEwallet(String codeBank) {
    if (codeBank == "GOPAY" || codeBank == "OVO" || codeBank == "DANA") {
      return true;
    } else {
      return false;
    }
  }

  bool isBank(String codeBank) {
    if (codeBank == "MANDIRI" || codeBank == "BCA" || codeBank == "BRI") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getDataFromApi() async {
    var getDisbursementCards = await http.get(
        Uri.parse("${DioClient.ipServer}/payment/disbursement/bank/list"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    // print(dataListDisbursementBank);
    List<Map<String, dynamic>> localListBankDisbursement = [];
    if (jsonDecode(getDisbursementCards.body)['data'] != null) {
      var dataListDisbursementBank =
          jsonDecode(getDisbursementCards.body)['data'];

      (dataListDisbursementBank as List).asMap().forEach((key, value) {
        if (value['canDisburse']) {
          if (isEwallet(value['code']) || isBank(value['code'])) {
            localListBankDisbursement.add(value);
          }
        }
      });
    }
    setState(() {
      listBankDisbursements = localListBankDisbursement;
    });
  }

  Future<void> createDisbursementCard({required Object payload}) async {
    var createDisbursementCard = await http.post(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/${widget.idStore}/create/disbursement-card'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        },
        body: jsonEncode(payload));
    print(createDisbursementCard.body);
    if (createDisbursementCard.statusCode == 200) {
      if (jsonDecode(createDisbursementCard.body)['data'] != null) {
        var data = jsonDecode(createDisbursementCard.body)['data'];
        if (data['message'] != null) {
          if (data['message'].toString() == "create success") {
            widget.onDismiss(true);
            Navigator.pop(context);
          }
        }
      }
    }
  }
}

class DialogRequestDisbursement extends StatefulWidget {
  int idStore = -1;

  Function(bool) onDismiss;

  int idDisbursementCard;
  DialogRequestDisbursement(
      {required this.idStore,
      required this.onDismiss,
      required this.idDisbursementCard});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogRequestDisbursementState();
  }
}

class DialogRequestDisbursementState extends State<DialogRequestDisbursement> {
  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
            child: Wrap(
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              width: 80.w,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: NeumorphicIcon(
                    Icons.arrow_drop_down_circle_sharp,
                    style: NeumorphicStyle(
                      depth: .2.h,
                      color: Colors.white,
                    ),
                    size: 10.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 80.w,
              height: 1.h,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                  color: Colors.transparent,
                  depth: 1.5,
                  intensity: 1,
                  surfaceIntensity: 1),
              child: Container(
                color: Colors.blue.withOpacity(.5),
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetTextField(
                        controller: amountController,
                        icon: Icons.money,
                        title: 'Jumlah Penarikan',
                        isError: false,
                        messageError: "",
                        onChanged: (value) {
                          setState(() {
                            amountController;
                          });
                        },
                        obSecure: false,
                        keyboardtype:
                            TextInputType.numberWithOptions(decimal: false),
                        typeCurrency: true),
                    amountController.text.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  NeumorphicButton(
                                    onPressed: () {
                                      var payload = {
                                        "amount": amountController.text
                                            .toLowerCase()
                                            .replaceAll('rp', '')
                                            .replaceAll('.', ''),
                                      };
                                      reqDisbursement(payload: payload);
                                    },
                                    style: NeumorphicStyle(
                                        color: Colors.white,
                                        depth: 1.2,
                                        intensity: 1,
                                        surfaceIntensity: 1),
                                    child: Text('Simpan'),
                                  )
                                ],
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  bool isEwallet(String codeBank) {
    if (codeBank == "GOPAY" || codeBank == "OVO" || codeBank == "DANA") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> reqDisbursement({required Object payload}) async {
    var createDisbursementCard = await http.post(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/${widget.idStore}/request-disbursement/${widget.idDisbursementCard}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        },
        body: jsonEncode(payload));
    print(createDisbursementCard.body);
    if (createDisbursementCard.statusCode == 200) {
      if (jsonDecode(createDisbursementCard.body)['data'] != null) {
        var data = jsonDecode(createDisbursementCard.body)['data'];
        if (data['message'] != null) {
          if (data['message'].toString() == "request terkirim") {
            Toaster(context).showSuccessToast(data['message'].toString(),
                gravity: ToastGravity.CENTER);
            widget.onDismiss(true);
            Navigator.pop(context);
          } else {
            Toaster(context).showErrorToast(data['message'].toString(),
                gravity: ToastGravity.CENTER);
          }
        }
      }
    }
  }
}
