import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                      onChanged: (data) {
                        email = data;
                        print(email);
                      },
                      labelText: 'Email'),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                      onChanged: (data) {
                        password = data;
                        print(password);
                      },
                      labelText: 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await registerUser();
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBar(context, 'Weak Password');
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context, 'Email already exists');
                              }
                            } catch (e) {
                              showSnackBar(
                                  context, 'Please enter email and password');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        },
                        text: 'Sign Up',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Alredy have an account? ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
