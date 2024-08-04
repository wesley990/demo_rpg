import 'package:flutter/material.dart';
import 'package:demo_rpg/models/vocation.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final List<Vocation> vocations = Vocation.values;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Create Character'),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Slogan',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vocations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(vocations[index].toString()),
                    onTap: () {
                      _handleVocationSelection(index);
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle character creation
                },
                child: const Text('Create Character'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleVocationSelection(int index) {
    // TODO: Implement vocation selection logic
  }
}
