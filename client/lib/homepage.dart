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
        centerTitle: true,
        title: const Text('SynapseChat'),
        backgroundColor: const Color(0xff00008b),
        actions: [
          IconButton(
            onPressed: () => print('Hello'),
            icon: const Icon(Icons.info),
            
            ),
          IconButton(
            onPressed: () => print('Hello'),
             icon: const Icon(Icons.settings)
             )
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('images/logo.png'),
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
    );
  }

  void switchToLoginPage(){
    
  }



}

