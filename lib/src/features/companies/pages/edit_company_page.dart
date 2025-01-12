import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class EditCompanyPage extends ConsumerStatefulWidget {
  final CompanyModel company;
  const EditCompanyPage({super.key, required this.company});

  @override
  ConsumerState<EditCompanyPage> createState() => _EditCompanyPageState();
}

class _EditCompanyPageState extends ConsumerState<EditCompanyPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  bool isSubmitDisabled = true;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
  }

  Future<bool> updateCompany() async {
    _formKey.currentState!.saveAndValidate();

    final values = _formKey.currentState!.value;

    await ref.read(companyPodProvider.notifier).patch(
          widget.company.copyWith(
              name: values["name"], description: values['description']),
        );
    return true;
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
      title: "Edit Company".text.make(),
      actions: [
        FilledButton(
          onPressed: !isSubmitDisabled
              ? () async {
                  if (await updateCompany() && mounted) {
                    await context.maybePop(true);
                  }
                }
              : null,
          child: "Update".text.make(),
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return VStack(
      [
        12.h.heightBox,
        FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            if (_formKey.currentState!.isValid) {
              setState(() {
                isSubmitDisabled = false;
              });
            } else {
              setState(() {
                isSubmitDisabled = true;
              });
            }
          },
          key: _formKey,
          child: VStack(
            [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.company.name,
                decoration: getDecoration(hint: 'Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                  FormBuilderValidators.maxLength(30),
                ]),
              ),
              12.h.heightBox,
              FormBuilderTextField(
                name: "description",
                initialValue: widget.company.description,
                decoration: getDecoration(hint: "Description"),
                maxLines: 5,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2)
                ]),
              )
            ],
          ).pSymmetric(h: 16.w),
        ),
      ],
    );
  }
}
