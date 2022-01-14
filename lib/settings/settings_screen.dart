import 'package:app/auth/bloc/authentication_bloc.dart';
import 'package:app/auth/user.dart';
import 'package:app/repositories/network_config/network_config_repository.dart';
import 'package:easy_localization/easy_localization.dart';
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
            Header(headerTitle: tr('user_information')),
            const UserInfoSection(),
            const Header(headerTitle: "Network configuration"),
            const Expanded(
              child: NetworkConfigurationLine(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: FullWidthButton(
                label: tr('logout'),
                onPressed: () => _onLogoutClicked(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkConfigurationLine extends StatelessWidget {
  const NetworkConfigurationLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: RepositoryProvider.of<NetworkConfigRepository>(context)
          .getIpAndPort(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Align(
            alignment: Alignment.topCenter,
            child: UserInfoRow(
              label: "IP Address",
              value:
                  "${snapshot.data?["ip"] ?? "xxxx"} : ${snapshot.data?["port"] ?? "xx"}",
            ),
          ),
        );
      },
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
          UserInfoRow(
            label: tr('first_name'),
            value: userInfo.firstName,
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          UserInfoRow(
            label: tr('email'),
            value: userInfo.email,
          ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}
