import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/input_field.dart';
import 'package:bekal/page/common/master_dropdown.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class DialogUbahAlamat extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogUbahAlamat({Key? key, this.onDismiss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileScreenDataPribadiCubit>(
      create: (context) => ProfileScreenDataPribadiCubit(),
      child: BlocBuilder<ProfileScreenDataPribadiCubit,
              ProfileScreenDataPribadiCubitState>(
          builder: (cubitDataPribadiContext, cubitDataPribadiState) {
        if (cubitDataPribadiState is InitialDataPribadiState) {
          cubitDataPribadiContext
              .read<ProfileScreenDataPribadiCubit>()
              .LoadMyProfileDataPribadi();
        }

        return Stack(
          children: [
            cubitDataPribadiState is LoadDataPribadiStateSukses
                ? FormUbahAlamat(
                    cubitContext: cubitDataPribadiContext,
                    data: cubitDataPribadiState.data!,
                    onDismiss: onDismiss)
                : LoadingContent(
                    child: FormUbahAlamat(
                        cubitContext: cubitDataPribadiContext,
                        data: null,
                        onDismiss: onDismiss)),
          ],
        );
      }),
    );
  }
}

class FormUbahAlamat extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;
  final ValueChanged<bool>? onDismiss;

  FormUbahAlamat({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormUbahAlamat createState() => _FormUbahAlamat(data: data);
}

class _FormUbahAlamat extends State<FormUbahAlamat> {
  PayloadResponseProfile? data;

  DioClient _dio = new DioClient();

  bool showButtonSave = true;
  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  _FormUbahAlamat({this.data});

  String provinsi = "";
  String kabupaten = "";
  String kecamatan = "";
  String desa = "";
  String kodepos = "";
  String alamat = "";

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    if (data != null) {
      if (data!.profile.address != null) {
        provinsi = "${data!.profile.address!.province_id}";
        kabupaten = "${data!.profile.address!.city_id}";
        kecamatan = "${data!.profile.address!.suburb_id}";
        desa = "${data!.profile.address!.area_id}";
        kodepos = data?.profile.address?.postcode ?? "";
        alamat = data?.profile.address?.address ?? "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    cubitContext = widget.cubitContext;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputLabel("Alamat Pengiriman", required: true),
                TextInput(
                    maxLines: 2,
                    value: alamat,
                    keyboardType: TextInputType.text,
                    borderRadius: 20.0,
                    onChanged: (v) {
                      setState(() {
                        alamat = v ?? "";
                      });
                    }),
                SizedBox(
                  height: 1.h,
                ),
                MasterDropdown(
                  url: "/location/provinces",
                  label: "Provinsi",
                  borderRadius: 20.0,
                  value: provinsi == "0" ? "" : provinsi,
                  onItemSelected: (value) {
                    setState(() {
                      provinsi = value;
                      kabupaten = "";
                      kecamatan = "";
                      desa = "";
                    });
                  },
                ),
                MasterDropdown(
                  key: Key("kabupaten-${provinsi}"),
                  url: "/location/cities/${provinsi}",
                  label: "Kabupaten/Kota",
                  value: kabupaten == "0" ? "" : kabupaten,
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {
                      kabupaten = value;
                      kecamatan = "";
                      desa = "";
                    });
                  },
                ),
                MasterDropdown(
                  url: "/location/suburbs/${kabupaten}",
                  label: "Kecamatan",
                  key: Key("kecamatan-${kabupaten}"),
                  value: kecamatan == "0" ? "" : kecamatan,
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {
                      kecamatan = value;
                      desa = "";
                    });
                  },
                ),
                MasterDropdown(
                  key: Key("desa-${kecamatan}"),
                  url: "/location/areas/${kecamatan}",
                  label: "Desa/Kelurahan",
                  value: desa == "0" ? "" : desa,
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {
                      desa = value;
                    });
                  },
                ),
                inputLabel("Kode Pos", required: true),
                TextInput(
                  keyboardType: TextInputType.number,
                  borderRadius: 20.0,
                  value: kodepos,
                  onChanged: (v) {
                    setState(() {
                      kodepos = v ?? "";
                    });
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: NeumorphicButton(
                    padding: EdgeInsets.only(
                        top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        color: isSaving
                            ? Colors.grey.withOpacity(.5)
                            : Colors.transparent,
                        boxShape: NeumorphicBoxShape.stadium(),
                        depth: .2.h,
                        surfaceIntensity: .3,
                        intensity: .9),
                    child: Wrap(children: [
                      if (isSaving)
                        Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: SizedBox(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                              strokeWidth: 2,
                            ),
                            height: 2.h,
                            width: 2.h,
                          ),
                        ),
                      Text(
                        isSaving ? "Menyimpan" : "Simpan",
                        style: TextStyle(fontSize: 10.sp, color: Colors.white),
                      ),
                    ]),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && !isSaving) {
                        _formKey.currentState!.save();

                        setState(() {
                          isSaving = true;
                        });
                        try {
                          var payload = {
                            "address": alamat,
                            "area_id": desa,
                            "area_name": "",
                            "city_id": kabupaten,
                            "city_name": "",
                            "country_id": 1,
                            "country_name": "Indonesia",
                            "direction": "",
                            "lat": "0.0",
                            "lng": "0.0",
                            "postcode": kodepos,
                            "province_id": provinsi,
                            "province_name": "",
                            "suburb_id": kecamatan,
                            "suburb_name": ""
                          };

                          print(jsonEncode(payload));

                          DioResponse res = await _dio.postAsync(
                              "/api/my/profile/address/add", payload);

                          if (res.results["code"] == 200) {
                            Toaster(context).showSuccessToast(
                                "Alamat berhasil disimpan",
                                gravity: ToastGravity.CENTER);
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          Toaster(context).showErrorToast(
                              "Terjadi kesalahan saat menyimpan data",
                              gravity: ToastGravity.CENTER);
                        }

                        setState(() {
                          isSaving = false;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputLabel(String text, {bool required = false}) => Padding(
        padding: EdgeInsets.only(top: 15, bottom: 8),
        child: RichText(
          text: TextSpan(
              text: text,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                if (required)
                  TextSpan(
                    text: "*",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  )
              ]),
        ),
      );
}
