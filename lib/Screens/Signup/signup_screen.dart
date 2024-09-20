import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Controllers for the text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to sign up the user
  Future<void> _signUp(BuildContext context) async {
    try {
      // Step 1: Create a new user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      print('email: ${_emailController.text.trim()}');
      print(_passwordController.text.trim());
      // Step 2: Store additional user information in Firestore under 'Users' collection
      if (user != null) {
        print('UID: ${user.uid}');
        await _firestore.collection('Users').doc(user.uid).set(
          {
            'full_name': _fullNameController.text.trim(),
            'email': _emailController.text
                .trim(), // Store email in Firestore as well
          },
        );

        // Success: Navigate to home page or show success message
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      // Handle errors (e.g., email already in use)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: ${e.toString()}')),
      );
    }
  }

  List<List<String>> fields = [
    ['Full Name', 'Enter your full name'],
    ['Email', 'Enter your email'],
    ['Password', 'Enter a password'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 40),
            ),
            Column(
              children: List.generate(fields.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fields[index][0],
                        style: GoogleFonts.interTight(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextField(
                        controller: fields[index][0] == 'Full Name'
                            ? _fullNameController
                            : fields[index][0] == 'Email'
                                ? _emailController
                                : fields[index][0] == 'Password'
                                    ? _passwordController
                                    : null,

                        decoration: InputDecoration(
                          hintText: fields[index][1],
                          hintStyle: GoogleFonts.interTight(
                            textStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ), // Hint text
                        ),
                        obscureText: fields[index][0].toLowerCase().contains(
                            'password'), // Hide text for password fields
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
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
                onPressed: () => _signUp(context),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB3714A),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
