import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PartyView extends StatelessWidget {
  final String partyId;
  const PartyView({
    super.key,
    required this.partyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar();
  }

  _buildBody(BuildContext context) {
    return Placeholder();
  }
}
