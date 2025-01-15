import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:companion/src/utils/input_decoration.dart';
import 'package:companion/src/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewCompanyPage extends StatefulWidget {
  const NewCompanyPage({super.key});

  @override
  State<NewCompanyPage> createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends State<NewCompanyPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  late final GlobalKey<FormBuilderState> _formKey;

  Future<bool> saveCompany(WidgetRef ref) async {
    await ref.read(companyPodProvider.notifier).create(
          CompanyModel(
            id: uuid(),
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            hexColor: Vx.randomPrimaryColor.toHex(leadingHashSign: true),
          ),
        );
    return true;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormBuilderState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
      title: "New Company".text.make(),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    await saveCompany(ref)) {
                  context
                    ..mounted
                    ..maybePop();
                }
              },
              child: "Save".text.size(12.sp).make(),
            );
          },
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return VStack([
      FormBuilder(
        key: _formKey,
        child: CompanyForm(
          nameController: _nameController,
          descriptionController: _descriptionController,
        ),
      ),
    ]).pSymmetric(h: 12.h, v: 16.w);
  }
}

class CompanyForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  const CompanyForm({
    super.key,
    required this.nameController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        FormBuilderTextField(
          name: "name",
          decoration: getDecoration(hint: 'Name'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofocus: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(2),
          ]),
        ),
        FormBuilderTextField(
          name: "description",
          decoration: getDecoration(hint: 'Description'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: descriptionController,
          maxLines: 5,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(2),
          ]),
        ),
      ],
      spacing: 12.h,
    );
  }
}
