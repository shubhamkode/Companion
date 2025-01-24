import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:companion/src/features/company/presentation/widgets/company_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewCompanyView extends StatefulWidget {
  const NewCompanyView({super.key});

  @override
  State<NewCompanyView> createState() => _NewCompanyViewState();
}

class _NewCompanyViewState extends State<NewCompanyView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
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
        Consumer(builder: (context, ref, child) {
          return FilledButton(
            onPressed: () async {
              //Todo- Add form validation
              if (_formKey.currentState!.validate() &&
                  await createCompany(ref) &&
                  context.mounted) {
                context.maybePop();
              }
            },
            child: "Save".text.make(),
          );
        }),
        16.w.widthBox,
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: CompanyForm(
        formKey: _formKey,
        nameController: _nameController,
        descriptionController: _descriptionController,
      ),
    );
  }

  Future<bool> createCompany(WidgetRef ref) async {
    await ref
        .read(companyNotifierProvider.notifier)
        .createCompany(NewCompanyParams(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
        ));

    return true;
  }
}
