import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

abstract final class AppTheme {
  AppTheme._();

  static final ThemeData dark = _buildDarkTheme();

  static ThemeData _buildDarkTheme() {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.buttonText,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.textPrimary,
      secondary: AppColors.secondary,
      onSecondary: Color(0xFF041B17),
      secondaryContainer: AppColors.secondaryDark,
      onSecondaryContainer: AppColors.textPrimary,
      tertiary: AppColors.accent,
      onTertiary: Color(0xFF221500),
      error: AppColors.error,
      onError: Color(0xFF260306),
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceDim: AppColors.background,
      surfaceBright: AppColors.surfaceElevated,
      surfaceContainerLowest: AppColors.background,
      surfaceContainerLow: AppColors.surface,
      surfaceContainer: AppColors.surfaceElevated,
      surfaceContainerHigh: AppColors.panelMuted,
      surfaceContainerHighest: AppColors.panel,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
      outlineVariant: AppColors.borderSubtle,
      shadow: AppColors.shadow,
      scrim: Color(0xCC000000),
      inverseSurface: Color(0xFFE9EDF2),
      onInverseSurface: Color(0xFF15191D),
      inversePrimary: AppColors.primaryDark,
      surfaceTint: Colors.transparent,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.panel,
      dividerColor: AppColors.divider,
      focusColor: AppColors.focusRing.withValues(alpha: 0.28),
      hoverColor: AppColors.primary.withValues(alpha: 0.08),
      highlightColor: AppColors.primary.withValues(alpha: 0.12),
      disabledColor: AppColors.textDisabled,
      visualDensity: VisualDensity.standard,
      textTheme: _textTheme,
      primaryTextTheme: _textTheme,
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 20),
      primaryIconTheme: const IconThemeData(
        color: AppColors.buttonText,
        size: 20,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: AppConstants.pagePadding,
        toolbarHeight: AppConstants.toolbarHeight,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.panel,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.shadow,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.panelCornerRadius),
          side: const BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _primaryButtonStyle),
      filledButtonTheme: FilledButtonThemeData(style: _primaryButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _outlinedButtonStyle),
      textButtonTheme: TextButtonThemeData(style: _textButtonStyle),
      iconButtonTheme: IconButtonThemeData(style: _iconButtonStyle),
      inputDecorationTheme: _inputDecorationTheme,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: _inputDecorationTheme,
        menuStyle: _menuStyle,
      ),
      menuTheme: MenuThemeData(style: _menuStyle),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.shadow,
        elevation: 14,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.panelCornerRadius),
          side: const BorderSide(color: AppColors.borderSubtle),
        ),
        textStyle: _textTheme.bodyMedium,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.panel,
        surfaceTintColor: Colors.transparent,
        elevation: 18,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.panelCornerRadius),
          side: const BorderSide(color: AppColors.border),
        ),
        titleTextStyle: _textTheme.titleLarge,
        contentTextStyle: _textTheme.bodyMedium,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: const Color(0xFF0B0D10),
          borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
          border: Border.all(color: AppColors.border),
        ),
        textStyle: _textTheme.labelMedium,
        waitDuration: const Duration(milliseconds: 450),
        showDuration: const Duration(seconds: 4),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        actionTextColor: AppColors.primary,
        contentTextStyle: _textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.panelCornerRadius),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(999),
        thickness: WidgetStateProperty.all(8),
        thumbVisibility: WidgetStateProperty.all(true),
        trackVisibility: WidgetStateProperty.all(false),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.dragged) ||
              states.contains(WidgetState.hovered)) {
            return AppColors.textMuted;
          }

          return AppColors.border;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.border,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.16),
        valueIndicatorColor: AppColors.surfaceElevated,
        valueIndicatorTextStyle: _textTheme.labelMedium,
        trackHeight: 4,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }

          if (states.contains(WidgetState.selected)) {
            return AppColors.buttonText;
          }

          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.borderSubtle;
          }

          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.border;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.border),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.borderSubtle;
          }

          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.surfaceElevated;
        }),
        checkColor: WidgetStateProperty.all(AppColors.buttonText),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }

          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.textSecondary;
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary.withValues(alpha: 0.16);
            }

            return AppColors.surfaceElevated;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textDisabled;
            }

            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }

            return AppColors.textSecondary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const BorderSide(color: AppColors.primary);
            }

            return const BorderSide(color: AppColors.borderSubtle);
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.controlCornerRadius,
              ),
            ),
          ),
          textStyle: WidgetStateProperty.all(_textTheme.labelMedium),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: AppColors.borderSubtle,
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textMuted,
        labelStyle: _textTheme.labelLarge,
        unselectedLabelStyle: _textTheme.labelLarge,
        overlayColor: WidgetStateProperty.all(
          AppColors.primary.withValues(alpha: 0.08),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        selectedColor: AppColors.primary,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        minLeadingWidth: 20,
        dense: true,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.surface,
        elevation: 0,
        selectedIconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 22,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppColors.textMuted,
          size: 22,
        ),
        selectedLabelTextStyle: _textTheme.labelMedium?.copyWith(
          color: AppColors.primary,
        ),
        unselectedLabelTextStyle: _textTheme.labelMedium?.copyWith(
          color: AppColors.textMuted,
        ),
        indicatorColor: AppColors.primary.withValues(alpha: 0.14),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: _textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: _textTheme.bodyMedium,
        dividerThickness: 1,
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceElevated),
        dataRowColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.10);
          }

          return Colors.transparent;
        }),
      ),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.12,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.15,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.18,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.25,
    ),
    titleMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.28,
    ),
    titleSmall: TextStyle(
      color: AppColors.textSecondary,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.30,
    ),
    bodyLarge: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.45,
    ),
    bodyMedium: TextStyle(
      color: AppColors.textSecondary,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.42,
    ),
    bodySmall: TextStyle(
      color: AppColors.textMuted,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.35,
    ),
    labelLarge: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.15,
    ),
    labelMedium: TextStyle(
      color: AppColors.textSecondary,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.15,
    ),
    labelSmall: TextStyle(
      color: AppColors.textMuted,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.15,
    ),
  );

  static final ButtonStyle _primaryButtonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(const Size(96, 40)),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16),
    ),
    elevation: WidgetStateProperty.all(0),
    shadowColor: WidgetStateProperty.all(Colors.transparent),
    surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.borderSubtle;
      }

      if (states.contains(WidgetState.pressed)) {
        return AppColors.buttonPressed;
      }

      if (states.contains(WidgetState.hovered)) {
        return AppColors.buttonHover;
      }

      return AppColors.button;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.textDisabled;
      }

      return AppColors.buttonText;
    }),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    textStyle: WidgetStateProperty.all(_textTheme.labelLarge),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      ),
    ),
  );

  static final ButtonStyle _outlinedButtonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(const Size(96, 40)),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return AppColors.primary.withValues(alpha: 0.08);
      }

      return Colors.transparent;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.textDisabled;
      }

      return AppColors.primary;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const BorderSide(color: AppColors.borderSubtle);
      }

      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return const BorderSide(color: AppColors.primaryHover);
      }

      return const BorderSide(color: AppColors.border);
    }),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    textStyle: WidgetStateProperty.all(_textTheme.labelLarge),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      ),
    ),
  );

  static final ButtonStyle _textButtonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(const Size(40, 36)),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 12),
    ),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.textDisabled;
      }

      if (states.contains(WidgetState.hovered)) {
        return AppColors.primaryHover;
      }

      return AppColors.primary;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.primary.withValues(alpha: 0.14);
      }

      if (states.contains(WidgetState.hovered)) {
        return AppColors.primary.withValues(alpha: 0.08);
      }

      return Colors.transparent;
    }),
    textStyle: WidgetStateProperty.all(_textTheme.labelLarge),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      ),
    ),
  );

  static final ButtonStyle _iconButtonStyle = ButtonStyle(
    fixedSize: WidgetStateProperty.all(const Size.square(36)),
    minimumSize: WidgetStateProperty.all(const Size.square(36)),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    iconSize: WidgetStateProperty.all(20),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.textDisabled;
      }

      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return AppColors.textPrimary;
      }

      return AppColors.textSecondary;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.primary.withValues(alpha: 0.14);
      }

      if (states.contains(WidgetState.hovered)) {
        return AppColors.surfaceElevated;
      }

      return Colors.transparent;
    }),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      ),
    ),
  );

  static final InputDecorationThemeData _inputDecorationTheme =
      InputDecorationThemeData(
        filled: true,
        fillColor: AppColors.surfaceElevated,
        hoverColor: AppColors.primary.withValues(alpha: 0.06),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        labelStyle: _textTheme.bodyMedium,
        floatingLabelStyle: _textTheme.bodyMedium?.copyWith(
          color: AppColors.primary,
        ),
        hintStyle: _textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        helperStyle: _textTheme.bodySmall,
        errorStyle: _textTheme.bodySmall?.copyWith(color: AppColors.error),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        border: _inputBorder(AppColors.borderSubtle),
        enabledBorder: _inputBorder(AppColors.borderSubtle),
        disabledBorder: _inputBorder(AppColors.borderSubtle),
        focusedBorder: _inputBorder(AppColors.primary, width: 1.4),
        errorBorder: _inputBorder(AppColors.error),
        focusedErrorBorder: _inputBorder(AppColors.error, width: 1.4),
      );

  static final MenuStyle _menuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(AppColors.surfaceElevated),
    surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    shadowColor: WidgetStateProperty.all(AppColors.shadow),
    elevation: WidgetStateProperty.all(14),
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.panelCornerRadius),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
    ),
  );

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
