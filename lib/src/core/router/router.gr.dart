// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AgentDetailsView]
class AgentDetailsRoute extends PageRouteInfo<void> {
  const AgentDetailsRoute({List<PageRouteInfo>? children})
      : super(
          AgentDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AgentDetailsView();
    },
  );
}

/// generated route for
/// [AgentEditView]
class AgentEditRoute extends PageRouteInfo<AgentEditRouteArgs> {
  AgentEditRoute({
    Key? key,
    required AgentEntity agent,
    List<PageRouteInfo>? children,
  }) : super(
          AgentEditRoute.name,
          args: AgentEditRouteArgs(
            key: key,
            agent: agent,
          ),
          initialChildren: children,
        );

  static const String name = 'AgentEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgentEditRouteArgs>();
      return AgentEditView(
        key: args.key,
        agent: args.agent,
      );
    },
  );
}

class AgentEditRouteArgs {
  const AgentEditRouteArgs({
    this.key,
    required this.agent,
  });

  final Key? key;

  final AgentEntity agent;

  @override
  String toString() {
    return 'AgentEditRouteArgs{key: $key, agent: $agent}';
  }
}

/// generated route for
/// [AgentsView]
class AgentsRoute extends PageRouteInfo<void> {
  const AgentsRoute({List<PageRouteInfo>? children})
      : super(
          AgentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AgentsView();
    },
  );
}

/// generated route for
/// [CompanyDetailsView]
class CompanyDetailsRoute extends PageRouteInfo<void> {
  const CompanyDetailsRoute({List<PageRouteInfo>? children})
      : super(
          CompanyDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompanyDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CompanyDetailsView();
    },
  );
}

/// generated route for
/// [CompanyEditView]
class CompanyEditRoute extends PageRouteInfo<CompanyEditRouteArgs> {
  CompanyEditRoute({
    Key? key,
    required CompanyEntity company,
    List<PageRouteInfo>? children,
  }) : super(
          CompanyEditRoute.name,
          args: CompanyEditRouteArgs(
            key: key,
            company: company,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyEditRouteArgs>();
      return CompanyEditView(
        key: args.key,
        company: args.company,
      );
    },
  );
}

class CompanyEditRouteArgs {
  const CompanyEditRouteArgs({
    this.key,
    required this.company,
  });

  final Key? key;

  final CompanyEntity company;

  @override
  String toString() {
    return 'CompanyEditRouteArgs{key: $key, company: $company}';
  }
}

/// generated route for
/// [CompanyToAgentView]
class CompanyToAgentRoute extends PageRouteInfo<void> {
  const CompanyToAgentRoute({List<PageRouteInfo>? children})
      : super(
          CompanyToAgentRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompanyToAgentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CompanyToAgentView();
    },
  );
}

/// generated route for
/// [CompanyView]
class CompanyRoute extends PageRouteInfo<void> {
  const CompanyRoute({List<PageRouteInfo>? children})
      : super(
          CompanyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompanyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CompanyView();
    },
  );
}

/// generated route for
/// [HisabKitabView]
class HisabKitabRoute extends PageRouteInfo<void> {
  const HisabKitabRoute({List<PageRouteInfo>? children})
      : super(
          HisabKitabRoute.name,
          initialChildren: children,
        );

  static const String name = 'HisabKitabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HisabKitabView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [NewAgentView]
class NewAgentRoute extends PageRouteInfo<void> {
  const NewAgentRoute({List<PageRouteInfo>? children})
      : super(
          NewAgentRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewAgentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewAgentView();
    },
  );
}

/// generated route for
/// [NewCompanyView]
class NewCompanyRoute extends PageRouteInfo<void> {
  const NewCompanyRoute({List<PageRouteInfo>? children})
      : super(
          NewCompanyRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewCompanyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewCompanyView();
    },
  );
}

/// generated route for
/// [PartyView]
class PartyRoute extends PageRouteInfo<PartyRouteArgs> {
  PartyRoute({
    Key? key,
    required String partyId,
    List<PageRouteInfo>? children,
  }) : super(
          PartyRoute.name,
          args: PartyRouteArgs(
            key: key,
            partyId: partyId,
          ),
          initialChildren: children,
        );

  static const String name = 'PartyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyRouteArgs>();
      return PartyView(
        key: args.key,
        partyId: args.partyId,
      );
    },
  );
}

class PartyRouteArgs {
  const PartyRouteArgs({
    this.key,
    required this.partyId,
  });

  final Key? key;

  final String partyId;

  @override
  String toString() {
    return 'PartyRouteArgs{key: $key, partyId: $partyId}';
  }
}

/// generated route for
/// [SearchView]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchView();
    },
  );
}

/// generated route for
/// [SettingsView]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsView();
    },
  );
}
