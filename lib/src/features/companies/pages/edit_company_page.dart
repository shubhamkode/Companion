import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/models/company_model.dart';
import 'package:companion/src/features/companies/pages/new_company_page.dart';
import 'package:companion/src/features/companies/pods/company_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class EditCompanyPage extends StatefulWidget {
  final CompanyModel company;
  const EditCompanyPage({super.key, required this.company});

  @override
  State<EditCompanyPage> createState() => _EditCompanyPageState();
}

class _EditCompanyPageState extends State<EditCompanyPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  late final GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.company.name,
    );
    _descriptionController = TextEditingController(
      text: widget.company.description,
    );
    _formKey = GlobalKey<FormBuilderState>();
  }

  Future<bool> saveCompany(WidgetRef ref) async {
    await ref.read(companyPodProvider.notifier).patch(
          widget.company.copyWith(
            name: _nameController.text,
            description: _descriptionController.text,
          ),
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
        Consumer(
          builder: (context, ref, child) {
            return FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    await saveCompany(ref)) {
                  context
                    ..mounted
                    ..maybePop(true);
                }
              },
              child: "Update".text.make(),
            );
          },
        ),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return VStack(
      [
        FormBuilder(
          key: _formKey,
          child: CompanyForm(
            nameController: _nameController,
            descriptionController: _descriptionController,
          ),
        ),
      ],
    ).pSymmetric(h: 12.h, v: 16.w);
  }
}
