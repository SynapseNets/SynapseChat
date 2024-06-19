import 'package:flutter/material.dart';


class SynapseNetsAppHomepage extends StatefulWidget {
  const SynapseNetsAppHomepage({super.key});

  @override
  State<SynapseNetsAppHomepage> createState() => _SynapseNetsAppHomepageState();
}

class _SynapseNetsAppHomepageState extends State<SynapseNetsAppHomepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SynapseNets'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Image.network(
                '',
                height: 300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    ElevatedButton(
                      onPressed: switchToLoginPage, 
                    child: const Text('CONTINUA'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void switchToLoginPage(){
    
  }



}

