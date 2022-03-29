import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/dropdownBasic.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
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
  var listStoreBankAccounts = [];
  bool isLoadingGetlistStoreBankAccounts = true;
  var listStoreHistoryDisbursement = [];
  var storeHistoryBalance = [];
  bool isLoadingGetListStoreHistoryDisbursement = true;
  bool isLoadingGetBalanceStore = true;
  String balanceStore = 'IDR 0';
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
                      child: isLoadingGetBalanceStore
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await getBalanceStore();

                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return ListView.builder(
                                          itemCount: storeHistoryBalance.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Neumorphic(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.w),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                style: NeumorphicStyle(
                                                    color: Colors.white,
                                                    depth: 2,
                                                    intensity: 1,
                                                    surfaceIntensity: 1),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.date_range),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            formatDate(
                                                                context,
                                                                storeHistoryBalance[
                                                                        index]?[
                                                                    "createdAt"],
                                                                format:
                                                                    "dd MMMM yyyy, hh:mm WIB"),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'ghotic',
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Devider(),
                                                    Text(
                                                      storeHistoryBalance[index]
                                                              ?["message"] ??
                                                          "-",
                                                      style: TextStyle(
                                                          fontFamily: 'ghotic',
                                                          fontSize: 8.sp,
                                                          color: storeHistoryBalance[
                                                                          index]
                                                                      ?[
                                                                      "amount"] >
                                                                  0
                                                              ? Colors
                                                                  .lightGreen
                                                              : Colors
                                                                  .redAccent,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    });
                              },
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        NeumorphicIcon(
                                          Icons.history_rounded,
                                          style: NeumorphicStyle(
                                              color: Colors.white,
                                              depth: 1,
                                              intensity: 1,
                                              surfaceIntensity: 1),
                                          size: 17.sp,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        NeumorphicText(
                                          '$balanceStore',
                                          style: NeumorphicStyle(
                                              color: Colors.white,
                                              depth: 1.2,
                                              intensity: 1,
                                              surfaceIntensity: 1),
                                          textStyle: NeumorphicTextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
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
                                      getBankAccounts();
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

  Container Devider() {
    return Container(
      color: Colors.black26,
      height: .1.h,
      width: 100.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
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
                                        idBankAccounts:
                                            listStoreBankAccounts[index]['id'],
                                        idStore: widget.idStore,
                                        onDismiss: (isDismiss) async {
                                          setState(() {
                                            isLoadingGetlistStoreBankAccounts =
                                                true;
                                          });
                                          await getBankAccounts();
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
                      return DialogAddBankAccounts(
                          idStore: widget.idStore,
                          onDismiss: (isDismiss) async {
                            setState(() {
                              isLoadingGetlistStoreBankAccounts = true;
                            });
                            await getBankAccounts();
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
            child: isLoadingGetlistStoreBankAccounts
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : listStoreBankAccounts.length < 1
                    ? Center(
                        child: Text('Tidak Memiliki Daftar Bank/E-wallet'),
                      )
                    : ListView.builder(
                        itemCount: listStoreBankAccounts.length,
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
                                              "${listStoreBankAccounts[index]['accountNumber']}",
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
                                          'A/N: ${listStoreBankAccounts[index]['accountHolderName']}',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              letterSpacing: 1.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Bank / E-wallet: (${listStoreBankAccounts[index]['bankCode']})',
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
                                                idBankAccounts:
                                                    listStoreBankAccounts[index]
                                                        ['id'],
                                                idStore: widget.idStore,
                                                onDismiss: (isDismiss) async {
                                                  setState(() {
                                                    isLoadingGetlistStoreBankAccounts =
                                                        true;
                                                  });
                                                  await getBankAccounts();
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

  void getFromApi() async {
    getBankAccounts();
    Future.delayed(Duration(seconds: 1));
    getBalanceStore();
  }

  Future<void> getBankAccounts() async {
    var getBankAccounts = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/bank-accounts"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    print(jsonDecode(getBankAccounts.body));
    var localListStoreBankAccounts = [];
    if (getBankAccounts.statusCode == 200) {
      if (jsonDecode(getBankAccounts.body)['data'] != null) {
        localListStoreBankAccounts = jsonDecode(getBankAccounts.body)['data'];
      }
    }
    listStoreBankAccounts.clear();
    setState(() {
      isLoadingGetlistStoreBankAccounts = false;
      listStoreBankAccounts = localListStoreBankAccounts;
    });
  }

  Future<void> getBalanceStore() async {
    setState(() {
      isLoadingGetBalanceStore = true;
    });
    var getBalanceStoreResponse = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/balance"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    if (getBalanceStoreResponse.statusCode == 200) {
      if (jsonDecode(getBalanceStoreResponse.body)['data'] != null) {
        setState(() {
          isLoadingGetBalanceStore = false;
          balanceStore = NumberFormat.simpleCurrency(
                  locale: "IDR", decimalDigits: 0)
              .format(
                  jsonDecode(getBalanceStoreResponse.body)['data']['balance']);
          storeHistoryBalance =
              jsonDecode(getBalanceStoreResponse.body)['data']['history'];
        });
      }
    }
  }

  Future<void> getHistoryDisbursement() async {
    var getBankAccounts = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/history/request-disbursement"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    print(jsonDecode(getBankAccounts.body));
    var localListStoreHistoryDisbursement = [];
    if (getBankAccounts.statusCode == 200) {
      if (jsonDecode(getBankAccounts.body)['data'] != null) {
        localListStoreHistoryDisbursement =
            jsonDecode(getBankAccounts.body)['data'];
      }
    }
    listStoreHistoryDisbursement.clear();
    setState(() {
      isLoadingGetListStoreHistoryDisbursement = false;
      listStoreHistoryDisbursement = localListStoreHistoryDisbursement;
    });
  }
}

class DialogAddBankAccounts extends StatefulWidget {
  int idStore = -1;

  Function(bool) onDismiss;

  DialogAddBankAccounts({required this.idStore, required this.onDismiss});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogAddBankAccountstate();
  }
}

class DialogAddBankAccountstate extends State<DialogAddBankAccounts> {
  Map<String, dynamic>? selectedDisbursementBank;

  List<Map<String, dynamic>> listBankDisbursements = [];

  Key keyBanksDisbursement = Key('keyBanksDisbursement');

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  bool isSavingProcess = false;
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
                              isSavingProcess
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : accountHolderNameController
                                              .text.isNotEmpty &&
                                          accountNumberController
                                              .text.isNotEmpty
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
                                                    createBankAccounts(
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
    var getBankAccounts = await http.get(
        Uri.parse("${DioClient.ipServer}/payment/disbursement/bank/list"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    // print(dataListDisbursementBank);
    List<Map<String, dynamic>> localListBankDisbursement = [];
    if (jsonDecode(getBankAccounts.body)['data'] != null) {
      var dataListDisbursementBank = jsonDecode(getBankAccounts.body)['data'];

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

  Future<void> createBankAccounts({required Object payload}) async {
    setState(() {
      isSavingProcess = true;
    });
    var createBankAccounts = await http.post(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/${widget.idStore}/create/bank-accounts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        },
        body: jsonEncode(payload));
    print(createBankAccounts.body);
    if (createBankAccounts.statusCode == 200) {
      if (jsonDecode(createBankAccounts.body)['data'] != null) {
        var data = jsonDecode(createBankAccounts.body)['data'];
        if (data['message'] != null) {
          if (data['message'].toString() == "create success") {
            widget.onDismiss(true);
            Navigator.pop(context);
          } else {
            setState(() {
              isSavingProcess = false;
            });
          }
        }
      }
    }
  }
}

class DialogRequestDisbursement extends StatefulWidget {
  int idStore = -1;

  Function(bool) onDismiss;

  int idBankAccounts;
  DialogRequestDisbursement(
      {required this.idStore,
      required this.onDismiss,
      required this.idBankAccounts});
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
    var createBankAccounts = await http.post(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/${widget.idStore}/request-disbursement/${widget.idBankAccounts}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        },
        body: jsonEncode(payload));
    print(createBankAccounts.body);
    if (createBankAccounts.statusCode == 200) {
      if (jsonDecode(createBankAccounts.body)['data'] != null) {
        var data = jsonDecode(createBankAccounts.body)['data'];
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
