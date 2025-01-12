import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:faker/faker.dart';
import 'package:velocity_x/velocity_x.dart';

final dummyCompanies = getDummyCompanies(5);

final companyIds = dummyCompanies.builder((cmp) => cmp.id);

final dummyContacts = getDummyContacts(5);

final contactIds = dummyContacts.builder((cnt) => cnt.id)..shuffle();

final dummyCompanyToContact = getDummyCompanyToContact(5);

final dummyPims = getDummyPims();

List<CompanyModel> getDummyCompanies([int length = 5]) {
  return List.generate(
    length,
    (index) {
      return CompanyModel(
        id: uuid(),
        name: faker.company.name(),
        description: faker.lorem.sentence(),
        hexColor:
            Vx.getMaterialColor(Vx.randomColor).toHex(leadingHashSign: true),
      );
    },
  );
}

List<ContactModel> getDummyContacts([int length = 5]) {
  return List.generate(5, (index) {
    return ContactModel(
      id: uuid(),
      name: faker.person.name(),
      distributor: faker.address.city(),
      created: DateTime.now().toString(),
      hexColor:
          Vx.getMaterialColor(Vx.randomColor).toHex(leadingHashSign: true),
    );
  });
}

List<CompanyToContactModel> getDummyCompanyToContact([int length = 5]) {
  return List.generate(
    length,
    (index) {
      return CompanyToContactModel(
        id: uuid(),
        companyId: companyIds[index],
        contactId: contactIds[index],
      );
    },
  );
}

List<PimModel> getDummyPims([int length = 10]) {
  return List.generate(
    length,
    (index) {
      return PimModel(
        id: uuid(),
        digits: faker.phoneNumber.us(),
        contactId: contactIds[(index / 2).toInt()],
        created: faker.date.dateTime().toString(),
      );
    },
  );
}
