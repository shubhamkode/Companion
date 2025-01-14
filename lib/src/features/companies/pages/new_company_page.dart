import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewCompanyPage extends ConsumerStatefulWidget {
  const NewCompanyPage({super.key});

  @override
  ConsumerState<NewCompanyPage> createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends ConsumerState<NewCompanyPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  bool isSubmitDisabled = true;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
  }

  Future<bool> createNewCompany() async {
    _formKey.currentState!.saveAndValidate();

    final values = _formKey.currentState!.value;

    await ref.read(companyPodProvider.notifier).create(
          name: values['name'],
          description: values["description"],
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
      title: "New Company".text.make(),
      actions: [
        FilledButton(
          onPressed: !isSubmitDisabled
              ? () async {
                  if (await createNewCompany() && mounted) {
                    context.back();
                  }
                }
              : null,
          child: "Save".text.make(),
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
                decoration: getDecoration(hint: 'Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.words,
                autofocus: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                ]),
              ),
              12.h.heightBox,
              FormBuilderTextField(
                name: "description",
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
