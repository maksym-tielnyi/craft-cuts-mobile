import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:craft_cuts_mobile/profile/presentation/widgets/appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: maybe we should move this value to the default theme, idk.
    const secondaryColor = Colors.brown;
    final authNotifier = Provider.of<AuthNotifier>(context);

    final elevatedButtonStyle = Theme.of(context).elevatedButtonTheme.style;
    final elevatedButtonMinSize =
        elevatedButtonStyle?.minimumSize?.resolve(MaterialState.values.toSet());
    final logOutButtonMinSize = Size(0, elevatedButtonMinSize?.height ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(CommonStrings.profile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  authNotifier.currentUser?.name ?? '',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: elevatedButtonStyle?.copyWith(
                    minimumSize: MaterialStateProperty.all(logOutButtonMinSize),
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                  ),
                  child: Text(
                    CommonStrings.logOut,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              CommonStrings.yourAppointments,
              style: Theme.of(context).textTheme.headline3,
            ),
            const Expanded(
              child: AppointmentsWidget(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text(CommonStrings.makeAnAppointment),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: elevatedButtonStyle?.copyWith(
                backgroundColor: MaterialStateProperty.all(secondaryColor),
              ),
              child: Text(CommonStrings.onlineBooking),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
