import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';

class AddPhoneNumberPage extends StatefulWidget {
  const AddPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<AddPhoneNumberPage> createState() =>
      // ignore: no_logic_in_create_state
      _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  Country selectedCountry =
      countries.where((element) => element.code == 'EG').first;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  bool doesLoadVerificationArea = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register phone number")),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (doesLoadVerificationArea)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Enter Verification Code',
                  ),
                  controller: verificationCodeController,
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<Country>(
                    value: selectedCountry,
                    items: countries.map<DropdownMenuItem<Country>>((_country) {
                      return DropdownMenuItem(
                          value: _country,
                          child: Text(
                              "${_country.flag} ${_country.code} [+${_country.dialCode}]"));
                    }).toList(),
                    onChanged: (_country) {
                      setState(() {
                        selectedCountry = _country ?? selectedCountry;
                      });
                    },
                  ),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                      ),
                      controller: phoneNumberController,
                    ),
                  ),
                ],
              ),
  //           ElevatedButton(
  //             onPressed: () {
  //               if(doesLoadVerificationArea){
  // PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //               verificationId: verificationId, smsCode: smsCode);

  //           // Sign the user in (or link) with the credential
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //               }else{
  //                 AuthServices.registerUsingPhoneNumber(
  //                     selectedCountry.dialCode + phoneNumberController.text,
  //                     (user) {
  //                   setUserLoggedIn(
  //                     user?.email,
  //                     user?.displayName,
  //                     user?.phoneNumber,
  //                     user?.photoURL,
  //                     user?.uid,
  //                   );
  //                   Navigator.of(context).popAndPushNamed("/");
  //                 }, (callback) {
  //                   var code = "....";
  //                   callback(code);
  //                 });

  //               }
  //             },
  //             child: Text(
  //               doesLoadVerificationArea ? "Verify" : "Register",
  //             ),
  //           ),
          ],
        ),
      ),
    );
  }
}
