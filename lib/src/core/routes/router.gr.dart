// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CompaniesPage]
class CompaniesRoute extends PageRouteInfo<void> {
  const CompaniesRoute({List<PageRouteInfo>? children})
      : super(
          CompaniesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompaniesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CompaniesPage();
    },
  );
}

/// generated route for
/// [CompanyDetailsPage]
class CompanyDetailsRoute extends PageRouteInfo<CompanyDetailsRouteArgs> {
  CompanyDetailsRoute({
    Key? key,
    required Company company,
    List<PageRouteInfo>? children,
  }) : super(
          CompanyDetailsRoute.name,
          args: CompanyDetailsRouteArgs(
            key: key,
            company: company,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyDetailsRouteArgs>();
      return CompanyDetailsPage(
        key: args.key,
        company: args.company,
      );
    },
  );
}

class CompanyDetailsRouteArgs {
  const CompanyDetailsRouteArgs({
    this.key,
    required this.company,
  });

  final Key? key;

  final Company company;

  @override
  String toString() {
    return 'CompanyDetailsRouteArgs{key: $key, company: $company}';
  }
}

/// generated route for
/// [ContactDetailsPage]
class ContactDetailsRoute extends PageRouteInfo<ContactDetailsRouteArgs> {
  ContactDetailsRoute({
    Key? key,
    required Contact contact,
    List<PageRouteInfo>? children,
  }) : super(
          ContactDetailsRoute.name,
          args: ContactDetailsRouteArgs(
            key: key,
            contact: contact,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContactDetailsRouteArgs>();
      return ContactDetailsPage(
        key: args.key,
        contact: args.contact,
      );
    },
  );
}

class ContactDetailsRouteArgs {
  const ContactDetailsRouteArgs({
    this.key,
    required this.contact,
  });

  final Key? key;

  final Contact contact;

  @override
  String toString() {
    return 'ContactDetailsRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [ContactsPage]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute({List<PageRouteInfo>? children})
      : super(
          ContactsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactsPage();
    },
  );
}

/// generated route for
/// [HomePage]
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
      return const HomePage();
    },
  );
}

/// generated route for
/// [NewCompanyPage]
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
      return const NewCompanyPage();
    },
  );
}

/// generated route for
/// [NewContactPage]
class NewContactRoute extends PageRouteInfo<void> {
  const NewContactRoute({List<PageRouteInfo>? children})
      : super(
          NewContactRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewContactPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}
