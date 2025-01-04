import 'package:auto_route/auto_route.dart';
import 'package:companion/src/features/companies/pods/companies_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class NewCompanyPage extends ConsumerStatefulWidget {
  const NewCompanyPage({super.key});

  @override
  ConsumerState<NewCompanyPage> createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends ConsumerState<NewCompanyPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final GlobalKey<FormState> _formKey;
  bool isSubmitDisabled = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  Future<bool> createNewCompany() async {
    // if (!_formKey.currentState!.validate()) {
    //   return false;
    // }
    await ref.read(companiesPodProvider.notifier).insertCompany(
          name: _nameController.text,
          description: _descriptionController.text,
        );
    return true;
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
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isSubmitDisabled = false;
              });
            } else {
              setState(() {
                isSubmitDisabled = true;
              });
            }
          },
          child: VStack(
            [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  hintText: "Name",
                ),
                textInputAction: TextInputAction.next,
                controller: _nameController,
                validator: (str) {
                  if (str!.isEmpty || str.length < 2) {
                    return "Name should not be empty";
                  }

                  return null;
                },
              ),
              16.heightBox,
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  hintText: "Description",
                ),
                maxLines: 5,
                controller: _descriptionController,
                validator: (str) {
                  if (str!.isEmpty || str.length < 2) {
                    return "Description should not be empty";
                  }

                  return null;
                },
              ),
            ],
          ),
        ).pSymmetric(h: 16.w),
      ],
    );
  }
}
