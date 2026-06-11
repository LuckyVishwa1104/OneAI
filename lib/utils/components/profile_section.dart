import 'package:flutter/material.dart';
import 'package:one_ai/model/profile_option_model.dart';
import 'package:one_ai/utils/components/app_icon.dart';
import 'package:one_ai/utils/constants/app_border.dart';
import 'package:one_ai/utils/constants/app_colors.dart';
import 'package:one_ai/utils/constants/app_radius.dart';
import 'package:one_ai/utils/constants/app_shadow.dart';
import 'package:one_ai/utils/constants/app_spacing.dart';
import 'package:one_ai/utils/constants/app_text_styles.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileOptionModel> options;
  const ProfileSection({super.key, required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.subHeading(context)),
        AppSpacing.h12,
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: AppRadius.radiusXxl,
            border: AppBorder.defaultBorder(context),
            boxShadow: [AppShadow.homeTileShadow],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) {
              return Divider(
                height: 1,
                color: Theme.of(context).dividerColor
              );
            },
            itemCount: options.length,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(index == 0 ? 28 : 0),
                  topRight: Radius.circular(index == 0 ? 28 : 0),
                  bottomLeft: Radius.circular(
                    index == options.length - 1 ? 28 : 0,
                  ),
                  bottomRight: Radius.circular(
                    index == options.length - 1 ? 28 : 0,
                  ),
                ),
                onTap: options[index].onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      /// ICON
                      options[index].optionIcon,

                      AppSpacing.w16,

                      /// TITLE + SUBTITLE
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              options[index].title,
                              style: AppTextStyles.heading(context).copyWith(
                                fontSize: 18
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            if (options[index].subtitle != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                options[index].subtitle!,
                                style: AppTextStyles.subHeading(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),

                      /// TRAILING
                      options[index].trailing ??
                      AppIcon(icon: Icons.chevron_right,)
                          
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
