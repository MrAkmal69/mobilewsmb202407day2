import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var icController = TextEditingController();
  var passController = TextEditingController();

  File? _image;

  String? _name, _ic, _gender, _phone, _address, _carModel, _capacity, _speacialFeature, _email, _password;

  Widget _buildTextFormField ({
    required String labeltext,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onsaved,
    required TextInputType keyboardText,
    required TextEditingController controller,

    bool obscureText = false,
  }) {return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0)
          ),
          filled: true,
          fillColor: Colors.lightBlue,
          labelText: labeltext
      ),
      validator: validator,
      onSaved: onsaved,
      obscureText: obscureText,
      controller: controller,
    ),
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8ABDFC),
      appBar: AppBar(
        title: (Text('Please Register',style: GoogleFonts.exo2(fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.network("https://cdni.iconscout.com/illustration/premium/thumb/sign-up-page-1886582-1598253.png",height: 200,),
                      SizedBox(height: 10,),
                      _image == null
                          ? Text('No image selected')
                          :Image.file(_image!),
                      ElevatedButton(
                          onPressed: getImage,
                          child: Text('Upload Image')),
                      _buildTextFormField(
                          labeltext: 'Name',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Name') : null,
                          onsaved: (value) => _name = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Ic',
                          validator: (value) => value!.isEmpty ? ('Please Insert Your Ic number') : null,
                          onsaved: (value) => _ic = value,
                          keyboardText: TextInputType.number,
                          controller: icController
                      ),
                      _buildTextFormField(
                          labeltext: 'Phone Number',
                          validator: (value) => value!.isEmpty ? ('Please Insert Your Phone NUmber') : null,
                          onsaved: (value) => _phone = value,
                          keyboardText: TextInputType.number,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Gender',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Gender') : null,
                          onsaved: (value) => _gender = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Address',
                          validator: (value) => value!.isEmpty ? ('Please Insert Your Address') : null,
                          onsaved: (value) => _address = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Car Model',
                          validator: (value) => value!.isEmpty ? ('Please Insert Your Car Model') : null,
                          onsaved: (value) => _carModel = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Car Capacity',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Car Capacity') : null,
                          onsaved: (value) => _capacity = value,
                          keyboardText: TextInputType.number,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Car Special Feature',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Car Special Feature') : null,
                          onsaved: (value) => _speacialFeature = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Email',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Email') : null,
                          onsaved: (value) => _email = value,
                          keyboardText: TextInputType.text,
                          controller: TextEditingController()
                      ),
                      _buildTextFormField(
                          labeltext: 'Password',
                          validator: (value) => value!.isEmpty ? ('Please Enter Your Password') : null,
                          onsaved: (value) => _password = value,
                          keyboardText: TextInputType.text,
                          controller: passController
                      ),
                      ElevatedButton(
                          onPressed: uploadProfile,
                          child: Text('Submit')
                      ),
                      TextButton(
                          onPressed: (){Navigator.pushReplacementNamed(context, '/login');},
                          child: Text('Already Have Account Click here to log in',style: GoogleFonts.exo2(textStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),)
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }


  // function

  Future<void> getImage() async {
    final getImageC = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (getImageC != null) {
        _image = File(getImageC.path);
      }
    });
    final getImageG = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (getImageG != null){
        _image = File(getImageG.path);
      }
    });
  }

  Future<void> uploadProfile() async{

    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: '${icController.text}@example.com',
          password: passController.text
      );
      final user = userCredential.user;
      if (user == null){
        throw Exception('User Creation Failed');
      }

      String imageUrl = '';
      if(_image !=null){
        final storageRef = _storage.ref().child("Drivers Infomation");
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete((){});
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      await _fireStore.collection('driver').doc(user.uid).set({
        'Name': _name,
        'Ic': _ic,
        'Gender': _gender,
        'phone': _phone,
        'Address': _address,
        'Car Model': _carModel,
        'capacity': _capacity,
        'Special Feature' : _speacialFeature,
        'Email': _email,
        'Password': _password,
        'Image' : imageUrl
      });

      final snackBar = const SnackBar(
        content: Text('Registration Successfully'),
        backgroundColor: Colors.green,
        elevation: 1.5,
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacementNamed(context, '/login');

    } catch (e){
      print('Error: $e');

      final snackBar = const SnackBar(
        content: Text('Register Unsuccessfully, Please Try Again'),
        backgroundColor: Colors.red,
        elevation: 1.5,
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
