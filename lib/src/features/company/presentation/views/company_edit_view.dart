import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/company/domain/entity/company_entity.dart';
import 'package:companion/src/features/company/domain/usecases/company_usecase.dart';
import 'package:companion/src/features/company/presentation/notifiers/company_notifier.dart';
import 'package:companion/src/features/company/presentation/widgets/company_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CompanyEditView extends ConsumerStatefulWidget {
  final CompanyEntity company;
  const CompanyEditView({super.key, required this.company});

  @override
  ConsumerState<CompanyEditView> createState() => _CompanyEditViewState();
}

class _CompanyEditViewState extends ConsumerState<CompanyEditView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.company.name;
    _descriptionController.text = widget.company.description;
    super.initState();
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
      title: "Edit Company".text.make(),
      actions: [
        Consumer(builder: (context, ref, child) {
          return FilledButton(
            onPressed: () async {
              //Todo- Add form validation
              setState(() {});

              if (_formKey.currentState!.validate() &&
                  await _updateCompany(ref)) {
                if (context.mounted) {
                  context.maybePop();
                }
              }
            },
            child: "Update".text.make(),
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

  Future<bool> _updateCompany(WidgetRef ref) async {
    await ref.read(companyNotifierProvider.notifier).updateCompany(
          UpdateCompanyParams(
            id: widget.company.id,
            name: _nameController.text,
            description: _descriptionController.text,
          ),
        );
    return true;
  }
}
