import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  final Map<String, String> formData = {};

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome inválido';
    }

    return null;
  }

  void _loadFormData(User? user) {
    if (user == null) {
      return;
    }

    formData['id'] = user.id;
    formData['name'] = user.name;
    formData['email'] = user.email;
    formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User?;
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = form.currentState?.validate();
              if (isValid ?? false) {
                form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: formData['id'] ?? '',
                    name: formData['name'] ?? '',
                    email: formData['email'] ?? '',
                    avatarUrl: formData['avatarUrl'] ?? '',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: formData['name'],
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: _validator,
                  onSaved: (value) => formData['name'] = value ?? '',
                ),
                TextFormField(
                  initialValue: formData['email'],
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: _validator,
                  onSaved: (value) => formData['email'] = value ?? '',
                ),
                TextFormField(
                  initialValue: formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'URL do Avatar'),
                  onSaved: (value) => formData['avatarUrl'] = value ?? '',
                ),
              ],
            )),
      ),
    );
  }
}
