import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screen/auth/login_screen.dart';
import 'package:instagram_clone/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordHidden = true;

  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearForm() {
    nameController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> registerUser() async {
    try {
      print(
        "Registering user with: ${usernameController.text}, ${emailController.text}",
      );
      if (nameController.text.isEmpty ||
          usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.snackbar("Error", "All fields are required");
        return;
      }

      final response = await ApiService.post('/register', {
        "name": nameController.text.trim(),
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      print("Register Response: ${response.statusCode} - ${response.data}");

      final data = response.data;

      // ✅ Success check
      if (response.statusCode == 201) {
        print("Registration successful for ${usernameController.text}");

        Get.snackbar("Success", "Account created successfully ✅");

        // 🧹 Clear form
        clearForm();

        // ⌨️ Hide keyboard
        FocusScope.of(context).unfocus();

        // ⏳ Delay then navigate

        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(() => LoginScreen()); // ✅ redirect properly
        });
      } else {
        Get.snackbar(
          "Register Failed",
          data['message'] ?? "Something went wrong",
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? "Registration failed";

      Get.snackbar("Error", errorMessage);
    } catch (e) {
      print("Register Error: $e");
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

              // 🖼️ Illustration
              Image.asset(
                "assets/logo.png", // add your image
                height: 180,
              ),

              SizedBox(height: 20),

              // 📝 TITLE
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),
              Text(
                "Use proper information to continue",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 25),

              // 👤 FULL NAME
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Full name",
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 👤 Username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 📧 EMAIL
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
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

              SizedBox(height: 15),

              // 📜 TERMS TEXT
              Text(
                "By signing up, you agree to our Terms & Conditions and Privacy Policy",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              // 🚀 CREATE ACCOUNT BUTTON
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
                    registerUser();
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 25),

              // 🔁 LOGIN LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginScreen(),
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
                      "Sign in",
                      style: TextStyle(
                        color: primaryColor,
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
}
