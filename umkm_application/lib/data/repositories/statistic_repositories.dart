import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StatisticRepository{
  static CollectionReference statistics = FirebaseFirestore.instance.collection('statistics');

  static Future<void> updateStatistic(String umkmID, String type) async {
    DateTime date = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    Timestamp timeStamp = Timestamp.fromDate(DateTime.parse(dateFormat.format(date)));
    QuerySnapshot stat = await statistics.doc(umkmID).collection('dates').where('date',isEqualTo: timeStamp).get();
    if(stat.size == 0){
      await statistics.doc(umkmID).collection('dates').add({
        'bukalapak' : 0,
        'date': timeStamp,
        'shopee' : 0,
        'store' : 0,
        'tokopedia' : 0
      }).then((doc){
        statistics.doc(umkmID).collection('dates').doc(doc.id).update({
          type : FieldValue.increment(1)
        });  
      });
      
    } else {
      await statistics.doc(umkmID).collection('dates').doc(stat.docs.first.id).update({
          type : FieldValue.increment(1)
        }); 
    }
  }
}