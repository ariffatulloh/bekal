import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class DataTransaksi_xlsFormat {
  DataTransaksi_xlsFormat();
  DataTransaksiDetailProduct_xlsFormat detailProduct_xlsFormat =
      DataTransaksiDetailProduct_xlsFormat();
  DataTransaksiBuyerInformation_xlsFormat buyerInformation_xlsFormat =
      DataTransaksiBuyerInformation_xlsFormat();
}

class DataTransaksiDetailProduct_xlsFormat {
  String _dateOrder = "";
  String _statusTransaksi = "";
  String _nameProduct = "";
  String _quantity = "";
  String _pricePerQty = "";
  String _priceAllQty = "";

  String get statusTransaksi => _statusTransaksi;

  set statusTransaksi(String value) {
    _statusTransaksi = value;
  }

  String get dateOrder => _dateOrder;

  set dateOrder(String value) {
    _dateOrder = value;
  }

  String get nameProduct => _nameProduct;

  set nameProduct(String value) {
    _nameProduct = value;
  }

  String get quantity => _quantity;

  set quantity(String value) {
    _quantity = value;
  }

  String get pricePerQty => _pricePerQty;

  set pricePerQty(String value) {
    _pricePerQty = value;
  }

  String get priceAllQty => _priceAllQty;

  set priceAllQty(String value) {
    _priceAllQty = value;
  }
}

class DataTransaksiBuyerInformation_xlsFormat {
  String _buyerName = "";
  String _buyerPhone = "";
  String _buyerAddress = "";
  String _kurirType = "";

  String get buyerName => _buyerName;

  set buyerName(String value) {
    _buyerName = value;
  }

  String get buyerPhone => _buyerPhone;

  set buyerPhone(String value) {
    _buyerPhone = value;
  }

  String get buyerAddress => _buyerAddress;

  set buyerAddress(String value) {
    _buyerAddress = value;
  }

  String get kurirType => _kurirType;

  set kurirType(String value) {
    _kurirType = value;
  }
}

class xlsx {
  xlsx();
  List<int> createExcelFile(
      {required List<DataTransaksi_xlsFormat> dataListTransaksi}) {
    Workbook workbook = Workbook(0);
    final Worksheet sheet1 = workbook.worksheets.addWithName('Data Transaksi');
    sheet1.showGridlines = false;

    // sheet1.enableSheetCalculations();

    //Adding cell style.
    final Style style1 = workbook.styles.add('Style1');
    style1.backColor = '#D9E1F2';
    style1.hAlign = HAlignType.left;
    style1.vAlign = VAlignType.center;
    style1.bold = true;

    final Style style2 = workbook.styles.add('Style2');
    style2.backColor = '#8EA9DB';
    style2.vAlign = VAlignType.center;
    style2.numberFormat = r'[Red]($#,###)';
    style2.bold = true;

    sheet1.getRangeByName('A1:J2').cellStyle = style1;
    sheet1.getRangeByName('A1:J2').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A1:J2').cellStyle.hAlign = HAlignType.center;
    sheet1.getRangeByName('A1:J2').cellStyle.vAlign = VAlignType.center;
    sheet1.getRangeByName('A1:J2').cellStyle.bold = true;
    // sheet1.getRangeByName('A2:D1').cellStyle = style1;
    // sheet1.getRangeByName('A2:D1').cellStyle.backColor = '#D9E1F2';
    // sheet1.getRangeByName('A2:D1').cellStyle.hAlign = HAlignType.center;
    // sheet1.getRangeByName('A2:D1').cellStyle.vAlign = VAlignType.center;
    // sheet1.getRangeByName('A2:D1').cellStyle.bold = true;

    // sheet1.getRangeByName('A2:A17').cellStyle.vAlign = VAlignType.center;

    //
    // sheet1.getRangeByName('D18').cellStyle = style2;
    // sheet1.getRangeByName('D18').cellStyle.vAlign = VAlignType.center;
    // sheet1.getRangeByName('A18:C18').cellStyle.backColor = '#8EA9DB';
    // sheet1.getRangeByName('A18:C18').cellStyle.vAlign = VAlignType.center;
    // sheet1.getRangeByName('A18:C18').cellStyle.bold = true;
    // sheet1.getRangeByName('A18:C18').numberFormat = r'$#,###';

    sheet1.getRangeByName('A1:J2').cellStyle.borders.all.lineStyle =
        LineStyle.thin;
    sheet1.getRangeByName('A1:J2').cellStyle.borders.all.color = '#000000';
    sheet1.getRangeByName('A1:D1').merge();
    sheet1.getRangeByName('E1:J1').merge();
    sheet1.getRangeByName('A1:D1').text = "DETAIL PRODUK";
    sheet1.getRangeByName('E1:J1').text = "INFORMASI PEMBELI";
    sheet1.getRangeByIndex(2, 1).text = 'Nama Produk';
    sheet1.getRangeByIndex(2, 2).text = 'QTY';
    sheet1.getRangeByIndex(2, 3).text = 'Harga Satuan';
    sheet1.getRangeByIndex(2, 4).text = 'Total Harga';
    sheet1.getRangeByIndex(2, 5).text = 'Nama Pembeli';
    sheet1.getRangeByIndex(2, 6).text = 'Tlp. Pembeli';
    sheet1.getRangeByIndex(2, 7).text = 'Alamat Pembeli';
    sheet1.getRangeByIndex(2, 8).text = 'Tipe Pengiriman';
    sheet1.getRangeByIndex(2, 9).text = 'Tgl. Transaksi';
    sheet1.getRangeByIndex(2, 10).text = 'Status Transaksi';
    var col1 = sheet1.getRangeByIndex(2, 1).text!.length;
    var col2 = sheet1.getRangeByIndex(2, 2).text!.length;
    var col3 = sheet1.getRangeByIndex(2, 3).text!.length;
    var col4 = sheet1.getRangeByIndex(2, 4).text!.length;
    var col5 = sheet1.getRangeByIndex(2, 5).text!.length;
    var col6 = sheet1.getRangeByIndex(2, 6).text!.length;
    var col7 = sheet1.getRangeByIndex(2, 7).text!.length;
    var col8 = sheet1.getRangeByIndex(2, 8).text!.length;
    var col9 = sheet1.getRangeByIndex(2, 9).text!.length;
    var col10 = sheet1.getRangeByIndex(2, 10).text!.length;

    dataListTransaksi.asMap().forEach((index, element) {
      col1 = element.detailProduct_xlsFormat.nameProduct.length <= col1
          ? col1
          : element.detailProduct_xlsFormat.nameProduct.length;
      col2 = element.detailProduct_xlsFormat.quantity.length <= col2
          ? col2
          : element.detailProduct_xlsFormat.quantity.length;
      col3 = element.detailProduct_xlsFormat.pricePerQty.length <= col3
          ? col3
          : element.detailProduct_xlsFormat.pricePerQty.length;
      col4 = element.detailProduct_xlsFormat.priceAllQty.length <= col4
          ? col4
          : element.detailProduct_xlsFormat.priceAllQty.length;

      col5 = element.buyerInformation_xlsFormat.buyerName.length <= col5
          ? col5
          : element.buyerInformation_xlsFormat.buyerName.length;
      element.buyerInformation_xlsFormat.buyerPhone.length <= col6
          ? col6
          : element.buyerInformation_xlsFormat.buyerPhone.length;
      element.buyerInformation_xlsFormat.buyerAddress.length <= col7
          ? col7
          : element.buyerInformation_xlsFormat.buyerAddress.length;
      element.buyerInformation_xlsFormat.kurirType.length <= col8
          ? col8
          : element.buyerInformation_xlsFormat.kurirType.length;
      element.detailProduct_xlsFormat.dateOrder.length <= col9
          ? col9
          : element.detailProduct_xlsFormat.dateOrder.length;
      element.detailProduct_xlsFormat.statusTransaksi.length <= col10
          ? col10
          : element.detailProduct_xlsFormat.statusTransaksi.length;

      var countrow = 3 + index;
      sheet1.getRangeByIndex(countrow, 1).text =
          element.detailProduct_xlsFormat.nameProduct;
      sheet1.getRangeByIndex(countrow, 2).text =
          element.detailProduct_xlsFormat.quantity;
      sheet1.getRangeByIndex(countrow, 3).text =
          element.detailProduct_xlsFormat.pricePerQty;
      sheet1.getRangeByIndex(countrow, 4).text =
          element.detailProduct_xlsFormat.priceAllQty;
      sheet1.getRangeByIndex(countrow, 5).text =
          element.buyerInformation_xlsFormat.buyerName;
      sheet1.getRangeByIndex(countrow, 6).text =
          element.buyerInformation_xlsFormat.buyerPhone;
      sheet1.getRangeByIndex(countrow, 7).text =
          element.buyerInformation_xlsFormat.buyerAddress;
      sheet1.getRangeByIndex(countrow, 8).text =
          element.buyerInformation_xlsFormat.kurirType;
      sheet1.getRangeByIndex(countrow, 9).text =
          element.detailProduct_xlsFormat.dateOrder;
      sheet1.getRangeByIndex(countrow, 10).text =
          element.detailProduct_xlsFormat.statusTransaksi;

      sheet1.getRangeByIndex(countrow, 1).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 2).cellStyle.hAlign = HAlignType.center;
      sheet1.getRangeByIndex(countrow, 3).cellStyle.hAlign = HAlignType.center;
      sheet1.getRangeByIndex(countrow, 4).cellStyle.hAlign = HAlignType.center;
      sheet1.getRangeByIndex(countrow, 5).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 6).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 7).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 8).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 9).cellStyle.hAlign = HAlignType.left;
      sheet1.getRangeByIndex(countrow, 10).cellStyle.hAlign = HAlignType.left;
      sheet1
          .getRangeByName('A$countrow:J$countrow')
          .cellStyle
          .borders
          .all
          .lineStyle = LineStyle.thin;
      sheet1
          .getRangeByName('A$countrow:J$countrow')
          .cellStyle
          .borders
          .all
          .color = '#BFBFBF';
    });
    sheet1.getRangeByIndex(1, 1).columnWidth =
        double.parse((col1 / 2).toString()).w;
    sheet1.getRangeByIndex(1, 2).columnWidth =
        double.parse((col2 / 2).toString()).w;
    sheet1.getRangeByIndex(1, 3).columnWidth =
        double.parse((col3 / 2).toString()).w;
    sheet1.getRangeByIndex(1, 4).columnWidth =
        double.parse((col4 / 2).toString()).w;
    sheet1.getRangeByIndex(1, 5).columnWidth =
        double.parse((col5 / 1.5).toString()).w;
    sheet1.getRangeByIndex(1, 6).columnWidth =
        double.parse((col6 / 1.5).toString()).w;
    sheet1.getRangeByIndex(1, 7).columnWidth =
        double.parse((col7 * 2).toString()).w;
    sheet1.getRangeByIndex(1, 8).columnWidth =
        double.parse((col8 / 1.5).toString()).w;
    sheet1.getRangeByIndex(1, 9).columnWidth =
        double.parse((col8 / 1.5).toString()).w;
    sheet1.getRangeByIndex(1, 10).columnWidth =
        double.parse((col8 / 1.5).toString()).w;

    // sheet1.getRangeByIndex(2, 1).text = 'Venue';
    // sheet1.getRangeByIndex(12, 1).text = 'Seating & Decor';
    // sheet1.getRangeByIndex(13, 1).text = 'Technical team';
    // sheet1.getRangeByIndex(14, 1).text = 'Performers';
    // sheet1.getRangeByIndex(15, 1).text = "Performer's transport";
    // sheet1.getRangeByIndex(16, 1).text = "Performer's stay";
    // sheet1.getRangeByIndex(17, 1).text = 'Marketing';
    // sheet1.getRangeByIndex(18, 1).text = 'Total';
    //
    // sheet1.getRangeByName('B2:D17').numberFormat = r'$#,###';
    // sheet1.getRangeByName('D2').numberFormat = r'[Red]($#,###)';
    // sheet1.getRangeByName('D12').numberFormat = r'[Red]($#,###)';
    // sheet1.getRangeByName('D14').numberFormat = r'[Red]($#,###)';
    //
    // sheet1.getRangeByName('B2').number = 16250;
    // sheet1.getRangeByName('B12').number = 1600;
    // sheet1.getRangeByName('B13').number = 1000;
    // sheet1.getRangeByName('B14').number = 12400;
    // sheet1.getRangeByName('B15').number = 3000;
    // sheet1.getRangeByName('B16').number = 4500;
    // sheet1.getRangeByName('B17').number = 3000;
    // sheet1.getRangeByName('B18').formula = '=SUM(B2:B17)';
    //
    // sheet1.getRangeByName('C2').number = 17500;
    // sheet1.getRangeByName('C12').number = 1828;
    // sheet1.getRangeByName('C13').number = 800;
    // sheet1.getRangeByName('C14').number = 14000;
    // sheet1.getRangeByName('C15').number = 2600;
    // sheet1.getRangeByName('C16').number = 4464;
    // sheet1.getRangeByName('C17').number = 2700;
    // sheet1.getRangeByName('C18').formula = '=SUM(C11:C17)';

    // sheet1.getRangeByName('D11').formula = '=IF(C11>B11,C11-B11,B11-C11)';
    // sheet1.getRangeByName('D12').formula = '=IF(C12>B12,C12-B12,B12-C12)';
    // sheet1.getRangeByName('D13').formula = '=IF(C13>B13,C13-B13,B13-C13)';
    // sheet1.getRangeByName('D14').formula = '=IF(C14>B14,C14-B14,B14-C14)';
    // sheet1.getRangeByName('D15').formula = '=IF(C15>B15,C15-B15,B15-C15)';
    // sheet1.getRangeByName('D16').formula = '=IF(C16>B16,C16-B16,B16-C16)';
    // sheet1.getRangeByName('D17').formula = '=IF(C17>B17,C17-B17,B17-C17)';
    // sheet1.getRangeByName('D18').formula = '=IF(C18>B18,C18-B18,B18-C18)';
    return workbook.saveAsStream();
    // String path = (await getApplicationSupportDirectory()).path;
    // String fileName = '$path/out.xlsx';
    // File file = File(fileName);
    // await file.writeAsBytes(ex.saveAsStream());
  }
}
