import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilewsmb202407day2/driverprofile.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final _fireStore = FirebaseFirestore.instance;
  List<bool> _hasBeenPressed = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('Welcome To Kongsi Kereta'),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(onPressed: (){Navigator.pushReplacementNamed(context, '/');},
            icon: Icon(Icons.logout)),
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('AddRide').snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final addrides = snapshot.data!.docs;

            if (_hasBeenPressed.length != addrides.length){
              _hasBeenPressed = List.generate(addrides.length, (_) => false);
            }

            return ListView.builder(
                itemCount: addrides.length,
                itemBuilder:(context, index){
                  var rideList = [index];
                  var name = rideList[index];
                  var time = rideList[index];
                  var date = rideList[index];
                  var origin = rideList[index];
                  var destination = rideList[index];
                  var fare = rideList[index];

                  return Card(

                    elevation: 5,
                    color: _hasBeenPressed[index] ? Color(0xFF27C900): Color(0xFFFFFFFF),
                    margin:  EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: $name', style: GoogleFonts.exo2(),),
                              Text('Time: $time',style: GoogleFonts.exo2(),),
                              Text('Date: $date',style: GoogleFonts.exo2(),),
                              Text('Origin: $origin',style: GoogleFonts.exo2(),),
                              Text('Destination: $destination',style: GoogleFonts.exo2(),),
                              Text('Fare: Rm $fare',style: GoogleFonts.exo2(),),
                              
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                buttonPadding: EdgeInsets.zero,
                                children: [
                                  _hasBeenPressed[index]
                                  ? TextButton(
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: const Text('Ride Cancelled',style: TextStyle(fontWeight: FontWeight.bold),),
                                                content: const SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Your Ride Has Been Cancelled'),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (){Navigator.of(context).pop();},
                                                      child: const Text('Ok')
                                                  )
                                                ],
                                              );
                                            },
                                        );
                                        setState(() {
                                          _hasBeenPressed [index] = false;
                                        });
                                      },
                                      child: Text('Cancel',style: GoogleFonts.exo2(),),
                                  )
                                      :TextButton(
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text('Ride Confirmation',
                                              style: TextStyle(color: Color(0xff5AAf51),fontWeight: FontWeight.bold),),
                                              content: const SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Your ride has been confirmed')
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Ok')
                                                ),
                                              ],
                                            );
                                          }
                                          );
                                        setState(() {
                                          _hasBeenPressed[index] = true;
                                        });
                                      },
                                      child: Text('Join This Ride',style: GoogleFonts.exo2(fontWeight: FontWeight.bold),)
                                  ),
                                  OutlinedButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DriverprofilePage()
                                        ),
                                        );
                                      },
                                      child: Text("View Driver's Profile",style: GoogleFonts.exo2(fontWeight: FontWeight.bold),)
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
