import 'package:companion/src/core/widgets/pim_controller.dart';
import 'package:companion/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';

class CreatePimSection extends StatelessWidget {
  final List<PimController> controllers;
  final Null Function(String id)? onControllerRemove;

  const CreatePimSection({
    super.key,
    required this.controllers,
    required this.onControllerRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controllers.length,
      itemBuilder: (context, index) {
        return PimTextField(
          pimController: controllers[index],
          onControllerRemove: onControllerRemove,
        );
      },
      separatorBuilder: (_, index) => 8.h.heightBox,
    );
  }
}

class PimTextField extends StatelessWidget {
  final PimController pimController;
  final Null Function(String id)? onControllerRemove;

  const PimTextField({
    super.key,
    required this.pimController,
    required this.onControllerRemove,
  });

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        TextFormField(
          key: Key(pimController.id),
          controller: pimController,
          decoration: getDecoration(hint: "Contact"),
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(),
              FormBuilderValidators.phoneNumber(),
              FormBuilderValidators.equalLength(10)
            ],
          ),
        ).expand(),
        IconButton(
          color: context.colors.error,
          disabledColor: context.colors.onErrorContainer,
          onPressed: onControllerRemove == null
              ? null
              : () {
                  if (onControllerRemove != null) {
                    onControllerRemove!(pimController.id);
                  }
                },
          icon: Icon(
            Icons.remove_circle_outline,
          ),
        )
      ],
      axisSize: MainAxisSize.max,
      spacing: 8.w,
    );
  }
}

            // return ListView.separated(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: pims.length,
            //   itemBuilder: (context, index) {
            //     return HStack(
            //       [
            //         TextFormField(
            //           key: Key(pims[index].id),
            //           decoration: getDecoration(hint: "Contact"),
            //           keyboardType: TextInputType.phone,
            //           autovalidateMode: AutovalidateMode.onUserInteraction,
            //           initialValue: pims[index].digits,
            //           onFieldSubmitted: (val) async {
            //             if (val.isEmptyOrNull || val == "") {
            //               await ref
            //                   .read(pimRepositoryProvider)
            //                   .delete(pims[index]);
            //             } else {
            //               await ref.read(pimRepositoryProvider).update(
            //                     pims[index].id,
            //                     pims[index].copyWith(digits: val),
            //                   );
            //             }
            //             ref.invalidate(pimDigitsProvider);
            //           },
            //           validator: FormBuilderValidators.compose(
            //             [
            //               FormBuilderValidators.required(),
            //               FormBuilderValidators.phoneNumber(),
            //               FormBuilderValidators.equalLength(10)
            //             ],
            //           ),
            //         ).expand(),
            //         IconButton(
            //           color: context.colors.error,
            //           disabledColor: context.colors.onErrorContainer,
            //           onPressed: () async {
            //             if (pims.length > 1) {
            //               await ref.read(pimRepositoryProvider).delete(
            //                     pims[index],
            //                   );
            //             }
            //             ref.invalidate(pimDigitsProvider);
            //           },
            //           icon: Icon(
            //             Icons.remove_circle_outline,
            //           ),
            //         ),
            //       ],
            //       axisSize: MainAxisSize.max,
            //       spacing: 8.w,
            //     );
            //   },
            //   separatorBuilder: (_, __) {
            //     return 8.h.heightBox;
            //   },
            // );