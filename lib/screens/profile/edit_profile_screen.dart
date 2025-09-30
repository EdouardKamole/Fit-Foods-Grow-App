import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _ageController.text = user.age.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green[100],
                child: const Icon(Icons.person, size: 50, color: Colors.green),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _changeProfilePicture,
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeProfilePicture() {
    // Implement profile picture change logic
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = _authService.currentUser!.copyWith(
        name: _nameController.text,
        age: int.parse(_ageController.text),
      );
      
      _authService.updateProfile(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    }
  }
}