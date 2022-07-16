
import 'package:employee_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



// email- nikhil@email.com
// password- nikhil12



final _fireStore = FirebaseFirestore.instance;


class StaffScreen extends StatefulWidget {

  static String id = 'staffScreen';
  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late int experience;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getInformation();
    getInformationEmp();

  }

  // efficient way

  void getInformationEmp() async{
    await for(var snapshot in _fireStore.collection('employees').snapshots()){
      for(var info in snapshot.docs){
        print(info.data());
      }
    }
  }


  // standard method

  void getInformation() async{
    final information = await _fireStore.collection('employees').get();
    for(var info in information.docs){
      print(info.data());
    }
  }


//just to get info


  void getCurrentEmployee() async{
    try{
      final user = await _auth.currentUser;
      if(user  != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {

                Navigator.pop(context);

                getCurrentEmployee();
                //Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('Staff members'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InfoStream(),



          ],
        ),
      ),
    );
  }
}



class InfoStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('employees').snapshots(),
        builder: (context,snapshot){
          List<InfoBubble> infoBubbles = [];


          if(!snapshot.hasData){


          }
          final information = snapshot.data?.docs.reversed;
          for(var info in information!){
            final experience = info.get('experience');
            final employee =  info.get('email');



            final infoBubble = InfoBubble(employee: employee, experience: experience);

            infoBubbles.add(infoBubble);
          }

          return Expanded(
            child: ListView(
              children: infoBubbles,

            ),
          );




        });
  }
}




class InfoBubble extends StatelessWidget {
  
  InfoBubble({required this.employee,required this.experience});
  final String employee;
  final int experience;

  Color getFlag(){
    if(experience >5){
      return Colors.green;
    }else{
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(
                  '$employee with $experience of exp',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),

              ),
            ),
          ),
        ),

        Icon(Icons.flag,
          color: getFlag(),
        ),
      ],
    );
  }
}
