import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/settings/models/settings_model.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<SettingsModel>(),
  AdapterSpec<ContactModel>(),
  AdapterSpec<PimModel>(),
  AdapterSpec<CompanyModel>(),
  AdapterSpec<CompanyToContactModel>(),
])
//ignore: unused_element
void _() {}
