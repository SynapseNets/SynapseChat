import 'package:flutter/material.dart';

class Creditspage extends StatefulWidget {
  const Creditspage({super.key});

  @override
  State<Creditspage> createState() => _CreditspageState();
}

class _CreditspageState extends State<Creditspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Credits",
              style: TextStyle(
                  color: Color(0xff3b28cc),
                  fontSize: 60,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/developerscredits');
              },
              child: Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff3b28cc),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Developers credits',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/iconscredits');
              },
              child: Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff3b28cc),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Icons credits',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
