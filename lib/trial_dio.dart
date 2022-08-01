import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter_login/data_api.dart';
import 'package:learn_flutter_login/data_card.dart';
import 'package:learn_flutter_login/dio_services.dart';

class TrialDio extends StatefulWidget {
  const TrialDio({Key? key}) : super(key: key);

  @override
  State<TrialDio> createState() => _TrialDioState();
}

class _TrialDioState extends State<TrialDio> {
  DataApi? dataApi;
  final emailInput = TextEditingController();
  final nameInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Trial Rest API'),
      ),
      body: Center(
        child: Column(
          children: [
            dataApi != null ?
            DataCard(dataApi: dataApi!) : const Text("no data"),
            SizedBox(height: 20, child: ElevatedButton(onPressed: (
            ) async {
              DataApi? res = await DioService.getById(1);
              if(res != null){
                setState(() {
                  dataApi = res;
                });
              }
            }, child: Text("Get"),)),
            SizedBox(height: 20, child: ElevatedButton(onPressed: () async {
              DataApi? result = await DioService.creteUser(nameInput.text.split(" ")[0], nameInput.text.split(" ").reversed.toList().removeLast().toString(), emailInput.text);

              if(result != null){
                setState(() {
                  dataApi = result;
                });
              }
            }, child: Text("Post"),)),
            TextFormField(
              controller: emailInput,
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: nameInput,
              keyboardType: TextInputType.text,
            )

            
          ],
        ),
      )
    );
  }
}