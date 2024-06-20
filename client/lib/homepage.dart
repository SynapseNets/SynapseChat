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
                'https://static.vecteezy.com/system/resources/previews/023/986/631/original/whatsapp-logo-whatsapp-logo-transparent-whatsapp-icon-transparent-free-free-png.png',
                height: 300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
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

