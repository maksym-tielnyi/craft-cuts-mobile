import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MasterTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: bool,
      onChanged: (value) {},
      groupValue: true,
      title: SafeArea(
        child: Card(
          color: Color(0xFFE5E5E5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://derby.com.ua/img/team/1.jpg'),
            ),
            title: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Женя',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Card(
                  shape: const StadiumBorder(),
                  elevation: 0,
                  child: SizedBox(
                    width: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        verticalDirection: VerticalDirection.up,
                        children: List.generate(
                          5,
                          (index) => Expanded(
                            child: SvgPicture.asset(
                              'assets/icons/flame.svg',
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Text(
              'Стрижка, борода',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
