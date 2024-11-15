import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/auth/login_screen.dart';
import 'package:to_do/auth/user_provider.dart';
import 'package:to_do/tabs/settings/language.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<ThemeMode> mode = [ThemeMode.light, ThemeMode.dark];
  String? selectedLanguage;
  ThemeMode selectedMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    List<Language> languages = [
      Language(code: 'en', name: AppLocalizations.of(context)!.english),
      Language(code: 'ar', name: AppLocalizations.of(context)!.arabic)
    ];
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Column(children: [
      Stack(
        children: [
          Container(
            height: height * 0.22,
            width: width,
            color: AppTheme.primary,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(width * 0.1, height * 0.06, width * 0.1, 0),
            child: Text(AppLocalizations.of(context)!.settings,
                style: theme.textTheme.titleMedium?.copyWith(
                    color: settingsProvider.defultThemeMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.darkBackground,
                    fontSize: 22)),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: width,
              child: Text(
                AppLocalizations.of(context)!.language,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: settingsProvider.defultThemeMode == ThemeMode.light
                      ? AppTheme.white
                      : AppTheme.dark,
                  border: Border.all(color: AppTheme.primary),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    borderRadius: BorderRadius.circular(12),
                    value: languages.firstWhere((language) =>
                        language.code == settingsProvider.languageCode),
                    items: languages
                        .map((language) => DropdownMenuItem<Language>(
                            value: language,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(language.name,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          color: AppTheme.primary,
                                        ))),
                              ],
                            )))
                        .toList(),
                    onChanged: (selectedLanguage) {
                      settingsProvider.changeLanguage(selectedLanguage!.code);
                    },
                    dropdownColor:
                        settingsProvider.defultThemeMode == ThemeMode.light
                            ? AppTheme.white
                            : AppTheme.dark,
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            SizedBox(
                width: width,
                child: Text(AppLocalizations.of(context)!.mode,
                    style: theme.textTheme.titleMedium)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: settingsProvider.defultThemeMode == ThemeMode.light
                      ? AppTheme.white
                      : AppTheme.dark,
                  border: Border.all(color: AppTheme.primary),
                ),
                child: DropdownButtonHideUnderline(
                  // إزالة الخط السفلي الافتراضي
                  child: DropdownButton<ThemeMode>(
                    borderRadius: BorderRadius.circular(12),
                    value: settingsProvider.defultThemeMode,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(AppLocalizations.of(context)!.light,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: AppTheme.primary,
                                    ))),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(AppLocalizations.of(context)!.dark,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: AppTheme.primary,
                                    ))),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (ThemeMode? newTheme) {
                      if (newTheme != null) {
                        settingsProvider.changeTheme(newTheme);
                      }
                    },
                    dropdownColor:
                        settingsProvider.defultThemeMode == ThemeMode.light
                            ? AppTheme.white
                            : AppTheme.dark,
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.logout,
                    style: theme.textTheme.titleMedium),
                IconButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                      Provider.of<TasksProvider>(context, listen: false)
                          .tasks
                          .clear();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
