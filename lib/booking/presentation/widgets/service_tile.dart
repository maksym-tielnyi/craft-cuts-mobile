import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: RadioListTile(
        value: true,
        groupValue: true,
        onChanged: (value) {},
        title: Text(
          'Стрижка под 0',
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          'От 300грн. 30 минут',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
