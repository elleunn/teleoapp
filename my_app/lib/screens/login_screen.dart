import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // ✅ Import this
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget { // 🔹 Make it Stateful
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    setState(() => isLoading = true);

    try {
      UserCredential userCredential;

      if (kIsWeb) {
        // 🌐 Web (Use Sign-in with Popup)
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        // 📱 Mobile (Use OAuth Credential)
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithProvider(googleProvider);
      }

      final User? user = userCredential.user;
      if (user != null) {
        await authenticateWithBackend(user);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed: $e")));
      setState(() => isLoading = false);
    }
  }

  Future<void> authenticateWithBackend(User user) async {
    final idToken = await user.getIdToken();
    const String backendUrl = "http://localhost:5000/authenticate";

    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": idToken}),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome, ${data['user']['name']}")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Authentication failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF9F2), // Light background color
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Logo
              Image.asset(
                'assets/logo.png', // Replace with your image asset
                height: 120,
              ),
              SizedBox(height: 20),

              // 🔹 Welcome Text
              Text(
                "Welcome to Teleo!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),

              // 🔹 Continue with Email Button
              ElevatedButton(
                onPressed: () {
                  // Handle email login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9B0000), // Red color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Continue with Email",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),

              // 🔹 Continue with Google Button
              OutlinedButton(
                onPressed: signInWithGoogle, // ✅ Call sign-in function
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Color(0xFF9B0000)), // Red border
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Color(0xFF9B0000))
                    : Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 16, color: Color(0xFF9B0000)),
                      ),
              ),
              SizedBox(height: 15),

              // 🔹 OR Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 15),

              // 🔹 Continue as Guest Button
              ElevatedButton(
                onPressed: () {
                  // Handle guest login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9B0000), // Red color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // 🔹 Sign Up Text
              TextButton(
                onPressed: () {
                  // Navigate to sign-up screen
                },
                child: Text(
                  "Registered Church? Sign Up",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
