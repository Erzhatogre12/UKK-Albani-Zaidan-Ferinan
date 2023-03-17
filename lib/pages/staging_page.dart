

import 'package:flutter/material.dart';


class StagingPage extends StatefulWidget {
  const StagingPage({Key? key}) : super(key: key);

  @override
  State<StagingPage> createState() => _StagingPageState();
}

class _StagingPageState extends State<StagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: 
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Selamat Datang \ndi Pengaduan \nKota Bogor', 
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text('Aplikasi Ini dibuat \nuntuk menampung semua \nlaporan anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    
                  ),),
                  const Text('Silahkan'),
                  ElevatedButton(onPressed: (){}, child: const Text('Login'),),
                  const Text('Atau'),
                  ElevatedButton(onPressed: (){}, child: const Text('Register'),),
                ],
              ),
            ],
          ),
        )
      ],),),
    );
  }
}