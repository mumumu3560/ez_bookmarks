/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 4
/// Strings: 480 (120 per locale)
///
/// Built on 2024-05-04 at 16:32 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	es(languageCode: 'es', build: _StringsEs.build),
	ja(languageCode: 'ja', build: _StringsJa.build),
	pt(languageCode: 'pt', build: _StringsPt.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsHomeEn home = _StringsHomeEn._(_root);
	late final _StringsBookmarkCardEn bookmark_card = _StringsBookmarkCardEn._(_root);
	late final _StringsDrawerEn drawer = _StringsDrawerEn._(_root);
	late final _StringsAddBookmarksEn add_bookmarks = _StringsAddBookmarksEn._(_root);
	late final _StringsEditBookmarksEn edit_bookmarks = _StringsEditBookmarksEn._(_root);
	late final _StringsImportExportEn import_export = _StringsImportExportEn._(_root);
	late final _StringsSettingsEn settings = _StringsSettingsEn._(_root);
	late final _StringsSearchEn search = _StringsSearchEn._(_root);
	late final _StringsExternalUrlEn external_url = _StringsExternalUrlEn._(_root);
	late final _StringsDatabaseEn database = _StringsDatabaseEn._(_root);
	late final _StringsUtilsEn utils = _StringsUtilsEn._(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'ja': '日本語',
		'es': 'Español',
		'pt': 'Português',
	};
}

// Path: home
class _StringsHomeEn {
	_StringsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title_with_tags => 'Selected tags';
	late final _StringsHomeSelectedTagsDialogEn selected_tags_dialog = _StringsHomeSelectedTagsDialogEn._(_root);
	late final _StringsHomeSettingListEn setting_list = _StringsHomeSettingListEn._(_root);
}

// Path: bookmark_card
class _StringsBookmarkCardEn {
	_StringsBookmarkCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBookmarkCardSettingListEn setting_list = _StringsBookmarkCardSettingListEn._(_root);
}

// Path: drawer
class _StringsDrawerEn {
	_StringsDrawerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get tags => 'Search & Edit by Tags';
	String get management => 'Import and Backup';
	String get settings => 'Settings';
	String get inquiry => 'Contact';
}

// Path: add_bookmarks
class _StringsAddBookmarksEn {
	_StringsAddBookmarksEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Add';
	String get complete => 'Done';
	String get explain => 'Explain';
	String get url => 'URL';
	String get input => 'Input Tag';
	String get select_image => 'Select Image';
	String get tag_show => 'Tags to be added';
	String get exist_tag => 'Existing Tags';
	late final _StringsAddBookmarksCompleteDialogEn complete_dialog = _StringsAddBookmarksCompleteDialogEn._(_root);
	late final _StringsAddBookmarksSnackbarEn snackbar = _StringsAddBookmarksSnackbarEn._(_root);
	late final _StringsAddBookmarksOnInsertEn on_insert = _StringsAddBookmarksOnInsertEn._(_root);
}

// Path: edit_bookmarks
class _StringsEditBookmarksEn {
	_StringsEditBookmarksEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Edit';
	String get complete => 'Done';
	String get explain => 'Explain';
	String get url => 'URL';
	String get input => 'Input Tag';
	String get select_image => 'Select Image';
	String get tag_show => 'Tags to be added';
	String get exist_tag => 'Existing Tags';
	late final _StringsEditBookmarksSnackbarEn snackbar = _StringsEditBookmarksSnackbarEn._(_root);
}

// Path: import_export
class _StringsImportExportEn {
	_StringsImportExportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Database Management';
	String get import => 'About Import';
	String get export => 'About Export';
	String get import_button => 'Import';
	String get export_button => 'Export';
	late final _StringsImportExportImportDialogEn import_dialog = _StringsImportExportImportDialogEn._(_root);
	late final _StringsImportExportBackupDialogEn backup_dialog = _StringsImportExportBackupDialogEn._(_root);
	late final _StringsImportExportBackUpConfirmDialogEn back_up_confirm_dialog = _StringsImportExportBackUpConfirmDialogEn._(_root);
	late final _StringsImportExportOnImportEn on_import = _StringsImportExportOnImportEn._(_root);
	late final _StringsImportExportOnBackupEn on_backup = _StringsImportExportOnBackupEn._(_root);
}

// Path: settings
class _StringsSettingsEn {
	_StringsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	String get privacy_policy => 'Privacy Policy';
	String get change_theme => 'Change Theme';
	String get change_database => 'Change Database';
	String get current_database => 'Current Database';
	String get language => 'Language';
	late final _StringsSettingsDatabaseDialogEn database_dialog = _StringsSettingsDatabaseDialogEn._(_root);
	String get loading_dialog => 'Loading...';
	late final _StringsSettingsOnChangeDatabaseEn on_change_database = _StringsSettingsOnChangeDatabaseEn._(_root);
}

// Path: search
class _StringsSearchEn {
	_StringsSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tags';
	String get found => 'bookmarks found';
	String get search_button => 'Search';
	String get clear_button => 'Clear';
	String get change_genre => 'Change Genre';
	late final _StringsSearchSearchDialogEn search_dialog = _StringsSearchSearchDialogEn._(_root);
	late final _StringsSearchGenreDialogEn genre_dialog = _StringsSearchGenreDialogEn._(_root);
}

// Path: external_url
class _StringsExternalUrlEn {
	_StringsExternalUrlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get privacy_policy => 'https://ez-bookmarks.pages.dev/en/privacy-policy';
	String get inquiry => 'https://forms.gle/7FnqbLNPLsCTDM3q7';
}

// Path: database
class _StringsDatabaseEn {
	_StringsDatabaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get no_genre => 'Uncategorized';
}

// Path: utils
class _StringsUtilsEn {
	_StringsUtilsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get unexpected => 'unexpected error occured';
	String get loading => 'now loading...';
}

// Path: home.selected_tags_dialog
class _StringsHomeSelectedTagsDialogEn {
	_StringsHomeSelectedTagsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'selected tags';
	String get close => 'Close';
}

// Path: home.setting_list
class _StringsHomeSettingListEn {
	_StringsHomeSettingListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get grid => 'Change Grid';
	String get sort => 'Sort';
	late final _StringsHomeSettingListGridDialogEn grid_dialog = _StringsHomeSettingListGridDialogEn._(_root);
	late final _StringsHomeSettingListSortDialogEn sort_dialog = _StringsHomeSettingListSortDialogEn._(_root);
}

// Path: bookmark_card.setting_list
class _StringsBookmarkCardSettingListEn {
	_StringsBookmarkCardSettingListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get explain => 'Explain';
	String get show_tags => 'Show Tags';
	String get edit => 'Edit';
	String get delete => 'Delete';
	late final _StringsBookmarkCardSettingListExpainDialogEn expain_dialog = _StringsBookmarkCardSettingListExpainDialogEn._(_root);
	late final _StringsBookmarkCardSettingListTagDialogEn tag_dialog = _StringsBookmarkCardSettingListTagDialogEn._(_root);
	late final _StringsBookmarkCardSettingListDeleteDialogEn delete_dialog = _StringsBookmarkCardSettingListDeleteDialogEn._(_root);
}

// Path: add_bookmarks.complete_dialog
class _StringsAddBookmarksCompleteDialogEn {
	_StringsAddBookmarksCompleteDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Complete';
	String get text => 'The bookmark has been added. Please reload.';
	String get close => 'Close';
}

// Path: add_bookmarks.snackbar
class _StringsAddBookmarksSnackbarEn {
	_StringsAddBookmarksSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get url_confirm => 'Please enter a URL.';
	String get existing_confirm => 'A bookmark with the same URL already exists.';
}

// Path: add_bookmarks.on_insert
class _StringsAddBookmarksOnInsertEn {
	_StringsAddBookmarksOnInsertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get genre => 'Uncategorized';
}

// Path: edit_bookmarks.snackbar
class _StringsEditBookmarksSnackbarEn {
	_StringsEditBookmarksSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get url_confirm => 'Please enter a URL.';
	String get existing_confirm => 'A bookmark with the same URL already exists.';
}

// Path: import_export.import_dialog
class _StringsImportExportImportDialogEn {
	_StringsImportExportImportDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsImportExportImportDialogPage1En page_1 = _StringsImportExportImportDialogPage1En._(_root);
	late final _StringsImportExportImportDialogPage2En page_2 = _StringsImportExportImportDialogPage2En._(_root);
}

// Path: import_export.backup_dialog
class _StringsImportExportBackupDialogEn {
	_StringsImportExportBackupDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsImportExportBackupDialogPage1En page_1 = _StringsImportExportBackupDialogPage1En._(_root);
	late final _StringsImportExportBackupDialogPage2En page_2 = _StringsImportExportBackupDialogPage2En._(_root);
}

// Path: import_export.back_up_confirm_dialog
class _StringsImportExportBackUpConfirmDialogEn {
	_StringsImportExportBackUpConfirmDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Confirm';
	String get text => 'Are you sure you want to back up the database?';
	String get yes => 'Yes';
	String get no => 'No';
}

// Path: import_export.on_import
class _StringsImportExportOnImportEn {
	_StringsImportExportOnImportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get complete => 'Import Completed';
}

// Path: import_export.on_backup
class _StringsImportExportOnBackupEn {
	_StringsImportExportOnBackupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get complete => 'Backup Completed';
}

// Path: settings.database_dialog
class _StringsSettingsDatabaseDialogEn {
	_StringsSettingsDatabaseDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Confirm';
	String get text => 'Are you sure you want to change the database?(An advertisement will play every three times.)';
	String get yes => 'Yes';
	String get no => 'No';
}

// Path: settings.on_change_database
class _StringsSettingsOnChangeDatabaseEn {
	_StringsSettingsOnChangeDatabaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get complete => 'Completed';
	String get text => 'Database has been switched.';
	String get ok => 'OK';
}

// Path: search.search_dialog
class _StringsSearchSearchDialogEn {
	_StringsSearchSearchDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsSearchSearchDialogPage1En page_1 = _StringsSearchSearchDialogPage1En._(_root);
	late final _StringsSearchSearchDialogPage2En page_2 = _StringsSearchSearchDialogPage2En._(_root);
	late final _StringsSearchSearchDialogPage3En page_3 = _StringsSearchSearchDialogPage3En._(_root);
}

// Path: search.genre_dialog
class _StringsSearchGenreDialogEn {
	_StringsSearchGenreDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Edit Genre';
	String get cancel => 'Cancel';
	String get save => 'Save';
	String get form => 'Genre Name';
}

// Path: home.setting_list.grid_dialog
class _StringsHomeSettingListGridDialogEn {
	_StringsHomeSettingListGridDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Change Grid';
	String get close => 'Close';
	String get grid_num => 'Grid Num';
	String get init_num => 'initial';
	String get now_num => 'now';
}

// Path: home.setting_list.sort_dialog
class _StringsHomeSettingListSortDialogEn {
	_StringsHomeSettingListSortDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Change Sort';
	String get descending => 'Descending';
	String get close => 'Close';
	late final _StringsHomeSettingListSortDialogSortListEn sort_list = _StringsHomeSettingListSortDialogSortListEn._(_root);
}

// Path: bookmark_card.setting_list.expain_dialog
class _StringsBookmarkCardSettingListExpainDialogEn {
	_StringsBookmarkCardSettingListExpainDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Explain';
	String get close => 'Close';
}

// Path: bookmark_card.setting_list.tag_dialog
class _StringsBookmarkCardSettingListTagDialogEn {
	_StringsBookmarkCardSettingListTagDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Tags';
	String get close => 'Close';
	String get search => '+Search';
	late final _StringsBookmarkCardSettingListTagDialogAndSearchEn and_search = _StringsBookmarkCardSettingListTagDialogAndSearchEn._(_root);
}

// Path: bookmark_card.setting_list.delete_dialog
class _StringsBookmarkCardSettingListDeleteDialogEn {
	_StringsBookmarkCardSettingListDeleteDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Confirm Delete';
	String get confirm => 'Sure to delete?';
	String get delete => 'Delete';
	String get cancel => 'Cancel';
	late final _StringsBookmarkCardSettingListDeleteDialogSnackbarEn snackbar = _StringsBookmarkCardSettingListDeleteDialogSnackbarEn._(_root);
}

// Path: import_export.import_dialog.page_1
class _StringsImportExportImportDialogPage1En {
	_StringsImportExportImportDialogPage1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Overwrite';
	String get text => 'When importing, the current database will be overwritten. Please confirm before importing.';
}

// Path: import_export.import_dialog.page_2
class _StringsImportExportImportDialogPage2En {
	_StringsImportExportImportDialogPage2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Thumbnail';
	String get text => 'The displayed thumbnails reference the path of images on the device. Changing devices or deleting images from the device will result in the thumbnails being unable to display. Please note that if you have selected an image,...';
}

// Path: import_export.backup_dialog.page_1
class _StringsImportExportBackupDialogPage1En {
	_StringsImportExportBackupDialogPage1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'File Name';
	String get text => 'The backup file will be saved in the download folder with the name \'classifier_database(1,2,3)_backup.sqlite\'.';
}

// Path: import_export.backup_dialog.page_2
class _StringsImportExportBackupDialogPage2En {
	_StringsImportExportBackupDialogPage2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Attention';
	String get text => 'The files will be saved with names like \'database1_backup1\', \'database1_backup2\', and so on.\n\nContinuing to make backups will consume storage space. Please remember to organize your download folder.';
}

// Path: search.search_dialog.page_1
class _StringsSearchSearchDialogPage1En {
	_StringsSearchSearchDialogPage1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'About this page';
	String get text => 'On this page, you can search bookmarks by tags and change the genre of tags.';
}

// Path: search.search_dialog.page_2
class _StringsSearchSearchDialogPage2En {
	_StringsSearchSearchDialogPage2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'About search';
	String get text => 'You can search bookmarks by selecting tags from the list below.\n\nMultiple tags can be selected.';
}

// Path: search.search_dialog.page_3
class _StringsSearchSearchDialogPage3En {
	_StringsSearchSearchDialogPage3En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'About Genre';
	String get text => 'The genre is a classification of tags, with the default being \'Uncategorized.\'\n\nYou can select tags and change the genre.';
}

// Path: home.setting_list.sort_dialog.sort_list
class _StringsHomeSettingListSortDialogSortListEn {
	_StringsHomeSettingListSortDialogSortListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get created => 'CreatedAt';
	String get updated => 'UpdatedAt';
	String get tag => 'Tag';
	String get genre => 'Genre';
	String get random => 'Random';
}

// Path: bookmark_card.setting_list.tag_dialog.and_search
class _StringsBookmarkCardSettingListTagDialogAndSearchEn {
	_StringsBookmarkCardSettingListTagDialogAndSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What is +Search?';
	String get close => 'Close';
	String get text => 'You can search for bookmarks that include the tag you have currently selected and all previously selected tags (top left).';
}

// Path: bookmark_card.setting_list.delete_dialog.snackbar
class _StringsBookmarkCardSettingListDeleteDialogSnackbarEn {
	_StringsBookmarkCardSettingListDeleteDialogSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get delete => 'Deleted';
}

// Path: <root>
class _StringsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsHomeEs home = _StringsHomeEs._(_root);
	@override late final _StringsBookmarkCardEs bookmark_card = _StringsBookmarkCardEs._(_root);
	@override late final _StringsDrawerEs drawer = _StringsDrawerEs._(_root);
	@override late final _StringsAddBookmarksEs add_bookmarks = _StringsAddBookmarksEs._(_root);
	@override late final _StringsEditBookmarksEs edit_bookmarks = _StringsEditBookmarksEs._(_root);
	@override late final _StringsImportExportEs import_export = _StringsImportExportEs._(_root);
	@override late final _StringsSettingsEs settings = _StringsSettingsEs._(_root);
	@override late final _StringsSearchEs search = _StringsSearchEs._(_root);
	@override late final _StringsDatabaseEs database = _StringsDatabaseEs._(_root);
	@override late final _StringsExternalUrlEs external_url = _StringsExternalUrlEs._(_root);
	@override late final _StringsUtilsEs utils = _StringsUtilsEs._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'ja': '日本語',
		'es': 'Español',
		'pt': 'Português',
	};
}

// Path: home
class _StringsHomeEs implements _StringsHomeEn {
	_StringsHomeEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title_with_tags => 'Etiquetas seleccionados.';
	@override late final _StringsHomeSelectedTagsDialogEs selected_tags_dialog = _StringsHomeSelectedTagsDialogEs._(_root);
	@override late final _StringsHomeSettingListEs setting_list = _StringsHomeSettingListEs._(_root);
}

// Path: bookmark_card
class _StringsBookmarkCardEs implements _StringsBookmarkCardEn {
	_StringsBookmarkCardEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsBookmarkCardSettingListEs setting_list = _StringsBookmarkCardSettingListEs._(_root);
}

// Path: drawer
class _StringsDrawerEs implements _StringsDrawerEn {
	_StringsDrawerEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get tags => 'Buscar y editar por etiquetas';
	@override String get management => 'Importación y copia de seguridad';
	@override String get settings => 'Configuración';
	@override String get inquiry => 'Contacto';
}

// Path: add_bookmarks
class _StringsAddBookmarksEs implements _StringsAddBookmarksEn {
	_StringsAddBookmarksEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añadir';
	@override String get complete => 'Hecho';
	@override String get explain => 'Explicar';
	@override String get url => 'URL';
	@override String get input => 'Input etiquetas';
	@override String get select_image => 'Seleccionar imagen';
	@override String get tag_show => 'Etiquetas a añadir';
	@override String get exist_tag => 'Etiquetas existentes';
	@override late final _StringsAddBookmarksCompleteDialogEs complete_dialog = _StringsAddBookmarksCompleteDialogEs._(_root);
	@override late final _StringsAddBookmarksSnackbarEs snackbar = _StringsAddBookmarksSnackbarEs._(_root);
	@override late final _StringsAddBookmarksOnInsertEs on_insert = _StringsAddBookmarksOnInsertEs._(_root);
}

// Path: edit_bookmarks
class _StringsEditBookmarksEs implements _StringsEditBookmarksEn {
	_StringsEditBookmarksEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar';
	@override String get complete => 'Completar';
	@override String get explain => 'Explicación';
	@override String get url => 'URL';
	@override String get input => 'Introducir etiquetas';
	@override String get select_image => 'Seleccionar imagen';
	@override String get tag_show => 'Etiquetas seleccionadas';
	@override String get exist_tag => 'Lista de etiquetas existentes';
	@override late final _StringsEditBookmarksSnackbarEs snackbar = _StringsEditBookmarksSnackbarEs._(_root);
}

// Path: import_export
class _StringsImportExportEs implements _StringsImportExportEn {
	_StringsImportExportEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gestión de la base de datos';
	@override String get import => 'Importar';
	@override String get export => 'Exportar';
	@override String get import_button => 'Importar';
	@override String get export_button => 'Exportar';
	@override late final _StringsImportExportImportDialogEs import_dialog = _StringsImportExportImportDialogEs._(_root);
	@override late final _StringsImportExportBackupDialogEs backup_dialog = _StringsImportExportBackupDialogEs._(_root);
	@override late final _StringsImportExportBackUpConfirmDialogEs back_up_confirm_dialog = _StringsImportExportBackUpConfirmDialogEs._(_root);
	@override late final _StringsImportExportOnImportEs on_import = _StringsImportExportOnImportEs._(_root);
	@override late final _StringsImportExportOnBackupEs on_backup = _StringsImportExportOnBackupEs._(_root);
}

// Path: settings
class _StringsSettingsEs implements _StringsSettingsEn {
	_StringsSettingsEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configuración';
	@override String get privacy_policy => 'Política de privacidad';
	@override String get change_theme => 'Cambiar tema';
	@override String get change_database => 'Cambiar base de datos';
	@override String get current_database => 'Base de datos actual';
	@override String get language => 'Idioma';
	@override late final _StringsSettingsDatabaseDialogEs database_dialog = _StringsSettingsDatabaseDialogEs._(_root);
	@override String get loading_dialog => 'Cargando...';
	@override late final _StringsSettingsOnChangeDatabaseEs on_change_database = _StringsSettingsOnChangeDatabaseEs._(_root);
}

// Path: search
class _StringsSearchEs implements _StringsSearchEn {
	_StringsSearchEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar y buscar por etiquetas';
	@override String get found => 'Marcadores encontrados';
	@override String get search_button => 'Buscar';
	@override String get clear_button => 'Limpiar';
	@override String get change_genre => 'Cambiar género';
	@override late final _StringsSearchSearchDialogEs search_dialog = _StringsSearchSearchDialogEs._(_root);
	@override late final _StringsSearchGenreDialogEs genre_dialog = _StringsSearchGenreDialogEs._(_root);
}

// Path: database
class _StringsDatabaseEs implements _StringsDatabaseEn {
	_StringsDatabaseEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get no_genre => 'Sin categoría';
}

// Path: external_url
class _StringsExternalUrlEs implements _StringsExternalUrlEn {
	_StringsExternalUrlEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get privacy_policy => 'https://ez-bookmarks.pages.dev/en/privacy-policy';
	@override String get inquiry => 'https://forms.gle/7FnqbLNPLsCTDM3q7';
}

// Path: utils
class _StringsUtilsEs implements _StringsUtilsEn {
	_StringsUtilsEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get unexpected => 'Se ha producido un error inesperado.';
	@override String get loading => 'Cargando...';
}

// Path: home.selected_tags_dialog
class _StringsHomeSelectedTagsDialogEs implements _StringsHomeSelectedTagsDialogEn {
	_StringsHomeSelectedTagsDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Etiquetas seleccionados.';
	@override String get close => 'Cerrar';
}

// Path: home.setting_list
class _StringsHomeSettingListEs implements _StringsHomeSettingListEn {
	_StringsHomeSettingListEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get grid => 'Cambiar rejilla';
	@override String get sort => 'Ordenar';
	@override late final _StringsHomeSettingListGridDialogEs grid_dialog = _StringsHomeSettingListGridDialogEs._(_root);
	@override late final _StringsHomeSettingListSortDialogEs sort_dialog = _StringsHomeSettingListSortDialogEs._(_root);
}

// Path: bookmark_card.setting_list
class _StringsBookmarkCardSettingListEs implements _StringsBookmarkCardSettingListEn {
	_StringsBookmarkCardSettingListEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get explain => 'Descripción.';
	@override String get show_tags => 'Mostrar etiquetas.';
	@override String get edit => 'Editar';
	@override String get delete => 'Borrar';
	@override late final _StringsBookmarkCardSettingListExpainDialogEs expain_dialog = _StringsBookmarkCardSettingListExpainDialogEs._(_root);
	@override late final _StringsBookmarkCardSettingListTagDialogEs tag_dialog = _StringsBookmarkCardSettingListTagDialogEs._(_root);
	@override late final _StringsBookmarkCardSettingListDeleteDialogEs delete_dialog = _StringsBookmarkCardSettingListDeleteDialogEs._(_root);
}

// Path: add_bookmarks.complete_dialog
class _StringsAddBookmarksCompleteDialogEs implements _StringsAddBookmarksCompleteDialogEn {
	_StringsAddBookmarksCompleteDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Completo';
	@override String get text => 'El marcador se ha añadido. Por favor, vuelva a cargarlo';
	@override String get close => 'Cerrar';
}

// Path: add_bookmarks.snackbar
class _StringsAddBookmarksSnackbarEs implements _StringsAddBookmarksSnackbarEn {
	_StringsAddBookmarksSnackbarEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'Por favor, introduzca una URL.';
	@override String get existing_confirm => 'Ya existe un marcador con la misma URL.';
}

// Path: add_bookmarks.on_insert
class _StringsAddBookmarksOnInsertEs implements _StringsAddBookmarksOnInsertEn {
	_StringsAddBookmarksOnInsertEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Sin categorizar';
}

// Path: edit_bookmarks.snackbar
class _StringsEditBookmarksSnackbarEs implements _StringsEditBookmarksSnackbarEn {
	_StringsEditBookmarksSnackbarEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'Por favor, introduzca una URL.';
	@override String get existing_confirm => 'La URL ya está registrada.';
}

// Path: import_export.import_dialog
class _StringsImportExportImportDialogEs implements _StringsImportExportImportDialogEn {
	_StringsImportExportImportDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportImportDialogPage1Es page_1 = _StringsImportExportImportDialogPage1Es._(_root);
	@override late final _StringsImportExportImportDialogPage2Es page_2 = _StringsImportExportImportDialogPage2Es._(_root);
}

// Path: import_export.backup_dialog
class _StringsImportExportBackupDialogEs implements _StringsImportExportBackupDialogEn {
	_StringsImportExportBackupDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportBackupDialogPage1Es page_1 = _StringsImportExportBackupDialogPage1Es._(_root);
	@override late final _StringsImportExportBackupDialogPage2Es page_2 = _StringsImportExportBackupDialogPage2Es._(_root);
}

// Path: import_export.back_up_confirm_dialog
class _StringsImportExportBackUpConfirmDialogEs implements _StringsImportExportBackUpConfirmDialogEn {
	_StringsImportExportBackUpConfirmDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmación';
	@override String get text => '¿Desea realizar una copia de seguridad?';
	@override String get yes => 'Sí';
	@override String get no => 'No';
}

// Path: import_export.on_import
class _StringsImportExportOnImportEs implements _StringsImportExportOnImportEn {
	_StringsImportExportOnImportEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get complete => 'La base de datos ha sido importada.';
}

// Path: import_export.on_backup
class _StringsImportExportOnBackupEs implements _StringsImportExportOnBackupEn {
	_StringsImportExportOnBackupEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get complete => 'La base de datos ha sido respaldada.';
}

// Path: settings.database_dialog
class _StringsSettingsDatabaseDialogEs implements _StringsSettingsDatabaseDialogEn {
	_StringsSettingsDatabaseDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmación';
	@override String get text => '¿Desea cambiar la base de datos?\n(Se mostrará un anuncio cada 3 cambios)';
	@override String get yes => 'Sí';
	@override String get no => 'No';
}

// Path: settings.on_change_database
class _StringsSettingsOnChangeDatabaseEs implements _StringsSettingsOnChangeDatabaseEn {
	_StringsSettingsOnChangeDatabaseEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get complete => 'Completo';
	@override String get text => 'La base de datos ha sido cambiada.';
	@override String get ok => 'OK';
}

// Path: search.search_dialog
class _StringsSearchSearchDialogEs implements _StringsSearchSearchDialogEn {
	_StringsSearchSearchDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override late final _StringsSearchSearchDialogPage1Es page_1 = _StringsSearchSearchDialogPage1Es._(_root);
	@override late final _StringsSearchSearchDialogPage2Es page_2 = _StringsSearchSearchDialogPage2Es._(_root);
	@override late final _StringsSearchSearchDialogPage3Es page_3 = _StringsSearchSearchDialogPage3Es._(_root);
}

// Path: search.genre_dialog
class _StringsSearchGenreDialogEs implements _StringsSearchGenreDialogEn {
	_StringsSearchGenreDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambiar género';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get form => 'Nombre del género';
}

// Path: home.setting_list.grid_dialog
class _StringsHomeSettingListGridDialogEs implements _StringsHomeSettingListGridDialogEn {
	_StringsHomeSettingListGridDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambiar rejilla';
	@override String get close => 'Cerrar';
	@override String get grid_num => 'Número de rejilla';
	@override String get init_num => 'inicial';
	@override String get now_num => 'ahora';
}

// Path: home.setting_list.sort_dialog
class _StringsHomeSettingListSortDialogEs implements _StringsHomeSettingListSortDialogEn {
	_StringsHomeSettingListSortDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambiar Ordenar';
	@override String get descending => 'Descendente';
	@override String get close => 'Cerrar';
	@override late final _StringsHomeSettingListSortDialogSortListEs sort_list = _StringsHomeSettingListSortDialogSortListEs._(_root);
}

// Path: bookmark_card.setting_list.expain_dialog
class _StringsBookmarkCardSettingListExpainDialogEs implements _StringsBookmarkCardSettingListExpainDialogEn {
	_StringsBookmarkCardSettingListExpainDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descripción.';
	@override String get close => 'Cerrar';
}

// Path: bookmark_card.setting_list.tag_dialog
class _StringsBookmarkCardSettingListTagDialogEs implements _StringsBookmarkCardSettingListTagDialogEn {
	_StringsBookmarkCardSettingListTagDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Etiquetas';
	@override String get close => 'Cerrar';
	@override String get search => '+Buscar';
	@override late final _StringsBookmarkCardSettingListTagDialogAndSearchEs and_search = _StringsBookmarkCardSettingListTagDialogAndSearchEs._(_root);
}

// Path: bookmark_card.setting_list.delete_dialog
class _StringsBookmarkCardSettingListDeleteDialogEs implements _StringsBookmarkCardSettingListDeleteDialogEn {
	_StringsBookmarkCardSettingListDeleteDialogEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar la eliminación';
	@override String get confirm => '¿Seguro que desea borrar?';
	@override String get delete => 'borrar';
	@override String get cancel => 'Cancelar';
	@override late final _StringsBookmarkCardSettingListDeleteDialogSnackbarEs snackbar = _StringsBookmarkCardSettingListDeleteDialogSnackbarEs._(_root);
}

// Path: import_export.import_dialog.page_1
class _StringsImportExportImportDialogPage1Es implements _StringsImportExportImportDialogPage1En {
	_StringsImportExportImportDialogPage1Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sobrescribir';
	@override String get text => 'Al importar, la base de datos actual se sobrescribirá.\n\nPor favor, confirme antes de importar.';
}

// Path: import_export.import_dialog.page_2
class _StringsImportExportImportDialogPage2Es implements _StringsImportExportImportDialogPage2En {
	_StringsImportExportImportDialogPage2Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Miniaturas';
	@override String get text => 'Las miniaturas mostradas hacen referencia a la ruta de las imágenes en el dispositivo.\n\nSi cambia de dispositivo o elimina las imágenes del dispositivo, las miniaturas pueden dejar de mostrarse.';
}

// Path: import_export.backup_dialog.page_1
class _StringsImportExportBackupDialogPage1Es implements _StringsImportExportBackupDialogPage1En {
	_StringsImportExportBackupDialogPage1Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nombre de archivo';
	@override String get text => 'El archivo de respaldo se guardará en la carpeta de descargas con el nombre classifier_database(1,2,3)_backup.sqlite.';
}

// Path: import_export.backup_dialog.page_2
class _StringsImportExportBackupDialogPage2Es implements _StringsImportExportBackupDialogPage2En {
	_StringsImportExportBackupDialogPage2Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aviso';
	@override String get text => 'Los nombres de los archivos guardados serán\ndatabase1_backup1\ndatabase1_backup2\n\nAl continuar realizando respaldos, puede ocupar mucho espacio. Recuerde ordenar la carpeta de descargas.';
}

// Path: search.search_dialog.page_1
class _StringsSearchSearchDialogPage1Es implements _StringsSearchSearchDialogPage1En {
	_StringsSearchSearchDialogPage1Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acerca de la página';
	@override String get text => 'En esta página, puedes buscar marcadores por etiquetas y cambiar el género de las etiquetas.';
}

// Path: search.search_dialog.page_2
class _StringsSearchSearchDialogPage2Es implements _StringsSearchSearchDialogPage2En {
	_StringsSearchSearchDialogPage2Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acerca de la búsqueda';
	@override String get text => 'Puedes buscar marcadores seleccionando etiquetas de la lista de etiquetas registradas en los marcadores.\n\nPuedes seleccionar varias etiquetas.';
}

// Path: search.search_dialog.page_3
class _StringsSearchSearchDialogPage3Es implements _StringsSearchSearchDialogPage3En {
	_StringsSearchSearchDialogPage3Es._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acerca del género';
	@override String get text => 'El género es una clasificación de las etiquetas, siendo \'Sin clasificar\' el valor predeterminado.\n\nPuedes seleccionar etiquetas y cambiar su género.';
}

// Path: home.setting_list.sort_dialog.sort_list
class _StringsHomeSettingListSortDialogSortListEs implements _StringsHomeSettingListSortDialogSortListEn {
	_StringsHomeSettingListSortDialogSortListEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get created => 'Creado en';
	@override String get updated => 'Actualizado en';
	@override String get tag => 'Etiquetas';
	@override String get genre => 'Genre';
	@override String get random => 'Random';
}

// Path: bookmark_card.setting_list.tag_dialog.and_search
class _StringsBookmarkCardSettingListTagDialogAndSearchEs implements _StringsBookmarkCardSettingListTagDialogAndSearchEn {
	_StringsBookmarkCardSettingListTagDialogAndSearchEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Qué es esto?';
	@override String get close => 'Cerrar';
	@override String get text => 'Puede buscar marcadores que incluyan la etiqueta que ha seleccionado actualmente y todas las etiquetas seleccionadas anteriormente (arriba a la izquierda).';
}

// Path: bookmark_card.setting_list.delete_dialog.snackbar
class _StringsBookmarkCardSettingListDeleteDialogSnackbarEs implements _StringsBookmarkCardSettingListDeleteDialogSnackbarEn {
	_StringsBookmarkCardSettingListDeleteDialogSnackbarEs._(this._root);

	@override final _StringsEs _root; // ignore: unused_field

	// Translations
	@override String get delete => 'Borrado completado.';
}

// Path: <root>
class _StringsJa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsJa.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsJa _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsHomeJa home = _StringsHomeJa._(_root);
	@override late final _StringsBookmarkCardJa bookmark_card = _StringsBookmarkCardJa._(_root);
	@override late final _StringsDrawerJa drawer = _StringsDrawerJa._(_root);
	@override late final _StringsAddBookmarksJa add_bookmarks = _StringsAddBookmarksJa._(_root);
	@override late final _StringsEditBookmarksJa edit_bookmarks = _StringsEditBookmarksJa._(_root);
	@override late final _StringsImportExportJa import_export = _StringsImportExportJa._(_root);
	@override late final _StringsSettingsJa settings = _StringsSettingsJa._(_root);
	@override late final _StringsSearchJa search = _StringsSearchJa._(_root);
	@override late final _StringsDatabaseJa database = _StringsDatabaseJa._(_root);
	@override late final _StringsExternalUrlJa external_url = _StringsExternalUrlJa._(_root);
	@override late final _StringsUtilsJa utils = _StringsUtilsJa._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'ja': '日本語',
		'es': 'Español',
		'pt': 'Português',
	};
}

// Path: home
class _StringsHomeJa implements _StringsHomeEn {
	_StringsHomeJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title_with_tags => '選択したタグ';
	@override late final _StringsHomeSelectedTagsDialogJa selected_tags_dialog = _StringsHomeSelectedTagsDialogJa._(_root);
	@override late final _StringsHomeSettingListJa setting_list = _StringsHomeSettingListJa._(_root);
}

// Path: bookmark_card
class _StringsBookmarkCardJa implements _StringsBookmarkCardEn {
	_StringsBookmarkCardJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override late final _StringsBookmarkCardSettingListJa setting_list = _StringsBookmarkCardSettingListJa._(_root);
}

// Path: drawer
class _StringsDrawerJa implements _StringsDrawerEn {
	_StringsDrawerJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get tags => 'タグから検索&編集';
	@override String get management => 'インポートとバックアップ';
	@override String get settings => '設定';
	@override String get inquiry => 'お問い合わせ';
}

// Path: add_bookmarks
class _StringsAddBookmarksJa implements _StringsAddBookmarksEn {
	_StringsAddBookmarksJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '追加';
	@override String get complete => '完了';
	@override String get explain => '説明';
	@override String get url => 'URL';
	@override String get input => 'タグを入力';
	@override String get select_image => '画像を選択';
	@override String get tag_show => 'ブックマークに追加するタグ';
	@override String get exist_tag => '既に存在するタグ一覧';
	@override late final _StringsAddBookmarksCompleteDialogJa complete_dialog = _StringsAddBookmarksCompleteDialogJa._(_root);
	@override late final _StringsAddBookmarksSnackbarJa snackbar = _StringsAddBookmarksSnackbarJa._(_root);
	@override late final _StringsAddBookmarksOnInsertJa on_insert = _StringsAddBookmarksOnInsertJa._(_root);
}

// Path: edit_bookmarks
class _StringsEditBookmarksJa implements _StringsEditBookmarksEn {
	_StringsEditBookmarksJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '編集';
	@override String get complete => '完了';
	@override String get explain => '説明';
	@override String get url => 'URL';
	@override String get input => 'タグを入力';
	@override String get select_image => '画像を選択';
	@override String get tag_show => '選択したタグ';
	@override String get exist_tag => '既に存在するタグ一覧';
	@override late final _StringsEditBookmarksSnackbarJa snackbar = _StringsEditBookmarksSnackbarJa._(_root);
}

// Path: import_export
class _StringsImportExportJa implements _StringsImportExportEn {
	_StringsImportExportJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'データベース管理';
	@override String get import => 'インポートについて';
	@override String get export => 'バックアップについて';
	@override String get import_button => 'インポート';
	@override String get export_button => 'バックアップ';
	@override late final _StringsImportExportImportDialogJa import_dialog = _StringsImportExportImportDialogJa._(_root);
	@override late final _StringsImportExportBackupDialogJa backup_dialog = _StringsImportExportBackupDialogJa._(_root);
	@override late final _StringsImportExportBackUpConfirmDialogJa back_up_confirm_dialog = _StringsImportExportBackUpConfirmDialogJa._(_root);
	@override late final _StringsImportExportOnImportJa on_import = _StringsImportExportOnImportJa._(_root);
	@override late final _StringsImportExportOnBackupJa on_backup = _StringsImportExportOnBackupJa._(_root);
}

// Path: settings
class _StringsSettingsJa implements _StringsSettingsEn {
	_StringsSettingsJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '設定';
	@override String get privacy_policy => 'プライバシーポリシー';
	@override String get change_theme => 'テーマ切り替え';
	@override String get change_database => 'データベースの切り替え';
	@override String get current_database => '現在のデータベース';
	@override String get language => '言語';
	@override late final _StringsSettingsDatabaseDialogJa database_dialog = _StringsSettingsDatabaseDialogJa._(_root);
	@override String get loading_dialog => '読み込み中...';
	@override late final _StringsSettingsOnChangeDatabaseJa on_change_database = _StringsSettingsOnChangeDatabaseJa._(_root);
}

// Path: search
class _StringsSearchJa implements _StringsSearchEn {
	_StringsSearchJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'タグ編集&検索';
	@override String get found => '件のブックマークが見つかりました';
	@override String get search_button => '検索';
	@override String get clear_button => 'クリア';
	@override String get change_genre => 'ジャンル変更';
	@override late final _StringsSearchSearchDialogJa search_dialog = _StringsSearchSearchDialogJa._(_root);
	@override late final _StringsSearchGenreDialogJa genre_dialog = _StringsSearchGenreDialogJa._(_root);
}

// Path: database
class _StringsDatabaseJa implements _StringsDatabaseEn {
	_StringsDatabaseJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get no_genre => '分類なし';
}

// Path: external_url
class _StringsExternalUrlJa implements _StringsExternalUrlEn {
	_StringsExternalUrlJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get privacy_policy => 'https://ez-bookmarks.pages.dev/ja/privacy-policy';
	@override String get inquiry => 'https://forms.gle/KkHYp3keoW5iepQN9';
}

// Path: utils
class _StringsUtilsJa implements _StringsUtilsEn {
	_StringsUtilsJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get unexpected => '予期せぬエラーが発生しました。';
	@override String get loading => '処理中です。';
}

// Path: home.selected_tags_dialog
class _StringsHomeSelectedTagsDialogJa implements _StringsHomeSelectedTagsDialogEn {
	_StringsHomeSelectedTagsDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '選択したタグ';
	@override String get close => '閉じる';
}

// Path: home.setting_list
class _StringsHomeSettingListJa implements _StringsHomeSettingListEn {
	_StringsHomeSettingListJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get grid => 'グリッド変更';
	@override String get sort => 'ソート';
	@override late final _StringsHomeSettingListGridDialogJa grid_dialog = _StringsHomeSettingListGridDialogJa._(_root);
	@override late final _StringsHomeSettingListSortDialogJa sort_dialog = _StringsHomeSettingListSortDialogJa._(_root);
}

// Path: bookmark_card.setting_list
class _StringsBookmarkCardSettingListJa implements _StringsBookmarkCardSettingListEn {
	_StringsBookmarkCardSettingListJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get explain => '説明';
	@override String get show_tags => 'タグ表示';
	@override String get edit => '編集';
	@override String get delete => '削除';
	@override late final _StringsBookmarkCardSettingListExpainDialogJa expain_dialog = _StringsBookmarkCardSettingListExpainDialogJa._(_root);
	@override late final _StringsBookmarkCardSettingListTagDialogJa tag_dialog = _StringsBookmarkCardSettingListTagDialogJa._(_root);
	@override late final _StringsBookmarkCardSettingListDeleteDialogJa delete_dialog = _StringsBookmarkCardSettingListDeleteDialogJa._(_root);
}

// Path: add_bookmarks.complete_dialog
class _StringsAddBookmarksCompleteDialogJa implements _StringsAddBookmarksCompleteDialogEn {
	_StringsAddBookmarksCompleteDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '完了';
	@override String get text => 'ブックマークが追加されました。\nリロードしてください。';
	@override String get close => '閉じる';
}

// Path: add_bookmarks.snackbar
class _StringsAddBookmarksSnackbarJa implements _StringsAddBookmarksSnackbarEn {
	_StringsAddBookmarksSnackbarJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'URLを入力してください。';
	@override String get existing_confirm => '既に登録されているURLです。';
}

// Path: add_bookmarks.on_insert
class _StringsAddBookmarksOnInsertJa implements _StringsAddBookmarksOnInsertEn {
	_StringsAddBookmarksOnInsertJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get genre => '分類なし';
}

// Path: edit_bookmarks.snackbar
class _StringsEditBookmarksSnackbarJa implements _StringsEditBookmarksSnackbarEn {
	_StringsEditBookmarksSnackbarJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'URLを入力してください。';
	@override String get existing_confirm => '既に登録されているURLです。';
}

// Path: import_export.import_dialog
class _StringsImportExportImportDialogJa implements _StringsImportExportImportDialogEn {
	_StringsImportExportImportDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportImportDialogPage1Ja page_1 = _StringsImportExportImportDialogPage1Ja._(_root);
	@override late final _StringsImportExportImportDialogPage2Ja page_2 = _StringsImportExportImportDialogPage2Ja._(_root);
}

// Path: import_export.backup_dialog
class _StringsImportExportBackupDialogJa implements _StringsImportExportBackupDialogEn {
	_StringsImportExportBackupDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportBackupDialogPage1Ja page_1 = _StringsImportExportBackupDialogPage1Ja._(_root);
	@override late final _StringsImportExportBackupDialogPage2Ja page_2 = _StringsImportExportBackupDialogPage2Ja._(_root);
}

// Path: import_export.back_up_confirm_dialog
class _StringsImportExportBackUpConfirmDialogJa implements _StringsImportExportBackUpConfirmDialogEn {
	_StringsImportExportBackUpConfirmDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '確認';
	@override String get text => 'バックアップを行いますか？';
	@override String get yes => 'はい';
	@override String get no => 'いいえ';
}

// Path: import_export.on_import
class _StringsImportExportOnImportJa implements _StringsImportExportOnImportEn {
	_StringsImportExportOnImportJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get complete => 'データベースがインポートされました';
}

// Path: import_export.on_backup
class _StringsImportExportOnBackupJa implements _StringsImportExportOnBackupEn {
	_StringsImportExportOnBackupJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get complete => 'データベースがバックアップされました';
}

// Path: settings.database_dialog
class _StringsSettingsDatabaseDialogJa implements _StringsSettingsDatabaseDialogEn {
	_StringsSettingsDatabaseDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '確認';
	@override String get text => 'データベースを切り替えますか？\n(3回に1回広告が表示されます)';
	@override String get yes => 'はい';
	@override String get no => 'いいえ';
}

// Path: settings.on_change_database
class _StringsSettingsOnChangeDatabaseJa implements _StringsSettingsOnChangeDatabaseEn {
	_StringsSettingsOnChangeDatabaseJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get complete => '完了';
	@override String get text => 'データベースが切り替わりました。';
	@override String get ok => 'OK';
}

// Path: search.search_dialog
class _StringsSearchSearchDialogJa implements _StringsSearchSearchDialogEn {
	_StringsSearchSearchDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override late final _StringsSearchSearchDialogPage1Ja page_1 = _StringsSearchSearchDialogPage1Ja._(_root);
	@override late final _StringsSearchSearchDialogPage2Ja page_2 = _StringsSearchSearchDialogPage2Ja._(_root);
	@override late final _StringsSearchSearchDialogPage3Ja page_3 = _StringsSearchSearchDialogPage3Ja._(_root);
}

// Path: search.genre_dialog
class _StringsSearchGenreDialogJa implements _StringsSearchGenreDialogEn {
	_StringsSearchGenreDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ジャンル変更';
	@override String get cancel => 'キャンセル';
	@override String get save => '変更';
	@override String get form => 'ジャンル名';
}

// Path: home.setting_list.grid_dialog
class _StringsHomeSettingListGridDialogJa implements _StringsHomeSettingListGridDialogEn {
	_StringsHomeSettingListGridDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'グリッド変更';
	@override String get close => '閉じる';
	@override String get grid_num => 'グリッド数';
	@override String get init_num => '初期値';
	@override String get now_num => '現在のグリッド数';
}

// Path: home.setting_list.sort_dialog
class _StringsHomeSettingListSortDialogJa implements _StringsHomeSettingListSortDialogEn {
	_StringsHomeSettingListSortDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ソート変更';
	@override String get descending => '降順';
	@override String get close => '閉じる';
	@override late final _StringsHomeSettingListSortDialogSortListJa sort_list = _StringsHomeSettingListSortDialogSortListJa._(_root);
}

// Path: bookmark_card.setting_list.expain_dialog
class _StringsBookmarkCardSettingListExpainDialogJa implements _StringsBookmarkCardSettingListExpainDialogEn {
	_StringsBookmarkCardSettingListExpainDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '説明';
	@override String get close => '閉じる';
}

// Path: bookmark_card.setting_list.tag_dialog
class _StringsBookmarkCardSettingListTagDialogJa implements _StringsBookmarkCardSettingListTagDialogEn {
	_StringsBookmarkCardSettingListTagDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'タグ一覧';
	@override String get close => '閉じる';
	@override String get search => 'And検索';
	@override late final _StringsBookmarkCardSettingListTagDialogAndSearchJa and_search = _StringsBookmarkCardSettingListTagDialogAndSearchJa._(_root);
}

// Path: bookmark_card.setting_list.delete_dialog
class _StringsBookmarkCardSettingListDeleteDialogJa implements _StringsBookmarkCardSettingListDeleteDialogEn {
	_StringsBookmarkCardSettingListDeleteDialogJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '削除確認';
	@override String get confirm => '本当に削除しますか？';
	@override String get delete => '削除';
	@override String get cancel => 'キャンセル';
	@override late final _StringsBookmarkCardSettingListDeleteDialogSnackbarJa snackbar = _StringsBookmarkCardSettingListDeleteDialogSnackbarJa._(_root);
}

// Path: import_export.import_dialog.page_1
class _StringsImportExportImportDialogPage1Ja implements _StringsImportExportImportDialogPage1En {
	_StringsImportExportImportDialogPage1Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '上書き';
	@override String get text => 'インポートすると、現在のデータベースが上書きされます。\n\nインポート前に確認を行ってください。';
}

// Path: import_export.import_dialog.page_2
class _StringsImportExportImportDialogPage2Ja implements _StringsImportExportImportDialogPage2En {
	_StringsImportExportImportDialogPage2Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'サムネイル';
	@override String get text => '表示されるサムネイルは端末の画像があるパスを参照しています。\n\n端末を変えたり、画像を端末から削除したりしてしまうとサムネイルが表示できなくなります。';
}

// Path: import_export.backup_dialog.page_1
class _StringsImportExportBackupDialogPage1Ja implements _StringsImportExportBackupDialogPage1En {
	_StringsImportExportBackupDialogPage1Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ファイル名';
	@override String get text => 'バックアップファイルはclassifier_database(1,2,3)_backup.sqlite\nという名前でダウンロードフォルダに保存されます。';
}

// Path: import_export.backup_dialog.page_2
class _StringsImportExportBackupDialogPage2Ja implements _StringsImportExportBackupDialogPage2En {
	_StringsImportExportBackupDialogPage2Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '注意';
	@override String get text => '保存されるファイルの名前は\ndatabase1_backup1\ndatabase1_backup2\nのようになります。\n\nバックアップを取り続けると容量が圧迫されます。ダウンロードフォルダの整理を忘れないようにしてください。';
}

// Path: search.search_dialog.page_1
class _StringsSearchSearchDialogPage1Ja implements _StringsSearchSearchDialogPage1En {
	_StringsSearchSearchDialogPage1Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ページについて';
	@override String get text => 'このページではタグからブックマークを検索したり、タグのジャンルを変更することができます。';
}

// Path: search.search_dialog.page_2
class _StringsSearchSearchDialogPage2Ja implements _StringsSearchSearchDialogPage2En {
	_StringsSearchSearchDialogPage2Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '検索について';
	@override String get text => 'ブックマークに登録されたタグ一覧を下から選んで検索できます。\n\nタグは複数選択できます。';
}

// Path: search.search_dialog.page_3
class _StringsSearchSearchDialogPage3Ja implements _StringsSearchSearchDialogPage3En {
	_StringsSearchSearchDialogPage3Ja._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ジャンルについて';
	@override String get text => 'ジャンルはタグを分類したもので、デフォルトは「分類なし」となっています。\n\nタグを選択し、ジャンルを変更することができます。';
}

// Path: home.setting_list.sort_dialog.sort_list
class _StringsHomeSettingListSortDialogSortListJa implements _StringsHomeSettingListSortDialogSortListEn {
	_StringsHomeSettingListSortDialogSortListJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get created => '作成日時順';
	@override String get updated => '更新日時順';
	@override String get tag => 'Tag';
	@override String get genre => 'Genre';
	@override String get random => 'Random';
}

// Path: bookmark_card.setting_list.tag_dialog.and_search
class _StringsBookmarkCardSettingListTagDialogAndSearchJa implements _StringsBookmarkCardSettingListTagDialogAndSearchEn {
	_StringsBookmarkCardSettingListTagDialogAndSearchJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'And検索とは？';
	@override String get close => '閉じる';
	@override String get text => 'あなたが今選択したタグと、既に選択したタグ(左上から見られます)全てを含むブックマークを検索できます。';
}

// Path: bookmark_card.setting_list.delete_dialog.snackbar
class _StringsBookmarkCardSettingListDeleteDialogSnackbarJa implements _StringsBookmarkCardSettingListDeleteDialogSnackbarEn {
	_StringsBookmarkCardSettingListDeleteDialogSnackbarJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get delete => '削除されました。';
}

// Path: <root>
class _StringsPt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsPt.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsPt _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsHomePt home = _StringsHomePt._(_root);
	@override late final _StringsBookmarkCardPt bookmark_card = _StringsBookmarkCardPt._(_root);
	@override late final _StringsDrawerPt drawer = _StringsDrawerPt._(_root);
	@override late final _StringsAddBookmarksPt add_bookmarks = _StringsAddBookmarksPt._(_root);
	@override late final _StringsEditBookmarksPt edit_bookmarks = _StringsEditBookmarksPt._(_root);
	@override late final _StringsImportExportPt import_export = _StringsImportExportPt._(_root);
	@override late final _StringsSettingsPt settings = _StringsSettingsPt._(_root);
	@override late final _StringsSearchPt search = _StringsSearchPt._(_root);
	@override late final _StringsExternalUrlPt external_url = _StringsExternalUrlPt._(_root);
	@override late final _StringsDatabasePt database = _StringsDatabasePt._(_root);
	@override late final _StringsUtilsPt utils = _StringsUtilsPt._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'ja': '日本語',
		'es': 'Español',
		'pt': 'Português',
	};
}

// Path: home
class _StringsHomePt implements _StringsHomeEn {
	_StringsHomePt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title_with_tags => 'Etiquetas selecionadas';
	@override late final _StringsHomeSelectedTagsDialogPt selected_tags_dialog = _StringsHomeSelectedTagsDialogPt._(_root);
	@override late final _StringsHomeSettingListPt setting_list = _StringsHomeSettingListPt._(_root);
}

// Path: bookmark_card
class _StringsBookmarkCardPt implements _StringsBookmarkCardEn {
	_StringsBookmarkCardPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsBookmarkCardSettingListPt setting_list = _StringsBookmarkCardSettingListPt._(_root);
}

// Path: drawer
class _StringsDrawerPt implements _StringsDrawerEn {
	_StringsDrawerPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get tags => 'Pesquisar e editar por tags';
	@override String get management => 'Importar e fazer backup';
	@override String get settings => 'Configurações';
	@override String get inquiry => 'Contato';
}

// Path: add_bookmarks
class _StringsAddBookmarksPt implements _StringsAddBookmarksEn {
	_StringsAddBookmarksPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Adicionar';
	@override String get complete => 'Concluído';
	@override String get explain => 'Explicar';
	@override String get url => 'URL';
	@override String get input => 'Inserir tag';
	@override String get select_image => 'Selecionar imagem';
	@override String get tag_show => 'Tags a serem adicionadas';
	@override String get exist_tag => 'Tags existentes';
	@override late final _StringsAddBookmarksCompleteDialogPt complete_dialog = _StringsAddBookmarksCompleteDialogPt._(_root);
	@override late final _StringsAddBookmarksSnackbarPt snackbar = _StringsAddBookmarksSnackbarPt._(_root);
	@override late final _StringsAddBookmarksOnInsertPt on_insert = _StringsAddBookmarksOnInsertPt._(_root);
}

// Path: edit_bookmarks
class _StringsEditBookmarksPt implements _StringsEditBookmarksEn {
	_StringsEditBookmarksPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar';
	@override String get complete => 'Concluído';
	@override String get explain => 'Explicar';
	@override String get url => 'URL';
	@override String get input => 'Inserir tag';
	@override String get select_image => 'Selecionar imagem';
	@override String get tag_show => 'Tags a serem adicionadas';
	@override String get exist_tag => 'Tags existentes';
	@override late final _StringsEditBookmarksSnackbarPt snackbar = _StringsEditBookmarksSnackbarPt._(_root);
}

// Path: import_export
class _StringsImportExportPt implements _StringsImportExportEn {
	_StringsImportExportPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gerenciamento de banco de dados';
	@override String get import => 'Sobre importação';
	@override String get export => 'Sobre exportação';
	@override String get import_button => 'Importar';
	@override String get export_button => 'Exportar';
	@override late final _StringsImportExportImportDialogPt import_dialog = _StringsImportExportImportDialogPt._(_root);
	@override late final _StringsImportExportBackupDialogPt backup_dialog = _StringsImportExportBackupDialogPt._(_root);
	@override late final _StringsImportExportBackUpConfirmDialogPt back_up_confirm_dialog = _StringsImportExportBackUpConfirmDialogPt._(_root);
	@override late final _StringsImportExportOnImportPt on_import = _StringsImportExportOnImportPt._(_root);
	@override late final _StringsImportExportOnBackupPt on_backup = _StringsImportExportOnBackupPt._(_root);
}

// Path: settings
class _StringsSettingsPt implements _StringsSettingsEn {
	_StringsSettingsPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurações';
	@override String get privacy_policy => 'Política de privacidade';
	@override String get change_theme => 'Alterar tema';
	@override String get change_database => 'Alterar banco de dados';
	@override String get current_database => 'Banco de dados atual';
	@override String get language => 'Idioma';
	@override late final _StringsSettingsDatabaseDialogPt database_dialog = _StringsSettingsDatabaseDialogPt._(_root);
	@override String get loading_dialog => 'Carregando...';
	@override late final _StringsSettingsOnChangeDatabasePt on_change_database = _StringsSettingsOnChangeDatabasePt._(_root);
}

// Path: search
class _StringsSearchPt implements _StringsSearchEn {
	_StringsSearchPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tags';
	@override String get found => 'marcadores encontrados';
	@override String get search_button => 'Pesquisar';
	@override String get clear_button => 'Limpar';
	@override String get change_genre => 'Alterar gênero';
	@override late final _StringsSearchSearchDialogPt search_dialog = _StringsSearchSearchDialogPt._(_root);
	@override late final _StringsSearchGenreDialogPt genre_dialog = _StringsSearchGenreDialogPt._(_root);
}

// Path: external_url
class _StringsExternalUrlPt implements _StringsExternalUrlEn {
	_StringsExternalUrlPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get privacy_policy => 'https://ez-bookmarks.pages.dev/en/privacy-policy';
	@override String get inquiry => 'https://forms.gle/7FnqbLNPLsCTDM3q7';
}

// Path: database
class _StringsDatabasePt implements _StringsDatabaseEn {
	_StringsDatabasePt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get no_genre => 'Sem categoria';
}

// Path: utils
class _StringsUtilsPt implements _StringsUtilsEn {
	_StringsUtilsPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get unexpected => 'Erro inesperado ocorreu';
	@override String get loading => 'carregando...';
}

// Path: home.selected_tags_dialog
class _StringsHomeSelectedTagsDialogPt implements _StringsHomeSelectedTagsDialogEn {
	_StringsHomeSelectedTagsDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'etiquetas selecionadas';
	@override String get close => 'Fechar';
}

// Path: home.setting_list
class _StringsHomeSettingListPt implements _StringsHomeSettingListEn {
	_StringsHomeSettingListPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get grid => 'Alterar grade';
	@override String get sort => 'Ordenar';
	@override late final _StringsHomeSettingListGridDialogPt grid_dialog = _StringsHomeSettingListGridDialogPt._(_root);
	@override late final _StringsHomeSettingListSortDialogPt sort_dialog = _StringsHomeSettingListSortDialogPt._(_root);
}

// Path: bookmark_card.setting_list
class _StringsBookmarkCardSettingListPt implements _StringsBookmarkCardSettingListEn {
	_StringsBookmarkCardSettingListPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get explain => 'Explicar';
	@override String get show_tags => 'Mostrar tags';
	@override String get edit => 'Editar';
	@override String get delete => 'Apagar';
	@override late final _StringsBookmarkCardSettingListExpainDialogPt expain_dialog = _StringsBookmarkCardSettingListExpainDialogPt._(_root);
	@override late final _StringsBookmarkCardSettingListTagDialogPt tag_dialog = _StringsBookmarkCardSettingListTagDialogPt._(_root);
	@override late final _StringsBookmarkCardSettingListDeleteDialogPt delete_dialog = _StringsBookmarkCardSettingListDeleteDialogPt._(_root);
}

// Path: add_bookmarks.complete_dialog
class _StringsAddBookmarksCompleteDialogPt implements _StringsAddBookmarksCompleteDialogEn {
	_StringsAddBookmarksCompleteDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Completo';
	@override String get text => 'O marcador foi adicionado. Por favor, recarregue.';
	@override String get close => 'Fechar';
}

// Path: add_bookmarks.snackbar
class _StringsAddBookmarksSnackbarPt implements _StringsAddBookmarksSnackbarEn {
	_StringsAddBookmarksSnackbarPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'Por favor, insira uma URL.';
	@override String get existing_confirm => 'Já existe um marcador com a mesma URL.';
}

// Path: add_bookmarks.on_insert
class _StringsAddBookmarksOnInsertPt implements _StringsAddBookmarksOnInsertEn {
	_StringsAddBookmarksOnInsertPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Sem categoria';
}

// Path: edit_bookmarks.snackbar
class _StringsEditBookmarksSnackbarPt implements _StringsEditBookmarksSnackbarEn {
	_StringsEditBookmarksSnackbarPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get url_confirm => 'Por favor, insira uma URL.';
	@override String get existing_confirm => 'Já existe um marcador com a mesma URL.';
}

// Path: import_export.import_dialog
class _StringsImportExportImportDialogPt implements _StringsImportExportImportDialogEn {
	_StringsImportExportImportDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportImportDialogPage1Pt page_1 = _StringsImportExportImportDialogPage1Pt._(_root);
	@override late final _StringsImportExportImportDialogPage2Pt page_2 = _StringsImportExportImportDialogPage2Pt._(_root);
}

// Path: import_export.backup_dialog
class _StringsImportExportBackupDialogPt implements _StringsImportExportBackupDialogEn {
	_StringsImportExportBackupDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsImportExportBackupDialogPage1Pt page_1 = _StringsImportExportBackupDialogPage1Pt._(_root);
	@override late final _StringsImportExportBackupDialogPage2Pt page_2 = _StringsImportExportBackupDialogPage2Pt._(_root);
}

// Path: import_export.back_up_confirm_dialog
class _StringsImportExportBackUpConfirmDialogPt implements _StringsImportExportBackUpConfirmDialogEn {
	_StringsImportExportBackUpConfirmDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar';
	@override String get text => 'Tem certeza de que deseja fazer backup do banco de dados?';
	@override String get yes => 'Sim';
	@override String get no => 'Não';
}

// Path: import_export.on_import
class _StringsImportExportOnImportPt implements _StringsImportExportOnImportEn {
	_StringsImportExportOnImportPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get complete => 'Importação concluída';
}

// Path: import_export.on_backup
class _StringsImportExportOnBackupPt implements _StringsImportExportOnBackupEn {
	_StringsImportExportOnBackupPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get complete => 'Backup concluído';
}

// Path: settings.database_dialog
class _StringsSettingsDatabaseDialogPt implements _StringsSettingsDatabaseDialogEn {
	_StringsSettingsDatabaseDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar';
	@override String get text => 'Tem certeza de que deseja alterar o banco de dados?(Um anúncio será exibido a cada três vezes.)';
	@override String get yes => 'Sim';
	@override String get no => 'Não';
}

// Path: settings.on_change_database
class _StringsSettingsOnChangeDatabasePt implements _StringsSettingsOnChangeDatabaseEn {
	_StringsSettingsOnChangeDatabasePt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get complete => 'Concluído';
	@override String get text => 'O banco de dados foi alterado.';
	@override String get ok => 'OK';
}

// Path: search.search_dialog
class _StringsSearchSearchDialogPt implements _StringsSearchSearchDialogEn {
	_StringsSearchSearchDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override late final _StringsSearchSearchDialogPage1Pt page_1 = _StringsSearchSearchDialogPage1Pt._(_root);
	@override late final _StringsSearchSearchDialogPage2Pt page_2 = _StringsSearchSearchDialogPage2Pt._(_root);
	@override late final _StringsSearchSearchDialogPage3Pt page_3 = _StringsSearchSearchDialogPage3Pt._(_root);
}

// Path: search.genre_dialog
class _StringsSearchGenreDialogPt implements _StringsSearchGenreDialogEn {
	_StringsSearchGenreDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar gênero';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Salvar';
	@override String get form => 'Nome do gênero';
}

// Path: home.setting_list.grid_dialog
class _StringsHomeSettingListGridDialogPt implements _StringsHomeSettingListGridDialogEn {
	_StringsHomeSettingListGridDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Alterar grade';
	@override String get close => 'Fechar';
	@override String get grid_num => 'Número da grade';
	@override String get init_num => 'inicial';
	@override String get now_num => 'atual';
}

// Path: home.setting_list.sort_dialog
class _StringsHomeSettingListSortDialogPt implements _StringsHomeSettingListSortDialogEn {
	_StringsHomeSettingListSortDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Alterar ordenação';
	@override String get descending => 'Descendente';
	@override String get close => 'Fechar';
	@override late final _StringsHomeSettingListSortDialogSortListPt sort_list = _StringsHomeSettingListSortDialogSortListPt._(_root);
}

// Path: bookmark_card.setting_list.expain_dialog
class _StringsBookmarkCardSettingListExpainDialogPt implements _StringsBookmarkCardSettingListExpainDialogEn {
	_StringsBookmarkCardSettingListExpainDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explicar';
	@override String get close => 'Fechar';
}

// Path: bookmark_card.setting_list.tag_dialog
class _StringsBookmarkCardSettingListTagDialogPt implements _StringsBookmarkCardSettingListTagDialogEn {
	_StringsBookmarkCardSettingListTagDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tags';
	@override String get close => 'Fechar';
	@override String get search => '+Pesquisar';
	@override late final _StringsBookmarkCardSettingListTagDialogAndSearchPt and_search = _StringsBookmarkCardSettingListTagDialogAndSearchPt._(_root);
}

// Path: bookmark_card.setting_list.delete_dialog
class _StringsBookmarkCardSettingListDeleteDialogPt implements _StringsBookmarkCardSettingListDeleteDialogEn {
	_StringsBookmarkCardSettingListDeleteDialogPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirmar exclusão';
	@override String get confirm => 'Tem certeza de que deseja apagar?';
	@override String get delete => 'Apagar';
	@override String get cancel => 'Cancelar';
	@override late final _StringsBookmarkCardSettingListDeleteDialogSnackbarPt snackbar = _StringsBookmarkCardSettingListDeleteDialogSnackbarPt._(_root);
}

// Path: import_export.import_dialog.page_1
class _StringsImportExportImportDialogPage1Pt implements _StringsImportExportImportDialogPage1En {
	_StringsImportExportImportDialogPage1Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sobrescrever';
	@override String get text => 'Ao importar, o banco de dados atual será sobrescrito. Por favor, confirme antes de importar.';
}

// Path: import_export.import_dialog.page_2
class _StringsImportExportImportDialogPage2Pt implements _StringsImportExportImportDialogPage2En {
	_StringsImportExportImportDialogPage2Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Miniatura';
	@override String get text => 'As miniaturas exibidas referenciam o caminho das imagens no dispositivo. Mudar de dispositivo ou excluir imagens do dispositivo resultará nas miniaturas não sendo capazes de exibir. Por favor, note que se você selecionou uma imagem,...';
}

// Path: import_export.backup_dialog.page_1
class _StringsImportExportBackupDialogPage1Pt implements _StringsImportExportBackupDialogPage1En {
	_StringsImportExportBackupDialogPage1Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nome do arquivo';
	@override String get text => 'O arquivo de backup será salvo na pasta de downloads com o nome \'classifier_database(1,2,3)_backup.sqlite\'.';
}

// Path: import_export.backup_dialog.page_2
class _StringsImportExportBackupDialogPage2Pt implements _StringsImportExportBackupDialogPage2En {
	_StringsImportExportBackupDialogPage2Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Atenção';
	@override String get text => 'Os arquivos serão salvos com nomes como \'database1_backup1\', \'database1_backup2\' e assim por diante.\n\nContinuar fazendo backups consumirá espaço de armazenamento. Por favor, lembre-se de organizar sua pasta de downloads.';
}

// Path: search.search_dialog.page_1
class _StringsSearchSearchDialogPage1Pt implements _StringsSearchSearchDialogPage1En {
	_StringsSearchSearchDialogPage1Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sobre esta página';
	@override String get text => 'Nesta página, você pode pesquisar marcadores por tags e alterar o gênero das tags.';
}

// Path: search.search_dialog.page_2
class _StringsSearchSearchDialogPage2Pt implements _StringsSearchSearchDialogPage2En {
	_StringsSearchSearchDialogPage2Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sobre a pesquisa';
	@override String get text => 'Você pode pesquisar marcadores selecionando tags da lista abaixo.\n\nVárias tags podem ser selecionadas.';
}

// Path: search.search_dialog.page_3
class _StringsSearchSearchDialogPage3Pt implements _StringsSearchSearchDialogPage3En {
	_StringsSearchSearchDialogPage3Pt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sobre gênero';
	@override String get text => 'O gênero é uma classificação de tags, sendo \'Sem categoria\' o padrão.\n\nVocê pode selecionar tags e alterar o gênero.';
}

// Path: home.setting_list.sort_dialog.sort_list
class _StringsHomeSettingListSortDialogSortListPt implements _StringsHomeSettingListSortDialogSortListEn {
	_StringsHomeSettingListSortDialogSortListPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get created => 'Criado em';
	@override String get updated => 'Atualizado em';
	@override String get tag => 'Tag';
	@override String get genre => 'Gênero';
	@override String get random => 'Aleatório';
}

// Path: bookmark_card.setting_list.tag_dialog.and_search
class _StringsBookmarkCardSettingListTagDialogAndSearchPt implements _StringsBookmarkCardSettingListTagDialogAndSearchEn {
	_StringsBookmarkCardSettingListTagDialogAndSearchPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O que é +Pesquisar?';
	@override String get close => 'Fechar';
	@override String get text => 'Você pode pesquisar marcadores que incluem a tag que você selecionou atualmente e todas as tags selecionadas anteriormente (no canto superior esquerdo).';
}

// Path: bookmark_card.setting_list.delete_dialog.snackbar
class _StringsBookmarkCardSettingListDeleteDialogSnackbarPt implements _StringsBookmarkCardSettingListDeleteDialogSnackbarEn {
	_StringsBookmarkCardSettingListDeleteDialogSnackbarPt._(this._root);

	@override final _StringsPt _root; // ignore: unused_field

	// Translations
	@override String get delete => 'Apagado';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title_with_tags': return 'Selected tags';
			case 'home.selected_tags_dialog.title': return 'selected tags';
			case 'home.selected_tags_dialog.close': return 'Close';
			case 'home.setting_list.grid': return 'Change Grid';
			case 'home.setting_list.sort': return 'Sort';
			case 'home.setting_list.grid_dialog.title': return 'Change Grid';
			case 'home.setting_list.grid_dialog.close': return 'Close';
			case 'home.setting_list.grid_dialog.grid_num': return 'Grid Num';
			case 'home.setting_list.grid_dialog.init_num': return 'initial';
			case 'home.setting_list.grid_dialog.now_num': return 'now';
			case 'home.setting_list.sort_dialog.title': return 'Change Sort';
			case 'home.setting_list.sort_dialog.descending': return 'Descending';
			case 'home.setting_list.sort_dialog.close': return 'Close';
			case 'home.setting_list.sort_dialog.sort_list.created': return 'CreatedAt';
			case 'home.setting_list.sort_dialog.sort_list.updated': return 'UpdatedAt';
			case 'home.setting_list.sort_dialog.sort_list.tag': return 'Tag';
			case 'home.setting_list.sort_dialog.sort_list.genre': return 'Genre';
			case 'home.setting_list.sort_dialog.sort_list.random': return 'Random';
			case 'bookmark_card.setting_list.explain': return 'Explain';
			case 'bookmark_card.setting_list.show_tags': return 'Show Tags';
			case 'bookmark_card.setting_list.edit': return 'Edit';
			case 'bookmark_card.setting_list.delete': return 'Delete';
			case 'bookmark_card.setting_list.expain_dialog.title': return 'Explain';
			case 'bookmark_card.setting_list.expain_dialog.close': return 'Close';
			case 'bookmark_card.setting_list.tag_dialog.title': return 'Tags';
			case 'bookmark_card.setting_list.tag_dialog.close': return 'Close';
			case 'bookmark_card.setting_list.tag_dialog.search': return '+Search';
			case 'bookmark_card.setting_list.tag_dialog.and_search.title': return 'What is +Search?';
			case 'bookmark_card.setting_list.tag_dialog.and_search.close': return 'Close';
			case 'bookmark_card.setting_list.tag_dialog.and_search.text': return 'You can search for bookmarks that include the tag you have currently selected and all previously selected tags (top left).';
			case 'bookmark_card.setting_list.delete_dialog.title': return 'Confirm Delete';
			case 'bookmark_card.setting_list.delete_dialog.confirm': return 'Sure to delete?';
			case 'bookmark_card.setting_list.delete_dialog.delete': return 'Delete';
			case 'bookmark_card.setting_list.delete_dialog.cancel': return 'Cancel';
			case 'bookmark_card.setting_list.delete_dialog.snackbar.delete': return 'Deleted';
			case 'drawer.tags': return 'Search & Edit by Tags';
			case 'drawer.management': return 'Import and Backup';
			case 'drawer.settings': return 'Settings';
			case 'drawer.inquiry': return 'Contact';
			case 'add_bookmarks.title': return 'Add';
			case 'add_bookmarks.complete': return 'Done';
			case 'add_bookmarks.explain': return 'Explain';
			case 'add_bookmarks.url': return 'URL';
			case 'add_bookmarks.input': return 'Input Tag';
			case 'add_bookmarks.select_image': return 'Select Image';
			case 'add_bookmarks.tag_show': return 'Tags to be added';
			case 'add_bookmarks.exist_tag': return 'Existing Tags';
			case 'add_bookmarks.complete_dialog.title': return 'Complete';
			case 'add_bookmarks.complete_dialog.text': return 'The bookmark has been added. Please reload.';
			case 'add_bookmarks.complete_dialog.close': return 'Close';
			case 'add_bookmarks.snackbar.url_confirm': return 'Please enter a URL.';
			case 'add_bookmarks.snackbar.existing_confirm': return 'A bookmark with the same URL already exists.';
			case 'add_bookmarks.on_insert.genre': return 'Uncategorized';
			case 'edit_bookmarks.title': return 'Edit';
			case 'edit_bookmarks.complete': return 'Done';
			case 'edit_bookmarks.explain': return 'Explain';
			case 'edit_bookmarks.url': return 'URL';
			case 'edit_bookmarks.input': return 'Input Tag';
			case 'edit_bookmarks.select_image': return 'Select Image';
			case 'edit_bookmarks.tag_show': return 'Tags to be added';
			case 'edit_bookmarks.exist_tag': return 'Existing Tags';
			case 'edit_bookmarks.snackbar.url_confirm': return 'Please enter a URL.';
			case 'edit_bookmarks.snackbar.existing_confirm': return 'A bookmark with the same URL already exists.';
			case 'import_export.title': return 'Database Management';
			case 'import_export.import': return 'About Import';
			case 'import_export.export': return 'About Export';
			case 'import_export.import_button': return 'Import';
			case 'import_export.export_button': return 'Export';
			case 'import_export.import_dialog.page_1.title': return 'Overwrite';
			case 'import_export.import_dialog.page_1.text': return 'When importing, the current database will be overwritten. Please confirm before importing.';
			case 'import_export.import_dialog.page_2.title': return 'Thumbnail';
			case 'import_export.import_dialog.page_2.text': return 'The displayed thumbnails reference the path of images on the device. Changing devices or deleting images from the device will result in the thumbnails being unable to display. Please note that if you have selected an image,...';
			case 'import_export.backup_dialog.page_1.title': return 'File Name';
			case 'import_export.backup_dialog.page_1.text': return 'The backup file will be saved in the download folder with the name \'classifier_database(1,2,3)_backup.sqlite\'.';
			case 'import_export.backup_dialog.page_2.title': return 'Attention';
			case 'import_export.backup_dialog.page_2.text': return 'The files will be saved with names like \'database1_backup1\', \'database1_backup2\', and so on.\n\nContinuing to make backups will consume storage space. Please remember to organize your download folder.';
			case 'import_export.back_up_confirm_dialog.title': return 'Confirm';
			case 'import_export.back_up_confirm_dialog.text': return 'Are you sure you want to back up the database?';
			case 'import_export.back_up_confirm_dialog.yes': return 'Yes';
			case 'import_export.back_up_confirm_dialog.no': return 'No';
			case 'import_export.on_import.complete': return 'Import Completed';
			case 'import_export.on_backup.complete': return 'Backup Completed';
			case 'settings.title': return 'Settings';
			case 'settings.privacy_policy': return 'Privacy Policy';
			case 'settings.change_theme': return 'Change Theme';
			case 'settings.change_database': return 'Change Database';
			case 'settings.current_database': return 'Current Database';
			case 'settings.language': return 'Language';
			case 'settings.database_dialog.title': return 'Confirm';
			case 'settings.database_dialog.text': return 'Are you sure you want to change the database?(An advertisement will play every three times.)';
			case 'settings.database_dialog.yes': return 'Yes';
			case 'settings.database_dialog.no': return 'No';
			case 'settings.loading_dialog': return 'Loading...';
			case 'settings.on_change_database.complete': return 'Completed';
			case 'settings.on_change_database.text': return 'Database has been switched.';
			case 'settings.on_change_database.ok': return 'OK';
			case 'search.title': return 'Tags';
			case 'search.found': return 'bookmarks found';
			case 'search.search_button': return 'Search';
			case 'search.clear_button': return 'Clear';
			case 'search.change_genre': return 'Change Genre';
			case 'search.search_dialog.page_1.title': return 'About this page';
			case 'search.search_dialog.page_1.text': return 'On this page, you can search bookmarks by tags and change the genre of tags.';
			case 'search.search_dialog.page_2.title': return 'About search';
			case 'search.search_dialog.page_2.text': return 'You can search bookmarks by selecting tags from the list below.\n\nMultiple tags can be selected.';
			case 'search.search_dialog.page_3.title': return 'About Genre';
			case 'search.search_dialog.page_3.text': return 'The genre is a classification of tags, with the default being \'Uncategorized.\'\n\nYou can select tags and change the genre.';
			case 'search.genre_dialog.title': return 'Edit Genre';
			case 'search.genre_dialog.cancel': return 'Cancel';
			case 'search.genre_dialog.save': return 'Save';
			case 'search.genre_dialog.form': return 'Genre Name';
			case 'external_url.privacy_policy': return 'https://ez-bookmarks.pages.dev/en/privacy-policy';
			case 'external_url.inquiry': return 'https://forms.gle/7FnqbLNPLsCTDM3q7';
			case 'database.no_genre': return 'Uncategorized';
			case 'utils.unexpected': return 'unexpected error occured';
			case 'utils.loading': return 'now loading...';
			case 'locales.en': return 'English';
			case 'locales.ja': return '日本語';
			case 'locales.es': return 'Español';
			case 'locales.pt': return 'Português';
			default: return null;
		}
	}
}

extension on _StringsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title_with_tags': return 'Etiquetas seleccionados.';
			case 'home.selected_tags_dialog.title': return 'Etiquetas seleccionados.';
			case 'home.selected_tags_dialog.close': return 'Cerrar';
			case 'home.setting_list.grid': return 'Cambiar rejilla';
			case 'home.setting_list.sort': return 'Ordenar';
			case 'home.setting_list.grid_dialog.title': return 'Cambiar rejilla';
			case 'home.setting_list.grid_dialog.close': return 'Cerrar';
			case 'home.setting_list.grid_dialog.grid_num': return 'Número de rejilla';
			case 'home.setting_list.grid_dialog.init_num': return 'inicial';
			case 'home.setting_list.grid_dialog.now_num': return 'ahora';
			case 'home.setting_list.sort_dialog.title': return 'Cambiar Ordenar';
			case 'home.setting_list.sort_dialog.descending': return 'Descendente';
			case 'home.setting_list.sort_dialog.close': return 'Cerrar';
			case 'home.setting_list.sort_dialog.sort_list.created': return 'Creado en';
			case 'home.setting_list.sort_dialog.sort_list.updated': return 'Actualizado en';
			case 'home.setting_list.sort_dialog.sort_list.tag': return 'Etiquetas';
			case 'home.setting_list.sort_dialog.sort_list.genre': return 'Genre';
			case 'home.setting_list.sort_dialog.sort_list.random': return 'Random';
			case 'bookmark_card.setting_list.explain': return 'Descripción.';
			case 'bookmark_card.setting_list.show_tags': return 'Mostrar etiquetas.';
			case 'bookmark_card.setting_list.edit': return 'Editar';
			case 'bookmark_card.setting_list.delete': return 'Borrar';
			case 'bookmark_card.setting_list.expain_dialog.title': return 'Descripción.';
			case 'bookmark_card.setting_list.expain_dialog.close': return 'Cerrar';
			case 'bookmark_card.setting_list.tag_dialog.title': return 'Etiquetas';
			case 'bookmark_card.setting_list.tag_dialog.close': return 'Cerrar';
			case 'bookmark_card.setting_list.tag_dialog.search': return '+Buscar';
			case 'bookmark_card.setting_list.tag_dialog.and_search.title': return '¿Qué es esto?';
			case 'bookmark_card.setting_list.tag_dialog.and_search.close': return 'Cerrar';
			case 'bookmark_card.setting_list.tag_dialog.and_search.text': return 'Puede buscar marcadores que incluyan la etiqueta que ha seleccionado actualmente y todas las etiquetas seleccionadas anteriormente (arriba a la izquierda).';
			case 'bookmark_card.setting_list.delete_dialog.title': return 'Confirmar la eliminación';
			case 'bookmark_card.setting_list.delete_dialog.confirm': return '¿Seguro que desea borrar?';
			case 'bookmark_card.setting_list.delete_dialog.delete': return 'borrar';
			case 'bookmark_card.setting_list.delete_dialog.cancel': return 'Cancelar';
			case 'bookmark_card.setting_list.delete_dialog.snackbar.delete': return 'Borrado completado.';
			case 'drawer.tags': return 'Buscar y editar por etiquetas';
			case 'drawer.management': return 'Importación y copia de seguridad';
			case 'drawer.settings': return 'Configuración';
			case 'drawer.inquiry': return 'Contacto';
			case 'add_bookmarks.title': return 'Añadir';
			case 'add_bookmarks.complete': return 'Hecho';
			case 'add_bookmarks.explain': return 'Explicar';
			case 'add_bookmarks.url': return 'URL';
			case 'add_bookmarks.input': return 'Input etiquetas';
			case 'add_bookmarks.select_image': return 'Seleccionar imagen';
			case 'add_bookmarks.tag_show': return 'Etiquetas a añadir';
			case 'add_bookmarks.exist_tag': return 'Etiquetas existentes';
			case 'add_bookmarks.complete_dialog.title': return 'Completo';
			case 'add_bookmarks.complete_dialog.text': return 'El marcador se ha añadido. Por favor, vuelva a cargarlo';
			case 'add_bookmarks.complete_dialog.close': return 'Cerrar';
			case 'add_bookmarks.snackbar.url_confirm': return 'Por favor, introduzca una URL.';
			case 'add_bookmarks.snackbar.existing_confirm': return 'Ya existe un marcador con la misma URL.';
			case 'add_bookmarks.on_insert.genre': return 'Sin categorizar';
			case 'edit_bookmarks.title': return 'Editar';
			case 'edit_bookmarks.complete': return 'Completar';
			case 'edit_bookmarks.explain': return 'Explicación';
			case 'edit_bookmarks.url': return 'URL';
			case 'edit_bookmarks.input': return 'Introducir etiquetas';
			case 'edit_bookmarks.select_image': return 'Seleccionar imagen';
			case 'edit_bookmarks.tag_show': return 'Etiquetas seleccionadas';
			case 'edit_bookmarks.exist_tag': return 'Lista de etiquetas existentes';
			case 'edit_bookmarks.snackbar.url_confirm': return 'Por favor, introduzca una URL.';
			case 'edit_bookmarks.snackbar.existing_confirm': return 'La URL ya está registrada.';
			case 'import_export.title': return 'Gestión de la base de datos';
			case 'import_export.import': return 'Importar';
			case 'import_export.export': return 'Exportar';
			case 'import_export.import_button': return 'Importar';
			case 'import_export.export_button': return 'Exportar';
			case 'import_export.import_dialog.page_1.title': return 'Sobrescribir';
			case 'import_export.import_dialog.page_1.text': return 'Al importar, la base de datos actual se sobrescribirá.\n\nPor favor, confirme antes de importar.';
			case 'import_export.import_dialog.page_2.title': return 'Miniaturas';
			case 'import_export.import_dialog.page_2.text': return 'Las miniaturas mostradas hacen referencia a la ruta de las imágenes en el dispositivo.\n\nSi cambia de dispositivo o elimina las imágenes del dispositivo, las miniaturas pueden dejar de mostrarse.';
			case 'import_export.backup_dialog.page_1.title': return 'Nombre de archivo';
			case 'import_export.backup_dialog.page_1.text': return 'El archivo de respaldo se guardará en la carpeta de descargas con el nombre classifier_database(1,2,3)_backup.sqlite.';
			case 'import_export.backup_dialog.page_2.title': return 'Aviso';
			case 'import_export.backup_dialog.page_2.text': return 'Los nombres de los archivos guardados serán\ndatabase1_backup1\ndatabase1_backup2\n\nAl continuar realizando respaldos, puede ocupar mucho espacio. Recuerde ordenar la carpeta de descargas.';
			case 'import_export.back_up_confirm_dialog.title': return 'Confirmación';
			case 'import_export.back_up_confirm_dialog.text': return '¿Desea realizar una copia de seguridad?';
			case 'import_export.back_up_confirm_dialog.yes': return 'Sí';
			case 'import_export.back_up_confirm_dialog.no': return 'No';
			case 'import_export.on_import.complete': return 'La base de datos ha sido importada.';
			case 'import_export.on_backup.complete': return 'La base de datos ha sido respaldada.';
			case 'settings.title': return 'Configuración';
			case 'settings.privacy_policy': return 'Política de privacidad';
			case 'settings.change_theme': return 'Cambiar tema';
			case 'settings.change_database': return 'Cambiar base de datos';
			case 'settings.current_database': return 'Base de datos actual';
			case 'settings.language': return 'Idioma';
			case 'settings.database_dialog.title': return 'Confirmación';
			case 'settings.database_dialog.text': return '¿Desea cambiar la base de datos?\n(Se mostrará un anuncio cada 3 cambios)';
			case 'settings.database_dialog.yes': return 'Sí';
			case 'settings.database_dialog.no': return 'No';
			case 'settings.loading_dialog': return 'Cargando...';
			case 'settings.on_change_database.complete': return 'Completo';
			case 'settings.on_change_database.text': return 'La base de datos ha sido cambiada.';
			case 'settings.on_change_database.ok': return 'OK';
			case 'search.title': return 'Editar y buscar por etiquetas';
			case 'search.found': return 'Marcadores encontrados';
			case 'search.search_button': return 'Buscar';
			case 'search.clear_button': return 'Limpiar';
			case 'search.change_genre': return 'Cambiar género';
			case 'search.search_dialog.page_1.title': return 'Acerca de la página';
			case 'search.search_dialog.page_1.text': return 'En esta página, puedes buscar marcadores por etiquetas y cambiar el género de las etiquetas.';
			case 'search.search_dialog.page_2.title': return 'Acerca de la búsqueda';
			case 'search.search_dialog.page_2.text': return 'Puedes buscar marcadores seleccionando etiquetas de la lista de etiquetas registradas en los marcadores.\n\nPuedes seleccionar varias etiquetas.';
			case 'search.search_dialog.page_3.title': return 'Acerca del género';
			case 'search.search_dialog.page_3.text': return 'El género es una clasificación de las etiquetas, siendo \'Sin clasificar\' el valor predeterminado.\n\nPuedes seleccionar etiquetas y cambiar su género.';
			case 'search.genre_dialog.title': return 'Cambiar género';
			case 'search.genre_dialog.cancel': return 'Cancelar';
			case 'search.genre_dialog.save': return 'Guardar';
			case 'search.genre_dialog.form': return 'Nombre del género';
			case 'database.no_genre': return 'Sin categoría';
			case 'external_url.privacy_policy': return 'https://ez-bookmarks.pages.dev/en/privacy-policy';
			case 'external_url.inquiry': return 'https://forms.gle/7FnqbLNPLsCTDM3q7';
			case 'utils.unexpected': return 'Se ha producido un error inesperado.';
			case 'utils.loading': return 'Cargando...';
			case 'locales.en': return 'English';
			case 'locales.ja': return '日本語';
			case 'locales.es': return 'Español';
			case 'locales.pt': return 'Português';
			default: return null;
		}
	}
}

extension on _StringsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title_with_tags': return '選択したタグ';
			case 'home.selected_tags_dialog.title': return '選択したタグ';
			case 'home.selected_tags_dialog.close': return '閉じる';
			case 'home.setting_list.grid': return 'グリッド変更';
			case 'home.setting_list.sort': return 'ソート';
			case 'home.setting_list.grid_dialog.title': return 'グリッド変更';
			case 'home.setting_list.grid_dialog.close': return '閉じる';
			case 'home.setting_list.grid_dialog.grid_num': return 'グリッド数';
			case 'home.setting_list.grid_dialog.init_num': return '初期値';
			case 'home.setting_list.grid_dialog.now_num': return '現在のグリッド数';
			case 'home.setting_list.sort_dialog.title': return 'ソート変更';
			case 'home.setting_list.sort_dialog.descending': return '降順';
			case 'home.setting_list.sort_dialog.close': return '閉じる';
			case 'home.setting_list.sort_dialog.sort_list.created': return '作成日時順';
			case 'home.setting_list.sort_dialog.sort_list.updated': return '更新日時順';
			case 'home.setting_list.sort_dialog.sort_list.tag': return 'Tag';
			case 'home.setting_list.sort_dialog.sort_list.genre': return 'Genre';
			case 'home.setting_list.sort_dialog.sort_list.random': return 'Random';
			case 'bookmark_card.setting_list.explain': return '説明';
			case 'bookmark_card.setting_list.show_tags': return 'タグ表示';
			case 'bookmark_card.setting_list.edit': return '編集';
			case 'bookmark_card.setting_list.delete': return '削除';
			case 'bookmark_card.setting_list.expain_dialog.title': return '説明';
			case 'bookmark_card.setting_list.expain_dialog.close': return '閉じる';
			case 'bookmark_card.setting_list.tag_dialog.title': return 'タグ一覧';
			case 'bookmark_card.setting_list.tag_dialog.close': return '閉じる';
			case 'bookmark_card.setting_list.tag_dialog.search': return 'And検索';
			case 'bookmark_card.setting_list.tag_dialog.and_search.title': return 'And検索とは？';
			case 'bookmark_card.setting_list.tag_dialog.and_search.close': return '閉じる';
			case 'bookmark_card.setting_list.tag_dialog.and_search.text': return 'あなたが今選択したタグと、既に選択したタグ(左上から見られます)全てを含むブックマークを検索できます。';
			case 'bookmark_card.setting_list.delete_dialog.title': return '削除確認';
			case 'bookmark_card.setting_list.delete_dialog.confirm': return '本当に削除しますか？';
			case 'bookmark_card.setting_list.delete_dialog.delete': return '削除';
			case 'bookmark_card.setting_list.delete_dialog.cancel': return 'キャンセル';
			case 'bookmark_card.setting_list.delete_dialog.snackbar.delete': return '削除されました。';
			case 'drawer.tags': return 'タグから検索&編集';
			case 'drawer.management': return 'インポートとバックアップ';
			case 'drawer.settings': return '設定';
			case 'drawer.inquiry': return 'お問い合わせ';
			case 'add_bookmarks.title': return '追加';
			case 'add_bookmarks.complete': return '完了';
			case 'add_bookmarks.explain': return '説明';
			case 'add_bookmarks.url': return 'URL';
			case 'add_bookmarks.input': return 'タグを入力';
			case 'add_bookmarks.select_image': return '画像を選択';
			case 'add_bookmarks.tag_show': return 'ブックマークに追加するタグ';
			case 'add_bookmarks.exist_tag': return '既に存在するタグ一覧';
			case 'add_bookmarks.complete_dialog.title': return '完了';
			case 'add_bookmarks.complete_dialog.text': return 'ブックマークが追加されました。\nリロードしてください。';
			case 'add_bookmarks.complete_dialog.close': return '閉じる';
			case 'add_bookmarks.snackbar.url_confirm': return 'URLを入力してください。';
			case 'add_bookmarks.snackbar.existing_confirm': return '既に登録されているURLです。';
			case 'add_bookmarks.on_insert.genre': return '分類なし';
			case 'edit_bookmarks.title': return '編集';
			case 'edit_bookmarks.complete': return '完了';
			case 'edit_bookmarks.explain': return '説明';
			case 'edit_bookmarks.url': return 'URL';
			case 'edit_bookmarks.input': return 'タグを入力';
			case 'edit_bookmarks.select_image': return '画像を選択';
			case 'edit_bookmarks.tag_show': return '選択したタグ';
			case 'edit_bookmarks.exist_tag': return '既に存在するタグ一覧';
			case 'edit_bookmarks.snackbar.url_confirm': return 'URLを入力してください。';
			case 'edit_bookmarks.snackbar.existing_confirm': return '既に登録されているURLです。';
			case 'import_export.title': return 'データベース管理';
			case 'import_export.import': return 'インポートについて';
			case 'import_export.export': return 'バックアップについて';
			case 'import_export.import_button': return 'インポート';
			case 'import_export.export_button': return 'バックアップ';
			case 'import_export.import_dialog.page_1.title': return '上書き';
			case 'import_export.import_dialog.page_1.text': return 'インポートすると、現在のデータベースが上書きされます。\n\nインポート前に確認を行ってください。';
			case 'import_export.import_dialog.page_2.title': return 'サムネイル';
			case 'import_export.import_dialog.page_2.text': return '表示されるサムネイルは端末の画像があるパスを参照しています。\n\n端末を変えたり、画像を端末から削除したりしてしまうとサムネイルが表示できなくなります。';
			case 'import_export.backup_dialog.page_1.title': return 'ファイル名';
			case 'import_export.backup_dialog.page_1.text': return 'バックアップファイルはclassifier_database(1,2,3)_backup.sqlite\nという名前でダウンロードフォルダに保存されます。';
			case 'import_export.backup_dialog.page_2.title': return '注意';
			case 'import_export.backup_dialog.page_2.text': return '保存されるファイルの名前は\ndatabase1_backup1\ndatabase1_backup2\nのようになります。\n\nバックアップを取り続けると容量が圧迫されます。ダウンロードフォルダの整理を忘れないようにしてください。';
			case 'import_export.back_up_confirm_dialog.title': return '確認';
			case 'import_export.back_up_confirm_dialog.text': return 'バックアップを行いますか？';
			case 'import_export.back_up_confirm_dialog.yes': return 'はい';
			case 'import_export.back_up_confirm_dialog.no': return 'いいえ';
			case 'import_export.on_import.complete': return 'データベースがインポートされました';
			case 'import_export.on_backup.complete': return 'データベースがバックアップされました';
			case 'settings.title': return '設定';
			case 'settings.privacy_policy': return 'プライバシーポリシー';
			case 'settings.change_theme': return 'テーマ切り替え';
			case 'settings.change_database': return 'データベースの切り替え';
			case 'settings.current_database': return '現在のデータベース';
			case 'settings.language': return '言語';
			case 'settings.database_dialog.title': return '確認';
			case 'settings.database_dialog.text': return 'データベースを切り替えますか？\n(3回に1回広告が表示されます)';
			case 'settings.database_dialog.yes': return 'はい';
			case 'settings.database_dialog.no': return 'いいえ';
			case 'settings.loading_dialog': return '読み込み中...';
			case 'settings.on_change_database.complete': return '完了';
			case 'settings.on_change_database.text': return 'データベースが切り替わりました。';
			case 'settings.on_change_database.ok': return 'OK';
			case 'search.title': return 'タグ編集&検索';
			case 'search.found': return '件のブックマークが見つかりました';
			case 'search.search_button': return '検索';
			case 'search.clear_button': return 'クリア';
			case 'search.change_genre': return 'ジャンル変更';
			case 'search.search_dialog.page_1.title': return 'ページについて';
			case 'search.search_dialog.page_1.text': return 'このページではタグからブックマークを検索したり、タグのジャンルを変更することができます。';
			case 'search.search_dialog.page_2.title': return '検索について';
			case 'search.search_dialog.page_2.text': return 'ブックマークに登録されたタグ一覧を下から選んで検索できます。\n\nタグは複数選択できます。';
			case 'search.search_dialog.page_3.title': return 'ジャンルについて';
			case 'search.search_dialog.page_3.text': return 'ジャンルはタグを分類したもので、デフォルトは「分類なし」となっています。\n\nタグを選択し、ジャンルを変更することができます。';
			case 'search.genre_dialog.title': return 'ジャンル変更';
			case 'search.genre_dialog.cancel': return 'キャンセル';
			case 'search.genre_dialog.save': return '変更';
			case 'search.genre_dialog.form': return 'ジャンル名';
			case 'database.no_genre': return '分類なし';
			case 'external_url.privacy_policy': return 'https://ez-bookmarks.pages.dev/ja/privacy-policy';
			case 'external_url.inquiry': return 'https://forms.gle/KkHYp3keoW5iepQN9';
			case 'utils.unexpected': return '予期せぬエラーが発生しました。';
			case 'utils.loading': return '処理中です。';
			case 'locales.en': return 'English';
			case 'locales.ja': return '日本語';
			case 'locales.es': return 'Español';
			case 'locales.pt': return 'Português';
			default: return null;
		}
	}
}

extension on _StringsPt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title_with_tags': return 'Etiquetas selecionadas';
			case 'home.selected_tags_dialog.title': return 'etiquetas selecionadas';
			case 'home.selected_tags_dialog.close': return 'Fechar';
			case 'home.setting_list.grid': return 'Alterar grade';
			case 'home.setting_list.sort': return 'Ordenar';
			case 'home.setting_list.grid_dialog.title': return 'Alterar grade';
			case 'home.setting_list.grid_dialog.close': return 'Fechar';
			case 'home.setting_list.grid_dialog.grid_num': return 'Número da grade';
			case 'home.setting_list.grid_dialog.init_num': return 'inicial';
			case 'home.setting_list.grid_dialog.now_num': return 'atual';
			case 'home.setting_list.sort_dialog.title': return 'Alterar ordenação';
			case 'home.setting_list.sort_dialog.descending': return 'Descendente';
			case 'home.setting_list.sort_dialog.close': return 'Fechar';
			case 'home.setting_list.sort_dialog.sort_list.created': return 'Criado em';
			case 'home.setting_list.sort_dialog.sort_list.updated': return 'Atualizado em';
			case 'home.setting_list.sort_dialog.sort_list.tag': return 'Tag';
			case 'home.setting_list.sort_dialog.sort_list.genre': return 'Gênero';
			case 'home.setting_list.sort_dialog.sort_list.random': return 'Aleatório';
			case 'bookmark_card.setting_list.explain': return 'Explicar';
			case 'bookmark_card.setting_list.show_tags': return 'Mostrar tags';
			case 'bookmark_card.setting_list.edit': return 'Editar';
			case 'bookmark_card.setting_list.delete': return 'Apagar';
			case 'bookmark_card.setting_list.expain_dialog.title': return 'Explicar';
			case 'bookmark_card.setting_list.expain_dialog.close': return 'Fechar';
			case 'bookmark_card.setting_list.tag_dialog.title': return 'Tags';
			case 'bookmark_card.setting_list.tag_dialog.close': return 'Fechar';
			case 'bookmark_card.setting_list.tag_dialog.search': return '+Pesquisar';
			case 'bookmark_card.setting_list.tag_dialog.and_search.title': return 'O que é +Pesquisar?';
			case 'bookmark_card.setting_list.tag_dialog.and_search.close': return 'Fechar';
			case 'bookmark_card.setting_list.tag_dialog.and_search.text': return 'Você pode pesquisar marcadores que incluem a tag que você selecionou atualmente e todas as tags selecionadas anteriormente (no canto superior esquerdo).';
			case 'bookmark_card.setting_list.delete_dialog.title': return 'Confirmar exclusão';
			case 'bookmark_card.setting_list.delete_dialog.confirm': return 'Tem certeza de que deseja apagar?';
			case 'bookmark_card.setting_list.delete_dialog.delete': return 'Apagar';
			case 'bookmark_card.setting_list.delete_dialog.cancel': return 'Cancelar';
			case 'bookmark_card.setting_list.delete_dialog.snackbar.delete': return 'Apagado';
			case 'drawer.tags': return 'Pesquisar e editar por tags';
			case 'drawer.management': return 'Importar e fazer backup';
			case 'drawer.settings': return 'Configurações';
			case 'drawer.inquiry': return 'Contato';
			case 'add_bookmarks.title': return 'Adicionar';
			case 'add_bookmarks.complete': return 'Concluído';
			case 'add_bookmarks.explain': return 'Explicar';
			case 'add_bookmarks.url': return 'URL';
			case 'add_bookmarks.input': return 'Inserir tag';
			case 'add_bookmarks.select_image': return 'Selecionar imagem';
			case 'add_bookmarks.tag_show': return 'Tags a serem adicionadas';
			case 'add_bookmarks.exist_tag': return 'Tags existentes';
			case 'add_bookmarks.complete_dialog.title': return 'Completo';
			case 'add_bookmarks.complete_dialog.text': return 'O marcador foi adicionado. Por favor, recarregue.';
			case 'add_bookmarks.complete_dialog.close': return 'Fechar';
			case 'add_bookmarks.snackbar.url_confirm': return 'Por favor, insira uma URL.';
			case 'add_bookmarks.snackbar.existing_confirm': return 'Já existe um marcador com a mesma URL.';
			case 'add_bookmarks.on_insert.genre': return 'Sem categoria';
			case 'edit_bookmarks.title': return 'Editar';
			case 'edit_bookmarks.complete': return 'Concluído';
			case 'edit_bookmarks.explain': return 'Explicar';
			case 'edit_bookmarks.url': return 'URL';
			case 'edit_bookmarks.input': return 'Inserir tag';
			case 'edit_bookmarks.select_image': return 'Selecionar imagem';
			case 'edit_bookmarks.tag_show': return 'Tags a serem adicionadas';
			case 'edit_bookmarks.exist_tag': return 'Tags existentes';
			case 'edit_bookmarks.snackbar.url_confirm': return 'Por favor, insira uma URL.';
			case 'edit_bookmarks.snackbar.existing_confirm': return 'Já existe um marcador com a mesma URL.';
			case 'import_export.title': return 'Gerenciamento de banco de dados';
			case 'import_export.import': return 'Sobre importação';
			case 'import_export.export': return 'Sobre exportação';
			case 'import_export.import_button': return 'Importar';
			case 'import_export.export_button': return 'Exportar';
			case 'import_export.import_dialog.page_1.title': return 'Sobrescrever';
			case 'import_export.import_dialog.page_1.text': return 'Ao importar, o banco de dados atual será sobrescrito. Por favor, confirme antes de importar.';
			case 'import_export.import_dialog.page_2.title': return 'Miniatura';
			case 'import_export.import_dialog.page_2.text': return 'As miniaturas exibidas referenciam o caminho das imagens no dispositivo. Mudar de dispositivo ou excluir imagens do dispositivo resultará nas miniaturas não sendo capazes de exibir. Por favor, note que se você selecionou uma imagem,...';
			case 'import_export.backup_dialog.page_1.title': return 'Nome do arquivo';
			case 'import_export.backup_dialog.page_1.text': return 'O arquivo de backup será salvo na pasta de downloads com o nome \'classifier_database(1,2,3)_backup.sqlite\'.';
			case 'import_export.backup_dialog.page_2.title': return 'Atenção';
			case 'import_export.backup_dialog.page_2.text': return 'Os arquivos serão salvos com nomes como \'database1_backup1\', \'database1_backup2\' e assim por diante.\n\nContinuar fazendo backups consumirá espaço de armazenamento. Por favor, lembre-se de organizar sua pasta de downloads.';
			case 'import_export.back_up_confirm_dialog.title': return 'Confirmar';
			case 'import_export.back_up_confirm_dialog.text': return 'Tem certeza de que deseja fazer backup do banco de dados?';
			case 'import_export.back_up_confirm_dialog.yes': return 'Sim';
			case 'import_export.back_up_confirm_dialog.no': return 'Não';
			case 'import_export.on_import.complete': return 'Importação concluída';
			case 'import_export.on_backup.complete': return 'Backup concluído';
			case 'settings.title': return 'Configurações';
			case 'settings.privacy_policy': return 'Política de privacidade';
			case 'settings.change_theme': return 'Alterar tema';
			case 'settings.change_database': return 'Alterar banco de dados';
			case 'settings.current_database': return 'Banco de dados atual';
			case 'settings.language': return 'Idioma';
			case 'settings.database_dialog.title': return 'Confirmar';
			case 'settings.database_dialog.text': return 'Tem certeza de que deseja alterar o banco de dados?(Um anúncio será exibido a cada três vezes.)';
			case 'settings.database_dialog.yes': return 'Sim';
			case 'settings.database_dialog.no': return 'Não';
			case 'settings.loading_dialog': return 'Carregando...';
			case 'settings.on_change_database.complete': return 'Concluído';
			case 'settings.on_change_database.text': return 'O banco de dados foi alterado.';
			case 'settings.on_change_database.ok': return 'OK';
			case 'search.title': return 'Tags';
			case 'search.found': return 'marcadores encontrados';
			case 'search.search_button': return 'Pesquisar';
			case 'search.clear_button': return 'Limpar';
			case 'search.change_genre': return 'Alterar gênero';
			case 'search.search_dialog.page_1.title': return 'Sobre esta página';
			case 'search.search_dialog.page_1.text': return 'Nesta página, você pode pesquisar marcadores por tags e alterar o gênero das tags.';
			case 'search.search_dialog.page_2.title': return 'Sobre a pesquisa';
			case 'search.search_dialog.page_2.text': return 'Você pode pesquisar marcadores selecionando tags da lista abaixo.\n\nVárias tags podem ser selecionadas.';
			case 'search.search_dialog.page_3.title': return 'Sobre gênero';
			case 'search.search_dialog.page_3.text': return 'O gênero é uma classificação de tags, sendo \'Sem categoria\' o padrão.\n\nVocê pode selecionar tags e alterar o gênero.';
			case 'search.genre_dialog.title': return 'Editar gênero';
			case 'search.genre_dialog.cancel': return 'Cancelar';
			case 'search.genre_dialog.save': return 'Salvar';
			case 'search.genre_dialog.form': return 'Nome do gênero';
			case 'external_url.privacy_policy': return 'https://ez-bookmarks.pages.dev/en/privacy-policy';
			case 'external_url.inquiry': return 'https://forms.gle/7FnqbLNPLsCTDM3q7';
			case 'database.no_genre': return 'Sem categoria';
			case 'utils.unexpected': return 'Erro inesperado ocorreu';
			case 'utils.loading': return 'carregando...';
			case 'locales.en': return 'English';
			case 'locales.ja': return '日本語';
			case 'locales.es': return 'Español';
			case 'locales.pt': return 'Português';
			default: return null;
		}
	}
}
