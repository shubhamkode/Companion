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
    required String companyId,
    List<PageRouteInfo>? children,
  }) : super(
          CompanyDetailsRoute.name,
          args: CompanyDetailsRouteArgs(
            key: key,
            companyId: companyId,
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
        companyId: args.companyId,
      );
    },
  );
}

class CompanyDetailsRouteArgs {
  const CompanyDetailsRouteArgs({
    this.key,
    required this.companyId,
  });

  final Key? key;

  final String companyId;

  @override
  String toString() {
    return 'CompanyDetailsRouteArgs{key: $key, companyId: $companyId}';
  }
}

/// generated route for
/// [ContactDetailsPage]
class ContactDetailsRoute extends PageRouteInfo<ContactDetailsRouteArgs> {
  ContactDetailsRoute({
    Key? key,
    required String contactId,
    List<PageRouteInfo>? children,
  }) : super(
          ContactDetailsRoute.name,
          args: ContactDetailsRouteArgs(
            key: key,
            contactId: contactId,
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
        contactId: args.contactId,
      );
    },
  );
}

class ContactDetailsRouteArgs {
  const ContactDetailsRouteArgs({
    this.key,
    required this.contactId,
  });

  final Key? key;

  final String contactId;

  @override
  String toString() {
    return 'ContactDetailsRouteArgs{key: $key, contactId: $contactId}';
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
/// [EditCompanyPage]
class EditCompanyRoute extends PageRouteInfo<EditCompanyRouteArgs> {
  EditCompanyRoute({
    Key? key,
    required CompanyModel company,
    List<PageRouteInfo>? children,
  }) : super(
          EditCompanyRoute.name,
          args: EditCompanyRouteArgs(
            key: key,
            company: company,
          ),
          initialChildren: children,
        );

  static const String name = 'EditCompanyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditCompanyRouteArgs>();
      return EditCompanyPage(
        key: args.key,
        company: args.company,
      );
    },
  );
}

class EditCompanyRouteArgs {
  const EditCompanyRouteArgs({
    this.key,
    required this.company,
  });

  final Key? key;

  final CompanyModel company;

  @override
  String toString() {
    return 'EditCompanyRouteArgs{key: $key, company: $company}';
  }
}

/// generated route for
/// [EditContactPage]
class EditContactRoute extends PageRouteInfo<EditContactRouteArgs> {
  EditContactRoute({
    Key? key,
    required ContactModel contact,
    required List<PimModel> contactPims,
    required List<CompanyToContactModel> relations,
    List<PageRouteInfo>? children,
  }) : super(
          EditContactRoute.name,
          args: EditContactRouteArgs(
            key: key,
            contact: contact,
            contactPims: contactPims,
            relations: relations,
          ),
          initialChildren: children,
        );

  static const String name = 'EditContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditContactRouteArgs>();
      return EditContactPage(
        key: args.key,
        contact: args.contact,
        contactPims: args.contactPims,
        relations: args.relations,
      );
    },
  );
}

class EditContactRouteArgs {
  const EditContactRouteArgs({
    this.key,
    required this.contact,
    required this.contactPims,
    required this.relations,
  });

  final Key? key;

  final ContactModel contact;

  final List<PimModel> contactPims;

  final List<CompanyToContactModel> relations;

  @override
  String toString() {
    return 'EditContactRouteArgs{key: $key, contact: $contact, contactPims: $contactPims, relations: $relations}';
  }
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
/// [SettingsPage]
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
      return const SettingsPage();
    },
  );
}
