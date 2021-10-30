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

  @override
  _StatisticPageState createState() => _StatisticPageState(uid, animate: true);
}

class _StatisticPageState extends State<Statistic> {
  final bool? animate;
  String uid;
  late String _userID;
  CollectionReference statistics =
      FirebaseFirestore.instance.collection('statistics');
  List<charts.Series<TimeSeriesSales, DateTime>> lineChartList = [];

  _StatisticPageState(this.uid, {this.animate});
  String dropdownValue = 'Hari ini';

  Widget _dropDown() {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 10,
      style: const TextStyle(color: ConstColor.textDatalab),
      underline: Container(
        height: 2,
        color: ConstColor.darkDatalab,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'Hari ini',
        "Satu Minggu Terakhir",
        "Satu Bulan Terakhir",
        "Seluruh Nilai"
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _createSeriesList(QuerySnapshot data) {
    List<TimeSeriesSales> store = [];
    List<TimeSeriesSales> tokopedia = [];
    List<TimeSeriesSales> shopee = [];
    List<TimeSeriesSales> bukalapak = [];
    data.docs.forEach((e) {
      store.add(new TimeSeriesSales(e.get('date').toDate(), e.get('store')));
      tokopedia
          .add(new TimeSeriesSales(e.get('date').toDate(), e.get('tokopedia')));
      bukalapak
          .add(new TimeSeriesSales(e.get('date').toDate(), e.get('bukalapak')));
      shopee.add(new TimeSeriesSales(e.get('date').toDate(), e.get('shopee')));
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

  Widget _lineStatistic() {
    return StreamBuilder<QuerySnapshot>(
      stream: statistics
          .doc(this.uid)
          .collection('dates')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkDatalab,
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        } else {
          var list = _createSeriesList(snapshot.data!);
          return _lineChart(list);
        }
      },
    );
  }

  Future<void> initPreference() async {
    _userID = await PrefRepository.getUserID() ?? '';
  }

  @override
  void initState() {
    super.initState();
    print(this.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  ConstColor.backgroundDatalab,
                  ConstColor.backgroundDatalab
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Grafik Pengunjung UMKM',
                      style: GoogleFonts.lato(
                          color: ConstColor.textDatalab,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _dropDown(),
                    SizedBox(
                      height: 15,
                    ),
                    _lineStatistic(),
                    SizedBox(height: 100)
                  ],
                )))
      ]),
    ));
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

