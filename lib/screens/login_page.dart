import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

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
                        'Login',
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
                      },
                      labelText: 'Email'),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                      obsecureText: true,
                      onChanged: (data) {
                        password = data;
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
                            await loginUser();
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                  context, 'No user found for this email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,
                                  'Wrong password provided for this user.');
                            }
                          } catch (e) {
                            showSnackBar(
                                context, 'Please enter email and password');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      },
                      text: 'Login',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Register',
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
