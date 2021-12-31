import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:north_star/Auth/SignIn.dart';
import 'package:north_star/Plugins/HttpClient.dart';
import 'package:north_star/Styles/Themes.dart';
import 'package:north_star/Styles/TypographyStyles.dart';

class SignUpClient extends StatelessWidget {
  const SignUpClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool loading = false.obs;
    RxList countries = [].obs;
    RxInt gender = 0.obs;
    void toggle() {
      loading.value = !loading.value;
    }

    void showSnack(String title, String message) {
      Get.snackbar(title, message,
          margin: const EdgeInsets.all(16),
          backgroundColor: Themes.mainThemeColor.shade900,
          colorText: Colors.white);
    }

    RxBool tAc = false.obs;
    TextEditingController fName = new TextEditingController();
    TextEditingController lName = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController nic = new TextEditingController();

    TextEditingController dobController = new TextEditingController();

    TextEditingController mobile = new TextEditingController();
    TextEditingController emergencyNo = new TextEditingController();
    TextEditingController emergencyName = new TextEditingController();

    TextEditingController password = new TextEditingController();
    TextEditingController cPassword = new TextEditingController();

    TextEditingController country = new TextEditingController();
    int? countryID;

    void signUp() async {
      if (fName.text.isEmpty || lName.text.isEmpty) {
        showSnack('Empty First and Last Name', 'Please provide your first and last name');
      } else if (dobController.text.isEmpty) {
        showSnack('Invalid Date of Birth', 'Please province a valid Date of Birth');
      } else if (nic.text.isEmpty) {
        showSnack('Invalid NIC Number', 'Please province a valid NIC Number');
      } else if (!email.text.isEmail) {
        showSnack('Invalid Email', 'Please province a valid Email');
      } else if ((password.text.length < 8) ||
          (password.text != cPassword.text)) {
        showSnack('Invalid/Mismatching Passwords', 'Please province a valid ( more than 8 characters long ) and same password');
      } else if (!mobile.text.isPhoneNumber) {
        showSnack('Invalid Mobile Number', 'Please province a valid Phone Number');
      } else if (emergencyName.text.isEmpty) {
        showSnack('Invalid Emergency Contact Name', 'Please province a valid emergency contact name');
      } else if (!emergencyNo.text.isPhoneNumber) {
        showSnack('Invalid Emergency Contact Phone', 'Please province a valid emergency contact phone number');
      } else if (!tAc.value) {
        showSnack('Not Agreed to Terms and Conditions', 'Please read and mark as agreed to terms and conditions');
      } else if (countryID == null) {
        showSnack('Invalid Country', 'Please select your country!');
      }else {
        toggle();
        var request = http.MultipartRequest(
            'POST', Uri.parse('https://ion-groups.live/api/clients'));
        request.fields.addAll({
          'full_name': fName.text + ' ' + lName.text, //'Test Client Up 2',
          'birth_date': dobController.text,
          'country_id': countryID.toString(),
          'nic': nic.text, //'960767675V',
          'mobile_no': mobile.text, //'0766250449',
          'emergency_one_name': emergencyName.text, //'Thilak',
          'emergency_one_contact_no': emergencyNo.text, //'0776767678',
          'email': email.text, //'k@5.com',
          'password': password.text, //'password',
          'password_confirmation': cPassword.text, //'password',
          'gender': gender.value == 0 ? 'Male':'Female'
        });

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          //print(await response.stream.bytesToString());
          var res = jsonDecode(await response.stream.bytesToString());
          showSnack('Registration Successful',
              'Please login with your new credentials');
          toggle();
          print('Reg Success!');

          Get.offAll(() => SignIn());
        } else {
          print(await response.stream.bytesToString());
          toggle();
        }
      }
    }

    Rx<DateTime> dob = new DateTime.now().obs;

    void pickDOBDialog() {
      showDatePicker(
          context: context,
          initialDate: dob.value,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFFF1AB56),
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFF1AB56)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          }).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        dob.value = pickedDate;
        dobController.text = pickedDate.toString().split(' ')[0];
      });
    }

    void getCountries() async{
      var request = http.Request('GET', Uri.parse(HttpClient.baseURL + '/api/countries'));


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        countries.value = jsonDecode(res);
      }
      else {
      print(response.reasonPhrase);
      }

    }

    getCountries();

    return Scaffold(
      appBar: AppBar(
        title: Text('Client Registration'),
      ),
        body: Container(
      height: Get.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    TextField(
                      controller: fName,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: lName,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: dobController,
                      onTap: () {
                        pickDOBDialog();
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: nic,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'NIC Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: email,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: password,
                      style: TextStyle(fontSize: 18),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: cPassword,
                      style: TextStyle(fontSize: 18),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: mobile,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: emergencyName,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Emergency Contact Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: emergencyNo,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Emergency Contact Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 8),
                    Obx(()=>Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gender',style: TypographyStyles.title(16)),
                        Row(
                          children: [
                            Radio(groupValue: gender.value, onChanged: (value) {
                              gender.value = int.parse(value.toString());
                            }, value: 0, ),
                            Text('Male'),
                            Radio(groupValue: gender.value, onChanged: (value) {
                              gender.value = int.parse(value.toString());
                            }, value: 1,),
                            Text('Female'),
                          ],
                        )
                      ],
                    )),
                    SizedBox(height: 8),
                    TextField(
                      controller: country,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Container(
                                height: MediaQuery.of(context).size.height*0.6,
                                child: Obx(()=>ListView.builder(
                                  itemCount: countries.length,
                                  itemBuilder: (_,index){
                                    return ListTile(
                                      title: Text(countries[index]['name']),
                                      onTap: (){
                                        country.text = countries[index]['name'];
                                        countryID = countries[index]['id'];
                                        Get.back();
                                      },
                                    );
                                  },
                                ))
                              );
                            }
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Obx(() {
                return Checkbox(
                    value: tAc.value,
                    onChanged: (val) {
                      tAc.value = val!;
                    });
              }),
              Text('Agree to Terms and Condition')
            ],
          ),
          SizedBox(height: 8),
          Container(
            width: Get.width,
            height: 58,
            child: Obx(() {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: Themes().roundedBorder(12),
                    primary: Color(0xFF1C1C1C)),
                child: loading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                onPressed: () {
                  signUp();
                },
              );
            }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: TextStyle(color: Colors.black)),
                TextButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Get.to(() => SignIn());
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
