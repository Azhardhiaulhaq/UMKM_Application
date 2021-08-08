/// Time series chart with line annotation example
///
/// The example future range annotation extends beyond the range of the series
/// data, demonstrating the effect of the [Charts.RangeAnnotation.extendAxis]
/// flag. This can be set to false to disable range extension.
///
/// Additional annotations may be added simply by adding additional
/// [Charts.RangeAnnotationSegment] items to the list.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/data/repositories/pref_repositories.dart';

// ignore: must_be_immutable
class Statistic extends StatefulWidget {
  String uid;
  Statistic({Key? key, required this.uid}) : super(key: key);

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    final data2 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 60),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 20),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 50),
    ];

    final data3 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 70),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 14),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 25),
    ];

    final data4 = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 20),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 40),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 10),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 60),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'UMKM',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
        seriesColor: charts.Color.fromHex(code: '#1D6DAC'),
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Bukalapak',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data2,
          seriesColor: charts.Color.fromHex(code: '#E31E52')),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Tokopedia',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data3,
          seriesColor: charts.Color.fromHex(code: '#03AC0E')),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Shopee',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data4,
          seriesColor: charts.Color.fromHex(code: '#952E1C')),
    ];
  }

  @override
  _StatisticPageState createState() =>
      _StatisticPageState(_createSampleData(), uid, animate: true);
}

class _StatisticPageState extends State<Statistic> {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  String uid;
    late String _userID;
  CollectionReference statistics =
      FirebaseFirestore.instance.collection('statistics');
  List<charts.Series<TimeSeriesSales, DateTime>> lineChartList = [];

  _StatisticPageState(this.seriesList, this.uid, {this.animate});

  _createSeriesList(QuerySnapshot data) {
    List<TimeSeriesSales> store = [];
    List<TimeSeriesSales> tokopedia = [];
    List<TimeSeriesSales> shopee = [];
    List<TimeSeriesSales> bukalapak = [];
    print('masuk series');
    print(data.size);
    data.docs.forEach((e) {
      print(e.get('date').toDate().toString());
      store.add(new TimeSeriesSales(
          e.get('date').toDate(),
          e.get('store')));
      tokopedia.add(new TimeSeriesSales(
          e.get('date').toDate(),
          e.get('tokopedia')));
      bukalapak.add(new TimeSeriesSales(
          e.get('date').toDate(),
          e.get('bukalapak')));
      shopee.add(new TimeSeriesSales(
          e.get('date').toDate(),
          e.get('shopee')));
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'UMKM',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: store,
        seriesColor: charts.Color.fromHex(code: '#1D6DAC'),
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Bukalapak',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: bukalapak,
          seriesColor: charts.Color.fromHex(code: '#E31E52')),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Tokopedia',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: tokopedia,
          seriesColor: charts.Color.fromHex(code: '#03AC0E')),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Shopee',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: shopee,
          seriesColor: charts.Color.fromHex(code: '#952E1C')),
    ];
  }

  Widget _lineChart(List<charts.Series<TimeSeriesSales, DateTime>> list) {
    return Container(
      height: 300,
      child: new charts.TimeSeriesChart(list,
          animate: animate,
          defaultInteractions: true,
          behaviors: [
            new charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,
                showMeasures: true,
                measureFormatter: (value) {
                  return value == null ? '' : '${value.toInt()}';
                }),
            new charts.DomainHighlighter()
          ]),
    );
  }

  Future<void> initPreference() async {
    _userID = await PrefRepository.getUserID()??'';
  }

  @override
  void initState() {
    super.initState();
    print(this.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: statistics.doc(this.uid).collection('dates').orderBy("date",descending: true).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: ConstColor.darkDatalab,));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        } else {
          var list = _createSeriesList(snapshot.data!);
          return Scaffold(
              body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Color(0xfffbfbfb),
                            Color(0xfff7f7f7),
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Grafik Pengunjung UMKM',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _lineChart(list),
                          SizedBox(height: 100)
                        ],
                      )))
            ]),
          ));
        }
      },
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
