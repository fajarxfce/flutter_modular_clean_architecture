import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Example showcase of AppButton components
/// Use this as reference for all button variants
class AppButtonShowcase extends StatelessWidget {
  const AppButtonShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        title: const Text('AppButton Showcase'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Primary Buttons',
              description:
                  'Use for main actions like "Save", "Submit", "Create"',
              children: [
                AppButton.primary(text: 'Primary Button', onPressed: () {}),
                const SizedBox(height: 12),
                AppButton.primary(
                  text: 'With Icon',
                  icon: Icons.add,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AppButton.primary(
                  text: 'Loading',
                  isLoading: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const AppButton.primary(text: 'Disabled', onPressed: null),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Secondary Buttons',
              description: 'Use for secondary actions like "Cancel", "Back"',
              children: [
                AppButton.secondary(text: 'Secondary Button', onPressed: () {}),
                const SizedBox(height: 12),
                AppButton.secondary(
                  text: 'With Icon',
                  icon: Icons.settings,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AppButton.secondary(
                  text: 'Loading',
                  isLoading: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const AppButton.secondary(text: 'Disabled', onPressed: null),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Destructive Buttons',
              description: 'Use for dangerous actions like "Delete", "Remove"',
              children: [
                AppButton.destructive(text: 'Delete Item', onPressed: () {}),
                const SizedBox(height: 12),
                AppButton.destructive(
                  text: 'Remove',
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const AppButton.destructive(text: 'Disabled', onPressed: null),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Ghost Buttons',
              description: 'Use for tertiary actions, less emphasis',
              children: [
                AppButton.ghost(text: 'Ghost Button', onPressed: () {}),
                const SizedBox(height: 12),
                AppButton.ghost(
                  text: 'With Icon',
                  icon: Icons.info_outline,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const AppButton.ghost(text: 'Disabled', onPressed: null),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Link Buttons',
              description: 'Use for navigation or inline actions',
              children: [
                AppButton.link(text: 'Learn more', onPressed: () {}),
                const SizedBox(height: 12),
                const AppButton.link(text: 'Disabled link', onPressed: null),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Button Sizes',
              description: 'Small, Medium (default), Large',
              children: [
                AppButton.primary(
                  text: 'Small',
                  size: AppButtonSize.small,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AppButton.primary(
                  text: 'Medium (Default)',
                  size: AppButtonSize.medium,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AppButton.primary(
                  text: 'Large',
                  size: AppButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Full Width Buttons',
              description: 'Spans entire container width',
              children: [
                AppButton.primary(
                  text: 'Full Width Button',
                  fullWidth: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AppButton.secondary(
                  text: 'Full Width Secondary',
                  fullWidth: true,
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Usage Examples',
              description: 'Common button combinations',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        text: 'Cancel',
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton.primary(text: 'Save', onPressed: () {}),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton.ghost(
                      text: 'Back',
                      icon: Icons.arrow_back,
                      onPressed: () {},
                    ),
                    AppButton.primary(
                      text: 'Next',
                      icon: Icons.arrow_forward,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
