import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/widgets/pim_controller.dart';
import 'package:companion/src/features/companies_to_contact/models/comp_to_conc_model.dart';
import 'package:companion/src/features/companies_to_contact/repositories/company_to_contact_repository.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/basic_details_section.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/companies_select_section.dart';
import 'package:companion/src/features/contacts/pages/contacts/new/sections/create_pim_section.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/pims/models/pim_model.dart';
import 'package:companion/src/features/pims/repositories/pim_repository.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewContactPage extends ConsumerStatefulWidget {
  const NewContactPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewContactPageState();
}

class _NewContactPageState extends ConsumerState<NewContactPage> {
  late final GlobalKey<FormBuilderState> _formKey;

  late final TextEditingController _nameController;
  late final TextEditingController _distributorController;

  late final List<PimController> _pimControllers;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();

    _nameController = TextEditingController();
    _distributorController = TextEditingController();

    _pimControllers = [
      PimController(
        text: "",
        id: uuid(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        ref.invalidate(multiSelectCompanyNotifier);
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
      title: 'New Contact'.text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            await _saveContact().then((val) {
              if (mounted) {
                context.maybePop();
              }
            });
          },
          child: Text(
            "Save",
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
                autoFocus: true,
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
                  _pimControllers.add(
                    PimController(
                      text: "",
                      id: uuid(),
                    ),
                  );
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
                  // textStyle: context.textTheme.titleMedium
                  //     ?.copyWith(color: context.colors.onSecondary)),
                ),
                onPressed: () async {
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
    final contactPod = ref.read(contactPodProvider.notifier);

    final contact = ContactModel(
      id: uuid(),
      name: _nameController.text.trim(),
      distributor: _distributorController.text.trim().isEmpty
          ? "None"
          : _distributorController.text.trim(),
      created: DateTime.now().toString(),
      hexColor: Vx.randomColor.toHex(leadingHashSign: true),
    );

    await contactPod.insertContact(contact);

    final pims = _pimControllers.builder(
      (cntrl) => PimModel(
        id: cntrl.id,
        digits: cntrl.digits,
        created: cntrl.created?.toString() ?? DateTime.now().toString(),
        contactId: contact.id,
      ),
    );

    final pimRepo = ref.read(pimRepositoryProvider);

    for (var pim in pims) {
      await pimRepo.create(pim);
    }

    final selectedCompanyIds = ref.read(multiSelectCompanyNotifier);
    if (selectedCompanyIds.isEmpty) {
      return;
    }

    final companyToContactRepo = ref.read(companyToContactRepositoryProvider);

    await Future.wait(
      selectedCompanyIds.builder(
        (cmpId) async {
          await companyToContactRepo.create(
            CompanyToContactModel(
              id: uuid(),
              companyId: cmpId,
              contactId: contact.id,
            ),
          );
        },
      ),
    );
  }
}
