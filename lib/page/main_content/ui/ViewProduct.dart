import 'dart:math' as math;

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/auth/ui/login/login.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/main_content/ui/chat/ChatDetailScreen.dart';
import 'package:bekal/page/main_content/ui/chat/ChatScreen.dart';
import 'package:bekal/page/main_content/ui/profile/store/DashboardStore.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quiver/strings.dart';
import 'package:sizer/sizer.dart';

class ViewProduct extends StatefulWidget {
  int idProduct = -1;
  PayloadResponseStoreProduct? dataDetailProduct;
  int idStore;
  ViewProduct(
      {required this.idProduct, this.dataDetailProduct, required this.idStore});
  @override
  _ViewProduct createState() => _ViewProduct();
}

class _ViewProduct extends State<ViewProduct> {
  int galleryImageSelected = 0;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  bool isSaving = false;
  var auth = "";
  DioClient _dio = new DioClient();
  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ProfileRepository()
            .getDetailProduct(auth, widget.idProduct, widget.idStore)
            .asStream(),
        builder: (context, snapshot) {
          PayloadResponseStoreProduct data;
          if (snapshot.connectionState == ConnectionState.done) {
            PayloadResponseApi dataApiDetailProduct =
                snapshot.data as PayloadResponseApi;
            if (dataApiDetailProduct.errorMessage.isEmpty) {
              data = dataApiDetailProduct.data;

              return SafeArea(
                  child: Column(children: [
                Container(
                  child: NeumorphicButton(
                    padding: EdgeInsets.all(0.w.h),
                    style: NeumorphicStyle(
                      // shape: NeumorphicShape.convex,
                      color: Colors.transparent,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: .0.w.h,
                      // surfaceIntensity: .5,
                      // intensity: 1
                    ),
                    child: Wrap(children: [
                      NeumorphicIcon(
                        Icons.cancel_rounded,
                        style: NeumorphicStyle(
                          // color: Colors.white70,
                          depth: .1.h,
                          surfaceIntensity: .3,
                          intensity: 1,
                        ),
                        size: 10.w,
                      ),
                    ]),
                    onPressed: () {
                      // if (whenClosed != null) {
                      //   whenClosed(true);
                      Future.delayed(Duration(milliseconds: 1), () {
                        Navigator.of(context).pop();
                      });
                      // }
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.w),
                          topRight: Radius.circular(5.w))),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 80.w - 20.w,
                        child: Row(
                          children: [
                            Expanded(
                              child: PhotoView(
                                imageProvider: NetworkImage(
                                  "${data.galleryImage.isNotEmpty ? data.galleryImage[galleryImageSelected].uriImage : ""}?dummy=${math.Random().nextInt(999)}",
                                ),
                              ),
                            ),
                            Container(
                              width: 20.w,
                              child: MasonryGridView.count(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 1.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  // crossAxisSpacing: 1.w,
                                  itemCount: data.galleryImage.length,
                                  itemBuilder: (context, index) {
                                    print('data image ${data.galleryImage}');
                                    return NeumorphicButton(
                                      padding: EdgeInsets.all(0.1.w.h),
                                      style: NeumorphicStyle(
                                        // shape: NeumorphicShape.convex,
                                        color: Colors.transparent,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.circular(.2.w.h))),
                                        depth: .04.w.h,
                                      ),
                                      child: Container(
                                        height: 15.w,
                                        // height: 3.h,
                                        child: Image.network(
                                          "${data.galleryImage[index].uriImage}?dummy=${math.Random().nextInt(999)}",
                                          fit: BoxFit.contain, // use this
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          galleryImageSelected = index;
                                        });
                                      },
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Neumorphic(
                        padding: EdgeInsets.all(0.3.w.h),
                        style: NeumorphicStyle(
                          // shape: NeumorphicShape.convex,
                          color: Colors.transparent,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.all(Radius.circular(.2.w.h))),
                          depth: .04.w.h,
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 10.w,
                                    child: Image.network(
                                      "${data.uriThumbnail}?dummy=${math.Random().nextInt(999)}",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data.nameProduct}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    color: HexColor("9E9E9E90"),
                                    height: .1.h,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${currencyFormatter.format(double.parse(data.priceProduct))}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          NeumorphicButton(
                                            padding: EdgeInsets.only(
                                                top: 5.sp,
                                                bottom: 5.sp,
                                                left: 5.sp,
                                                right: 5.sp),
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.convex,
                                                color: isSaving
                                                    ? Colors.grey
                                                        .withOpacity(.5)
                                                    : Color.fromRGBO(
                                                        243, 146, 0, 1),
                                                boxShape: NeumorphicBoxShape
                                                    .stadium(),
                                                depth: .2.h,
                                                intensity: .8),
                                            child: NeumorphicIcon(
                                                Icons.chat_bubble),
                                            onPressed: () async {
                                              var token = await SecureStorage()
                                                  .getToken();
                                              ProfileRepository()
                                                  .myProfileDashboard(token!)
                                                  .then((value) async {
                                                var getDataProfile =
                                                    value.data!;
                                                showMaterialModalBottomSheet(
                                                    duration: Duration(
                                                        milliseconds: 1400),
                                                    animationCurve:
                                                        Curves.easeInOut,
                                                    enableDrag: true,
                                                    backgroundColor:
                                                        Colors.white,
                                                    context: context,
                                                    builder: (context) {
                                                      return ChatDetailScreen(
                                                        onClosed: () {},
                                                        accountSelected: PopUpList(
                                                            image: getDataProfile
                                                                    .image ??
                                                                "",
                                                            id: getDataProfile
                                                                    .idUser ??
                                                                -1,
                                                            userOrStore: "user",
                                                            nameDisplay:
                                                                getDataProfile
                                                                        .nameUser ??
                                                                    ""),
                                                        withUser: ChatWith(
                                                            fullName: data.store
                                                                .storeName,
                                                            id: data
                                                                .store.storeID,
                                                            userOrStore:
                                                                'store'),
                                                      );
                                                    });
                                              });
                                            },
                                          ),
                                          Visibility(
                                              visible: int.parse(
                                                      data.stockProduct) >=
                                                  1,
                                              child: NeumorphicButton(
                                                padding: EdgeInsets.only(
                                                    top: 6.sp,
                                                    bottom: 6.sp,
                                                    left: 12.sp,
                                                    right: 12.sp),
                                                style: NeumorphicStyle(
                                                    shape:
                                                        NeumorphicShape.convex,
                                                    color: isSaving
                                                        ? Colors.grey
                                                            .withOpacity(.5)
                                                        : Color.fromRGBO(
                                                            243, 146, 0, 1),
                                                    boxShape: NeumorphicBoxShape
                                                        .stadium(),
                                                    depth: .2.h,
                                                    intensity: .8),
                                                child: Wrap(
                                                  children: [
                                                    if (isSaving)
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 3.w),
                                                        child: SizedBox(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                Colors.orange,
                                                            strokeWidth: 2,
                                                          ),
                                                          height: 2.h,
                                                          width: 2.h,
                                                        ),
                                                      ),
                                                    Text(
                                                      isSaving
                                                          ? "Processing"
                                                          : "Masukkan Keranjang",
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  if (isEmpty(auth)) {
                                                    Navigator.of(context).pop();

                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 1),
                                                    );

                                                    context
                                                        .read<
                                                            ControllerPageCubit>()
                                                        .goto("LOGIN");

                                                    return;
                                                  }

                                                  setState(() {
                                                    isSaving = true;
                                                  });

                                                  var respDataprofile =
                                                      await ProfileRepository()
                                                          .getProfile("");
                                                  if (respDataprofile != null) {
                                                    PayloadResponseProfile
                                                        dataProfile =
                                                        respDataprofile.data!;
                                                    if (data != null) {
                                                      Address? dataAddress =
                                                          dataProfile
                                                              .profile.address;
                                                      if (dataAddress != null) {
                                                        print(
                                                            'datapribadi load');
                                                        if ((dataAddress
                                                                    .city_name
                                                                    ?.isEmpty ??
                                                                false) ||
                                                            (dataAddress
                                                                    .address?.isEmpty ??
                                                                false) ||
                                                            (dataAddress
                                                                    .province_name
                                                                    ?.isEmpty ??
                                                                false) ||
                                                            (dataAddress
                                                                    .suburb_name
                                                                    ?.isEmpty ??
                                                                false) ||
                                                            (dataAddress
                                                                    .area_name
                                                                    ?.isEmpty ??
                                                                false ||
                                                                    !(dataAddress
                                                                            .postcode
                                                                            ?.isEmpty ??
                                                                        false))) {
                                                          Toaster(context)
                                                              .showErrorToast(
                                                                  "silahkan lengkapi data pribadi anda pada menu profile",
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER);
                                                        } else {
                                                          try {
                                                            var payload = {
                                                              "store_product_id":
                                                                  data.storeProdId,
                                                              "product_qty": 1
                                                            };

                                                            DioResponse res =
                                                                await _dio.postAsync(
                                                                    "/order/cart/add",
                                                                    payload);

                                                            if (res.results[
                                                                    "code"] ==
                                                                200) {
                                                              Toaster(context).showSuccessToast(
                                                                  "Produk berhasil ditambahkan ke keranjang",
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          } catch (e) {
                                                            Toaster(context).showErrorToast(
                                                                "Terjadi kesalahan saat menyimpan data",
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER);
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }

                                                  setState(() {
                                                    isSaving = false;
                                                  });
                                                },
                                              ))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          // height: 3.h,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Neumorphic(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.5.w),
                        style: NeumorphicStyle(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Neumorphic(
                                    style: NeumorphicStyle(
                                        color: Colors.white,
                                        border: NeumorphicBorder(
                                            width: 1.5, color: Colors.white70),
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: .2.h,
                                        intensity: 1,
                                        surfaceIntensity: .5),
                                    child: Container(
                                      width: 10.w,
                                      height: 10.w,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: data.store.uriStoreImage,
                                        errorWidget: (context, url, error) {
                                          return Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          );
                                        },
                                        progressIndicatorBuilder:
                                            (context, url, error) {
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    )),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "${data.store.storeName}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey),
                                  ),
                                ),
                                NeumorphicButton(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 1.w, vertical: 1.h),
                                  pressed: true,
                                  onPressed: () {
                                    showMaterialModalBottomSheet(
                                        duration: Duration(milliseconds: 1400),
                                        animationCurve: Curves.easeInOut,
                                        enableDrag: true,
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return DashboardStore(
                                            storeId: data.store.storeID,
                                          );
                                        });
                                  },
                                  style: NeumorphicStyle(
                                      color: Colors.orangeAccent,
                                      depth: .2.h,
                                      intensity: .8,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(20)))),
                                  child: Container(
                                    child: Text(
                                      "Etalase Toko",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Wrap(
                              children: [],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deskripsi:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${data.deskripsiProduct}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ))
              ]));
            }
          }
          return CircularProgressIndicator(
            color: Colors.blue,
          );
        });
  }

  Future<void> getToken() async {
    auth = await SecureStorage().getToken() ?? "";
    setState(() {});
  }
}

notifError(BuildContext context, String description) {
  return Positioned(
    right: 0,
    child: Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 30, left: 0),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(.8),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // To make the card compact
                  children: <Widget>[
                    Neumorphic(
                      padding: const EdgeInsets.all(5),
                      style: const NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(), depth: 0),
                      child: const Icon(
                        Icons.error,
                        color: Colors.deepOrange,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'ghotic',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
