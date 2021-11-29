import 'package:app/auth/bloc/authentication_bloc.dart';
import 'package:app/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/authentication_repository.dart';
import '../../widgets/full_width_button.dart';
import '../../widgets/header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _onLogoutClicked(BuildContext context) {
    RepositoryProvider.of<AuthenticationRepository>(context).logOut();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(headerTitle: "User information"),
            const Expanded(
              child: UserInfoSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: FullWidthButton(
                label: "Logout",
                onPressed: () => _onLogoutClicked(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userInfo =
        context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Name"),
              Text(userInfo.firstName),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Last Name"),
              Text(userInfo.lastName),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Email"),
              Text(userInfo.email),
            ],
          )
        ],
      ),
    );
  }
}
