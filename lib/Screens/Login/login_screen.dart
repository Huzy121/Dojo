import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to sign in using Firebase Auth
  Future<void> _signIn(BuildContext context) async {
    // <-- Modified this method
    try {
      // Perform sign-in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to HomePage after successful login
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Handle login error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <-- Added this
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Added to align content to start
            children: [
              Text(
                'DOJO',
                style: TextStyle(fontSize: 100.0),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  top: 150.0,
                ),
                child: Text('Login to your Account'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(PhosphorIcons.envelopeSimple()),
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(PhosphorIcons.lock()),
                  suffixIcon: Icon(PhosphorIcons.eyeSlash()),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Remember me'),
                  Text('Forgot Password?'),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Color(0xFFFAF1E8),
                    shadowColor: Colors.black.withOpacity(0.25),
                    elevation: 1,
                  ),
                  onPressed: () => _signIn(context),
                  child: Text(
                    'Login',
                    style: GoogleFonts.interTight(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB3714A),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Text('Don\'t have an account? Sign Up'),
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
