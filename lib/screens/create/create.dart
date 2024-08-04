import 'package:flutter/material.dart';
import 'package:demo_rpg/models/vocation.dart';
import 'dart:developer';
import 'package:demo_rpg/models/character.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();
  final _nameFocusNode = FocusNode(); // Create a FocusNode for the name field
  Vocation? _selectedVocation;
  bool _formInteracted = false;

  @override
  void initState() {
    super.initState();
    // Request focus for the name field when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    _nameFocusNode.dispose(); // Dispose the FocusNode
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

  bool get _isFormValid {
    return _formInteracted && _validateForm();
  }

  void _updateFormState() {
    setState(() {
      _formInteracted = true;
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                focusNode:
                    _nameFocusNode, // Assign the FocusNode to the name field
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
      ),
    );
  }

  String? Function(String?) _validateTextField(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
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

          log('Name: ${_nameController.text}');
          log('Name nullty: ${_nameController.value}');
          log('Name nullty: ${_nameController.text}');

          log('Slogan: ${_sloganController.text}');
          log('Slogan nullty: ${_sloganController.value}');
          log('Slogan nullty: ${_sloganController.text}');
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
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/vocations/${vocation.image}',
              width: 140,
              colorFilter: !isSelected
                  ? const ColorFilter.mode(Colors.white, BlendMode.saturation)
                  : null,
            ),
            Expanded(
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
                  Text(
                    vocation.description,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('Weapon: ${vocation.weapon}'),
                  Text('Ability: ${vocation.ability}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCharacterCreation() {
    if (_validateForm()) {
      log('Character created:');
      log('Name: ${_nameController.text}');
      log('Slogan: ${_sloganController.text}');
      log('Vocation: ${_selectedVocation!.title}');
      characters.add(Character(
          name: _nameController.text.trim(),
          slogan: _sloganController.text.trim(),
          id: uuid.v8g(),
          vocation:
              _selectedVocation!)); // Add the null-aware operator '!' to assert that _selectedVocation is not null
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }
  }
}
