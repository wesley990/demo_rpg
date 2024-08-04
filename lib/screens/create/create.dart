import 'package:flutter/material.dart';
import 'package:demo_rpg/models/vocation.dart';
import 'dart:developer';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();
  Vocation? _selectedVocation;
  bool _formInteracted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    // Trigger the form's built-in validation
    final isFormValid = _formKey.currentState?.validate() ?? false;

    // Check individual field validations
    final isNameValid = _nameController.text.trim().isNotEmpty;
    final isSloganValid = _sloganController.text.trim().isNotEmpty;
    final isVocationSelected = _selectedVocation != null;

    // Combine all validation results
    return isFormValid && isNameValid && isSloganValid && isVocationSelected;
  }

// Update the _isFormValid getter
  bool get _isFormValid {
    return _formInteracted && _validateForm();
  }

  void _updateFormState() {
    setState(() {
      _formInteracted = true;
      // Remove the manual call to validate here
      // _formKey.currentState?.validate();
      // Instead, call _validateForm() to update the form state
      _validateForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Character'),
      ),
      body: Form(
        key: _formKey,
        onChanged: _updateFormState,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: _validateTextField('name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _sloganController,
              decoration: const InputDecoration(
                labelText: 'Slogan',
                border: OutlineInputBorder(),
              ),
              validator: _validateTextField('slogan'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose your vocation:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...Vocation.values
                .map((vocation) => _buildVocationContainer(vocation)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isFormValid ? _handleCharacterCreation : null,
              child: const Text('Create Character'),
            ),
            if (!_isFormValid)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please fill in all fields and select a vocation to create your character.',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? Function(String?) _validateTextField(String fieldName) {
    return (value) {
      if (value == null || value!.trim().isEmpty) {
        return 'Please enter a $fieldName';
      }
      return null;
    };
  }

  Widget _buildVocationContainer(Vocation vocation) {
    final isSelected = vocation == _selectedVocation;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVocation = vocation;
          _formInteracted = true;

          // print name and slogan of text filed
          log('Name: ${_nameController.text}');
          log('Name nullty: ${_nameController.value}');
          log('Name nullty: ${_nameController.text}');

          log('Slogan: ${_sloganController.text}');
          log('Slogan nullty: ${_sloganController.value}');
          log('Slogan nullty: ${_sloganController.text}');
          // Trigger form validation
          _formKey.currentState?.validate();
          log('_formInteracted: $_formInteracted');
          log('isValid: ${_formKey.currentState?.validate()}');
          log('selectedVocation: $_selectedVocation');
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vocation.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Theme.of(context).primaryColor : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(vocation.description),
            const SizedBox(height: 4),
            Text('Weapon: ${vocation.weapon}'),
            Text('Ability: ${vocation.ability}'),
          ],
        ),
      ),
    );
  }

// Update _handleCharacterCreation method
  void _handleCharacterCreation() {
    if (_validateForm()) {
      // Proceed with character creation
      log('Character created:');
      log('Name: ${_nameController.text}');
      log('Slogan: ${_sloganController.text}');
      log('Vocation: ${_selectedVocation!.title}');
    } else {
      // Show an error message or handle the invalid form state
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }
  }
}
// version 1

// Implemented a Form widget with validation for all fields.
// Used TextFormField for name and slogan inputs, with validation to ensure they're not empty.
// Replaced the ListView.builder for vocations with a DropdownButtonFormField for better UX.
// Added state management to enable/disable the "Create Character" button based on form validity.
// Included a reminder message when the form is incomplete.
// Followed modern Flutter practices like using const constructors and proper widget structuring.
// Implemented proper disposal of controllers in the dispose method.
// Used Scaffold for better overall structure and to include an AppBar.

// This implementation provides a more user-friendly interface with proper form validation and feedback. The "Create Character" button is disabled until all fields are filled correctly, and a reminder message is displayed when the form is incomplete.
// To use this updated version, you'll need to ensure that your Vocation enum is properly defined in the models/vocation.dart file. Also, remember to implement the actual character creation logic in the _handleCharacterCreation method when you're ready to proceed with that part of your application.