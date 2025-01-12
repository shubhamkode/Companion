import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/widgets/pim_controller.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/basic_details_section.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/companies_select_section.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/create_pim_section.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/hive/hive_pod.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class EditContactPage extends ConsumerStatefulWidget {
  final ContactModel contact;
  final List<PimModel> contactPims;
  final List<CompanyToContactModel> relations;

  const EditContactPage({
    super.key,
    required this.contact,
    required this.contactPims,
    required this.relations,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditContactPageState();
}

class _EditContactPageState extends ConsumerState<EditContactPage> {
  late final GlobalKey<FormBuilderState> _formKey;

  late final TextEditingController _nameController;
  late final TextEditingController _distributorController;

  late List<PimController> _pimControllers;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();

    _nameController = TextEditingController(text: widget.contact.name);
    _distributorController =
        TextEditingController(text: widget.contact.distributor);
    _pimControllers = widget.contactPims.builder(
      (pim) => PimController(
        id: pim.id,
        text: pim.digits,
        created: pim.created,
      ),
    );
    // assignCompanies();
  }

  // void assignCompanies() {
  //   ref.watch(multiSelectCompanyNotifier.notifier).setSelectedCompanies(
  //         widget.relations.builder((rel) => rel.companyId),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.invalidate(multiSelectCompanyNotifier);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: 'Edit Contact'.text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            await _saveContact();
            if (mounted) {
              await context.maybePop(true);
            }
          },
          child: Text(
            "Update",
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return FormBuilder(
      key: _formKey,
      child: VStack(
        [
          VStack(
            [
              "Basic Details".text.labelSmall(context).make(),
              BasicDetailsSection(
                nameController: _nameController,
                distributorController: _distributorController,
              ),
            ],
            spacing: 12.h,
          ),
          VStack(
            [
              "Contact Details".text.labelSmall(context).make(),
              CreatePimSection(
                controllers: _pimControllers,
                onControllerRemove: _pimControllers.length > 1
                    ? (controllerId) {
                        setState(() {
                          _pimControllers.removeWhere(
                              (element) => element.id == controllerId);
                        });
                      }
                    : null,
              ),
              "Add Phone"
                  .text
                  .color(context.colors.primary)
                  .fontWeight(FontWeight.w600)
                  .make()
                  .pOnly(left: 4.w)
                  .objectCenterLeft()
                  .onTap(() {
                setState(() {
                  _pimControllers = [
                    PimController(id: uuid(), text: ""),
                    ..._pimControllers
                  ];
                });
              }),
            ],
            spacing: 12.h,
          ),
          VStack(
            [
              "Select Companies".text.labelSmall(context).make(),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  backgroundColor: context.colors.secondaryContainer,
                  foregroundColor: context.colors.onSecondaryContainer,
                ),
                onPressed: () async {
                  // assignCompanies();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return FullScreenCompanySelector();
                      },
                    ),
                  );
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final companiesSelected = ref.watch(
                        multiSelectCompanyNotifier
                            .select((notifier) => notifier.length));
                    return "Companies Selected: $companiesSelected"
                        .text
                        .size(12.sp)
                        .make();
                  },
                ),
              ),
            ],
            spacing: 12.h,
          )
        ],
        spacing: 16.h,
      ).pSymmetric(h: 16.w, v: 12.h),
    );
  }

  Future<void> _saveContact() async {
    final collection = ref.read(hivePodProvider);

    final pims = _pimControllers.builder(
      (cntrl) => PimModel(
        id: cntrl.id,
        digits: cntrl.digits,
        created: cntrl.created ?? DateTime.now().toString(),
        contactId: widget.contact.id,
      ),
    );

    await collection.transaction(
      () async {
        (await collection.openBox<ContactModel>('contacts')).put(
            widget.contact.id,
            widget.contact.copyWith(
              name: _nameController.text,
              distributor: _distributorController.text,
            ));

        final pimBox = await collection.openBox<PimModel>('pims');

        await pimBox.deleteAll(widget.contactPims.builder((pim) => pim.id));

        for (var pim in pims) {
          await pimBox.put(pim.id, pim);
        }

        final relationBox = await collection
            .openBox<CompanyToContactModel>('company_to_contact');

        await relationBox
            .deleteAll((widget.relations).builder((rel) => rel.id));

        for (var cmpId in (ref.read(multiSelectCompanyNotifier))) {
          final relation = CompanyToContactModel(
            id: uuid(),
            companyId: cmpId,
            contactId: widget.contact.id,
          );
          await relationBox.put(relation.id, relation);
        }
      },
      boxNames: [
        'contacts',
        'pims',
        'company_to_contact',
      ],
    );
    ref.invalidate(multiSelectCompanyNotifier);
    ref.invalidate(contactPodProvider);
  }
}
