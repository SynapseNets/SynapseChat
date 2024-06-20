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
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', width: 256, height: 256,),
              const Text(
                'Welcome to SynapseChat',
                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                 ),
              const SizedBox(height: 10),
              const Text(
                'The most secure messaging service available.'
              ),
              const SizedBox(height: 200),
              SizedBox(
                height: 75,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                  child: const Text(
                    'Continue',
                     style: TextStyle(fontSize: 20)
                     ),
                  ),
                ),
            ],
        ),
      ),
    );
  }

  void switchToLoginPage(){
    
  }



}

