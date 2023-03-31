import 'package:cloud_firestore/cloud_firestore.dart';

getData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('videos').get();

  // for (var ele in querySnapshot.docs) {
  //   print(ele.data());
  // }

  await FirebaseFirestore.instance
      .collection("hey")
      .doc()
      .set({'lalal': 'dijfijd'});

  var take = await FirebaseFirestore.instance.collection("hey").doc().get();

  // await FirebaseFirestore.instance.collection("hey").doc().get().then((value) =>);

  print((take.data() as List)[0]);

  // take.map((event) {
  //   print(event.docs);
  //   print("luncd");
  // });

  print("luncd");

  // for(var exe in take.)

  // for (var sls in take.data()) {}

  // print(take);
}
