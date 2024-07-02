import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

class UpBeritaPage extends StatelessWidget {
  const UpBeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Berita'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showAddBeritaBottomSheet(context);
          },
          child: const Text('Add Berita'),
        ),
      ),
    );
  }

  void _showAddBeritaBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddBeritaForm(),
        );
      },
    );
  }
}

class AddBeritaForm extends StatefulWidget {
  const AddBeritaForm({super.key});

  @override
  State<AddBeritaForm> createState() => _AddBeritaFormState();
}

class _AddBeritaFormState extends State<AddBeritaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  String _kategori = 'lifestyle';
  String _status = 'aktif';
  bool _isLoading = false;

  Future<void> _submitBerita() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('https://demo.amoratours.id/api/newss/up/1'),
        body: {
          'judul': _judulController.text,
          'tag': _tagController.text,
          'isi': _isiController.text,
          'kategori': _kategori,
          'status': _status,
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        _showErrorDialog('Failed to add berita');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tagController,
                decoration: const InputDecoration(labelText: 'Tag'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a tag';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(
                  labelText: 'Isi',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the content';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _kategori,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: const [
                  DropdownMenuItem(value: 'lifestyle', child: Text('Lifestyle')),
                  DropdownMenuItem(value: 'kpop', child: Text('Kpop')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    _kategori = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'aktif', child: Text('Aktif')),
                  DropdownMenuItem(value: 'off', child: Text('Off')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitBerita,
                      child: const Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
