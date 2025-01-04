import 'package:auto_route/auto_route.dart';
import 'package:companion/src/core/routes/router.dart';
import 'package:companion/src/features/companies/models/company.dart';
import 'package:companion/src/features/contacts/models/contact_model.dart';
import 'package:companion/src/features/contacts/pods/contact_pod.dart';
import 'package:companion/src/features/contacts/widgets/company_selector.dart';
import 'package:cuid2/cuid2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewContactPage extends ConsumerStatefulWidget {
  const NewContactPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewContactPageState();
}

class _NewContactPageState extends ConsumerState<NewContactPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _distributorController;
  late final MultiSelectController<Company> _selectedCompaniesController;
  final List<TextEditingController> pimControllers = [];

  late final GlobalKey<FormState> _formKey;

  bool isSubmitDisabled = true;

  Future<bool> _saveContact() async {
    if (pimControllers.last.text.isEmpty) {
      pimControllers.removeLast();
    }

    if (!_formKey.currentState!.validate()) {
      return false;
    }

    await ref.read(contactPodProvider.notifier).addContact(
          name: _nameController.text,
          distributorName: _distributorController.text,
          pims: pimControllers
              .map(
                (pimC) => Pim(
                  id: cuid(),
                  contact: pimC.text,
                ),
              )
              .toList(),
          companies: _selectedCompaniesController.selectedItems
              .builder((drpdown) => drpdown.value),
        );

    return true;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _distributorController = TextEditingController();
    _selectedCompaniesController = MultiSelectController();
    pimControllers.add(TextEditingController());

    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    pimControllers.map((e) => e.dispose());
    _nameController.dispose();
    _distributorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: "New Contact".text.make(),
      actions: [
        FilledButton(
          onPressed: () async {
            if (await _saveContact() && mounted) {
              context.back();
            }
          },
          child: "Save".text.make(),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            16.h.heightBox,
            "Basic Details".text.labelSmall(context).make(),
            12.heightBox,
            CompanionTextField(
              hint: "Name",
              textInputAction: TextInputAction.next,
              controller: _nameController,
              validator: (str) {
                if (str!.isEmpty || str.length < 2) {
                  return "Name cannot be empty";
                }
                return null;
              },
            ),
            12.heightBox,
            CompanionTextField(
              textInputAction: TextInputAction.next,
              hint: "Distributor Name",
              controller: _distributorController,
              validator: (str) {
                if (str!.isEmpty || str.length < 2) {
                  return "Distributor name cannot be empty";
                }
                return null;
              },
            ),
            30.heightBox,
            "Contact Details".text.labelSmall(context).make(),
            12.heightBox,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pimControllers.length,
              itemBuilder: (context, index) {
                return CompanionTextField(
                  textInputAction: TextInputAction.done,
                  hint: "Contact",
                  controller: pimControllers[index],
                  onFieldSubmitted: (val) {
                    if (val!.isEmpty) {
                      return;
                    }
                    setState(() {
                      pimControllers.add(
                        TextEditingController(),
                      );
                    });
                  },
                  validator: (str) {
                    if (str!.isEmpty || str.length != 10) {
                      return "Phone number should be 10 digits";
                    }

                    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                    RegExp regExp = RegExp(pattern);

                    if (!regExp.hasMatch(str)) {
                      return "Invalid Phone number";
                    }

                    return null;
                  },
                );
              },
              separatorBuilder: (_, __) => 12.heightBox,
            ),
            30.heightBox,
            "Add Companies".text.labelSmall(context).make(),
            12.heightBox,
            HStack(
              [
                CompanySelector(
                  controller: _selectedCompaniesController,
                ).expand(),
                8.w.widthBox,
                IconButton.outlined(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  onPressed: () async {
                    await context.pushRoute(NewCompanyRoute());
                  },
                  icon: Icon(
                    Icons.add_outlined,
                    size: 18.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ).pSymmetric(h: 16.w),
    );
  }
}

class CompanionTextField extends ConsumerWidget {
  const CompanionTextField({
    super.key,
    this.controller,
    this.textInputAction,
    this.hint,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hint;
  final String? Function(String?)? validator;
  final Null Function(String? val)? onFieldSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 12.w,
        ),
        hintText: hint,
      ),
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
    );
  }
}
