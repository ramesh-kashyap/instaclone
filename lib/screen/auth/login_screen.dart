import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screen/auth/register_screen.dart';
import 'package:instagram_clone/screen/home_screen.dart';
import 'package:instagram_clone/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser() async {
    try {
      // 🔍 Validation
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar("Error", "All fields are required");
        return;
      }

      final response = await ApiService.post('/login', {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      print("Login Response: ${response.data}");

      final data = response.data;

      // ✅ Success
      if (response.statusCode == 200 && data['token'] != null) {
        await ApiService.saveToken(data['token']);

        Get.snackbar("Success", "Login successful ✅");

        // 🚀 Navigate to Home

        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Login Failed", data['message'] ?? "Invalid credentials");
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? "Login failed";
      Get.snackbar("Error", errorMessage);
    } catch (e) {
      print("Login Error: $e");
      Get.snackbar("Error", "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF7B61FF);

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),

              // 🖼️ Illustration (replace with your asset)
              Image.asset(
                "assets/logo.png", // add your image here
                height: 180,
              ),

              SizedBox(height: 20),

              // 📝 TITLE
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Enter valid user name & password to continue",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 25),

              // 👤 USERNAME FIELD
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 🔒 PASSWORD FIELD
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 10),

              // 🔗 FORGOT PASSWORD
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget password",
                  style: TextStyle(color: primaryColor),
                ),
              ),

              SizedBox(height: 20),

              // 🚀 LOGIN BUTTON (PURPLE)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    loginUser();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 25),

              // ➖ OR CONTINUE WITH
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or Continue with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              SizedBox(height: 20),

              // 🌐 SOCIAL BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialButton("Google", Icons.g_mobiledata),
                  _socialButton("Facebook", Icons.facebook),
                ],
              ),

              SizedBox(height: 30),

              // 🆕 SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Haven’t any account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => RegisterScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween(
                                begin: Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xFF7B61FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(children: [Icon(icon), SizedBox(width: 8), Text(text)]),
    );
  }
}
