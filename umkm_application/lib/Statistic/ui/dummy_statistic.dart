// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Model/store.dart';
import 'package:umkm_application/data/repositories/store_repositories.dart';
import 'package:umkm_application/data/repositories/user_repositories.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class DummyStatisticPage extends StatefulWidget {
  DummyStatisticPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DummyStatisticPageState createState() => _DummyStatisticPageState();
}

class _DummyStatisticPageState extends State<DummyStatisticPage> {
  Widget _coachingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ConstColor.darkDatalab, ConstColor.darkDatalab])),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              openLink('https://datalab-sbmitb.shinyapps.io/sm-dashboard');
              // readExcel();
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Dapatkan Statistik Produkmu',
                    style: TextStyle(
                        fontSize: 20, color: ConstColor.secondaryTextDatalab))),
          )),
    );
  }

  void openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      print('There was a problem to open the url: $url');
    }
  }

  // Dummy Function to store data
  void readExcel() async {
    ByteData data = await rootBundle.load("assets/UMKM2.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print('-----------------------START 1 USER-------------------------');
        var user = await UserRepository.signUp(
                row[1] == null ? '' : row[1]!.props.first.toString().trim(),
                row[2] == null
                    ? ''
                    : '0' + row[2]!.props.first.toString().trim(),
                row[3] == null ? '' : row[3]!.props.first.toString().trim(),
                row[0] == null ? '' : row[0]!.props.first.toString().trim())
            .then((user) async {
          if (user != null) {
            print(user.uid);
            List<String> tag = [];
            if (row[4] != null) {
              tag.add('makanan');
            }
            if (row[5] != null) {
              tag.add('pakaian');
            }
            if (row[6] != null) {
              tag.add('kesenian');
            }

            Store newStore = Store(
              id: user.uid,
              address:
                  row[8] == null ? '' : row[8]!.props.first.toString().trim(),
              bukalapakName:
                  row[15] == null ? '' : row[15]!.props.first.toString().trim(),
              city: row[9] == null ? '' : row[9]!.props.first.toString().trim(),
              description:
                  row[7] == null ? '' : row[7]!.props.first.toString().trim(),
              email:
                  row[1] == null ? '' : row[1]!.props.first.toString().trim(),
              facebookAcc:
                  row[12] == null ? '' : row[12]!.props.first.toString().trim(),
              image: '',
              instagramAcc:
                  row[11] == null ? '' : row[11]!.props.first.toString().trim(),
              phoneNumber:
                  row[2] == null ? '' : row[2]!.props.first.toString().trim(),
              province:
                  row[10] == null ? '' : row[10]!.props.first.toString().trim(),
              shopeeName:
                  row[16] == null ? '' : row[16]!.props.first.toString().trim(),
              tags: tag,
              tokopediaName:
                  row[14] == null ? '' : row[14]!.props.first.toString().trim(),
              name: row[3] == null ? '' : row[3]!.props.first.toString().trim(),
              youtubeLink:
                  row[13] == null ? '' : row[13]!.props.first.toString().trim(),
            );
            await StoreRepository.updateStore(newStore);
            print('--------------------- Done 1 User ------------------------');
          }
        }).onError((error, stackTrace) {
          print(error);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Product Analysis',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: ConstColor.darkDatalab),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Dapatkan analisa secara nyata dari sosial media untuk produk-produk yang kamu jual! Data ini bisa digunakan untuk menganalisa penjualan dan penerimaan produk dalam masyarakat!',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ConstColor.darkDatalab,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image(
                      image: AssetImage('assets/5024152.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _coachingButton(context)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
