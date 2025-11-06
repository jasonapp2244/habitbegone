import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:habitsbegone/utils/utils.dart';
import 'package:habitsbegone/view/auth/login_view.dart';
import 'package:habitsbegone/widgets/auth_button.dart';
import 'package:habitsbegone/widgets/components/social_bitton.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _loading = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode nameFoucsNode = FocusNode();
  FocusNode emailFoucsNode = FocusNode();
  FocusNode passwordFoucsNode = FocusNode();
  FocusNode sumbitFoucsNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    passwordFoucsNode.dispose();
    emailFoucsNode.dispose();
    _obsecurePassword.dispose();
  }

  Future<void> _signUp() async {
    // if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      // 1️⃣ Create Firebase user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      User? user = userCredential.user;

      if (user != null) {
        // 2️⃣ Send verification email
        await user.sendEmailVerification();

        // 3️⃣ Save user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': _nameController.text.trim(),
          'isPaid': false,
          'isActive': true,
          'emailVerified': user.emailVerified,
          'joinedAt': FieldValue.serverTimestamp(),
        });

        // 4️⃣ Inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Verification email sent! Please verify before login.',
            ),
          ),
        );

        // 5️⃣ Navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'email-already-in-use') {
        error = 'Email already in use.';
      } else if (e.code == 'invalid-email') {
        error = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        error = 'Password should be at least 6 characters.';
      } else {
        error = 'Something went wrong. Please try again.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize responsive class
    Responsive.init(context);
    // final authViewmodel = Provider.of<AuthViewmodel>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5), // 5% of screen width
            vertical: Responsive.h(2), // 2% of screen height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Responsive.h(2)), // 2% of screen height
                Image(image: AssetImage("assets/images/app_bar.png")),
                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Account",
                      style: GoogleFonts.rethinkSans(
                        color: AppColors.textColorBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.sp(25), // Responsive font size
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Create your account to explore about our app",
                      style: GoogleFonts.rethinkSans(
                        color: AppColors.textColorBlack,
                        fontWeight: FontWeight.normal,
                        fontSize: Responsive.sp(10.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(3)),
                TextFormField(
                  style: TextStyle(color: AppColors.textColorBlack),
                  controller: _nameController,
                  focusNode: nameFoucsNode,
                  cursorColor: AppColors.textColorBlack,
                  cursorErrorColor: AppColors.seconadryColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(Responsive.w(3)), // 2% of width
                      child: SvgPicture.asset(
                        "assets/images/user-multiple-02.svg",
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    hintText: "Full Name",
                    hintStyle: GoogleFonts.dmSans(
                      color: AppColors.textColorBlack,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.sp(12),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFoucsChnage(
                      context,
                      emailFoucsNode,
                      passwordFoucsNode,
                    );
                  },
                ),
                SizedBox(height: Responsive.h(3)),
                TextFormField(
                  style: TextStyle(color: AppColors.textColorBlack),
                  controller: _emailController,
                  focusNode: emailFoucsNode,
                  cursorColor: AppColors.textColorBlack,
                  cursorErrorColor: AppColors.seconadryColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: AppColors.borderCardColor),
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(Responsive.w(3)), // 2% of width
                      child: SvgPicture.asset("assets/images/mail-02.svg"),
                    ),
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    hintText: "Email Address",
                    hintStyle: GoogleFonts.dmSans(
                      color: AppColors.textColorBlack,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.sp(12),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFoucsChnage(
                      context,
                      emailFoucsNode,
                      passwordFoucsNode,
                    );
                  },
                ),
                SizedBox(height: Responsive.h(3)),
                ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      style: TextStyle(color: AppColors.textColorBlack),
                      controller: _passwordController,
                      focusNode: passwordFoucsNode,
                      cursorColor: AppColors.textColorBlack,
                      cursorErrorColor: AppColors.seconadryColor,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        focusColor: AppColors.primaryColor,
                        filled: true,
                        fillColor: AppColors.primaryColor,
                        hintText: "Password",
                        hintStyle: GoogleFonts.dmSans(
                          color: AppColors.textColorBlack,
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.sp(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                          // borderSide: BorderSide(color: AppColors.borderCardColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                          // borderSide: BorderSide(color: AppColors.borderCardColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: AppColors.borderCardColor),
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(Responsive.w(3)),
                          child: SvgPicture.asset(
                            "assets/images/lock-password.svg",
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(
                            _obsecurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.filledtextColor,
                            size: Responsive.sp(20),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: Responsive.h(2.5)),
                AuthButton(
                  buttontext: "Signup",
                  loading: _loading,
                  //  authViewmodel.loading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.toastMassage("Please Enter Email First");
                    } else if (_passwordController.text.isEmpty) {
                      Utils.toastMassage("Please Enter Password First");
                    } else if (_passwordController.text.length < 8) {
                      Utils.toastMassage(
                        "Please Enter 8 digits",
                        // context,
                      );
                    } else {
                      _signUp();
                      // Navigator.pushReplacementNamed(
                      //   context,
                      //   RoutesName.choseplanView,
                      // );
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
                      // );
                      // Navigator.pushReplacementNamed(context, RoutesName.homeview);
                      // Map<String, String> headr = {
                      //   "x-api-key": "reqres-free-v1",
                      // };
                      // Map data = {
                      //   'email': emailController.text.toString(),
                      //   'password': passwordController.text.toString(),
                      // };
                      // authViewmodel.loginApi(data, headr, context);
                    }
                  },
                ),
                SizedBox(height: Responsive.h(2)),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.filledColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(3),
                      ),
                      child: Text(
                        "OR",
                        style: GoogleFonts.dmSans(
                          color: AppColors.filledtextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.sp(10),
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.filledColor)),
                  ],
                ),
                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      iconPath: 'assets/images/devicon_google (1).svg',
                      ontap: () {},
                    ),
                    // _buildSocialButton("assets/icons/google.svg"),
                    _buildSocialButton("assets/images/logos_facebook.svg"),
                    _buildSocialButton("assets/images/logos_apple.svg"),
                  ],
                ),
                SizedBox(height: Responsive.h(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: "Already have an Accout? ",
                        style: TextStyle(
                          color: AppColors.filledColor,
                          fontSize: Responsive.sp(12),
                        ),
                        children: [
                          TextSpan(
                            text: "login",
                            style: TextStyle(
                              color: AppColors.filledtextColor,
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   // MaterialPageRoute(
                                    //   //   builder: (_) => Sginupview(),
                                    //   // ),
                                    // );
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RoutesName.loginview,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath) {
    return Container(
      height: Responsive.h(6), // 6% of screen height
      width: Responsive.w(25), // 20% of screen width
      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.filledColor),
        borderRadius: BorderRadius.circular(Responsive.w(5.5)),

        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(3)),
        child: SvgPicture.asset(iconPath),
        // Image(image: AssetImage(iconPath)),
        // Image( iconPath),
      ),
    );
  }
}
