import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../dashboard/home_screen.dart';

class ParentConsentScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ParentConsentScreen({super.key, required this.userData});

  @override
  State<ParentConsentScreen> createState() => _ParentConsentScreenState();
}

class _ParentConsentScreenState extends State<ParentConsentScreen> {
  final _parentEmailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendConsentRequest() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    final success = await authService.signup(
      widget.userData['email'],
      'password', // In real app, this would come from previous screen
      widget.userData['name'],
      widget.userData['age'],
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Consent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Parent/Guardian Consent Required',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'For users under 13, we need parent/guardian consent to create an account.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _parentEmailController,
              decoration: const InputDecoration(
                labelText: "Parent/Guardian's Email",
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter parent/guardian email address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter parent email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'We will send a consent request email to the provided address. '
              'Your account will be activated once consent is given.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendConsentRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Send Consent Request',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}