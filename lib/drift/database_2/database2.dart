/*
import 'dart:io';
import 'package:ez_bookmarks/drift/type_converter.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';


// これらの部分は適切に生成されるよう、コマンドを実行してください
part 'database2.g.dart'; 

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  IntColumn get watchNum => integer().withDefault(const Constant(0))();
  // urlTextカラムに.unique()を追加して、この値がユニークであることを保証する
  TextColumn get urlText => text().unique()();
  //TextColumn get urlText => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  // TagListConverterを使用してタグリストを保存する
  TextColumn get tags => text().map(const TagListConverter()).nullable()();

  // 画像のパス用のカラムを追加 schema 8
  TextColumn get imagePath => text().nullable()();
}





class Tags extends Table {
  IntColumn get id => integer().autoIncrement()(); 
  //schema 15?
  TextColumn get tagName => text().unique()(); 
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get sum => integer().withDefault(const Constant(0))();

  //schema 4
  TextColumn get genre => text().clientDefault(() => "分類なし")();
}



//tagとbookmarkとの関係のため。
class TaggedBookmarks extends Table {
  IntColumn get bookmarkId => integer().customConstraint('REFERENCES bookmarks(id) ON DELETE CASCADE')();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id) ON DELETE CASCADE')();

  @override
  Set<Column> get primaryKey => {bookmarkId, tagId};
}


//tagのジャンル設定
class GenreColors extends Table {
  IntColumn get id => integer().clientDefault(() => 0)();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id) ON DELETE CASCADE') ();

  TextColumn get genre => text().clientDefault(() => "分類なし")();

  @override
  Set<Column> get primaryKey => {tagId};
}

//テーブルの設定を保存しておく
class Settings extends Table {
  IntColumn get id => integer().clientDefault(() => 0 ) ();
  IntColumn get themeMode => integer().nullable()();
  TextColumn get databaseName => text().clientDefault(() => "データベース1")();

  //axisCountを保存する
  IntColumn get axisCount => integer().nullable()();

  //AspectRatioを保存する
  RealColumn get aspectRatio => real().nullable()();
}






// 両方のテーブルを含める
@DriftDatabase(tables: [Bookmarks, Tags, TaggedBookmarks, GenreColors, Settings])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 16;


  @override
 MigrationStrategy get migration {
   return MigrationStrategy(
     onCreate: (Migrator m) async {
       await m.createAll();
     },


     onUpgrade: (Migrator m, int from, int to) async {
       
     },


   );
 }




  //ブックマークインサート
  //TODO ここからブックマーク

  Future<void> insertBookmarkWithTags(String content, String url, List<String> tagNames, String? imagePath) async {
    // ブックマークを挿入し、挿入されたブックマークのIDを取得
    final bookmarkId = await into(bookmarks).insert(BookmarksCompanion(
      content: Value(content),
      urlText: Value(url),
      tags: Value(tagNames), // TagListConverterによりJSON文字列に変換されて保存
      imagePath: Value(imagePath), // imagePathがnullの場合も考慮される
    ));

    for (final tagName in tagNames) {
      int tagId;
      final existingTag = await (select(tags)..where((t) => t.tagName.equals(tagName))).getSingleOrNull();
      if (existingTag == null) {
        // タグが存在しない場合は、新しく挿入して`sum`を1に設定
        tagId = await into(tags).insert(TagsCompanion(
          tagName: Value(tagName),
          sum: Value(1), // 新しく挿入されるタグなので、sumを1に設定
          genre: Value("分類なし",)
        ));
      } else {
        // タグが存在する場合は、`sum`の値を1増加させて更新
        tagId = existingTag.id; // 既存のタグIDを使用
        final updatedSum = existingTag.sum + 1;
        await (update(tags)..where((t) => t.id.equals(tagId))).write(
          TagsCompanion(
            sum: Value(updatedSum),
          ),
        );
      }

      // TaggedBookmarksテーブルにブックマークとタグの関連を挿入
      // この挿入は、TaggedBookmarksテーブルの既存レコードと競合しないように注意してください。
      final existingTaggedBookmark = await (select(taggedBookmarks)
        ..where((tb) => tb.bookmarkId.equals(bookmarkId) & tb.tagId.equals(tagId)))
        .getSingleOrNull();
      
      if (existingTaggedBookmark == null) {
        await into(taggedBookmarks).insert(TaggedBookmarksCompanion(
          bookmarkId: Value(bookmarkId),
          tagId: Value(tagId),
        ));
      }
      // すでに関連が存在する場合は、何もしないか、別のアクションを取る
    }
  }


  Future<void> updateBookmarkWithTags(int bookmarkId, String content, String url, List<String> newTagNames, String? imagePath) async {
    return transaction(() async {
      // 更新前のブックマークのタグリストを取得
      final oldTags = await (select(taggedBookmarks)
        ..where((t) => t.bookmarkId.equals(bookmarkId)))
        .join([
          innerJoin(tags, tags.id.equalsExp(taggedBookmarks.tagId)),
        ])
        .map((row) => row.readTable(tags))
        .get();

      final oldTagNames = oldTags.map((t) => t.tagName).toList();

      // 新旧のタグリストを比較して、追加されたタグと削除されたタグを特定
      final tagsToAdd = newTagNames.where((name) => !oldTagNames.contains(name)).toList();
      final tagsToRemove = oldTags.where((tag) => !newTagNames.contains(tag.tagName)).toList();

      // 追加されたタグの処理
      for (final tagName in tagsToAdd) {
        final tagId = await _addOrUpdateTag(tagName);
        // 新しいTaggedBookmarksの関連を挿入
        await into(taggedBookmarks).insert(TaggedBookmarksCompanion(
          bookmarkId: Value(bookmarkId),
          tagId: Value(tagId),
        ));
      }

      // 削除されたタグの処理
      for (final tag in tagsToRemove) {
        if (tag.sum > 1) {
          // Tagsテーブルのsumをデクリメント
          await (update(tags)..where((t) => t.id.equals(tag.id))).write(
            TagsCompanion(sum: Value(tag.sum - 1)),
          );
        } else {
          // タグの使用回数が0になった場合、タグを削除するか、または残しておくか検討
          await (delete(tags)..where((t) => t.id.equals(tag.id))).go();
        }
        // TaggedBookmarksから関連を削除
        await (delete(taggedBookmarks)..where((tb) => tb.bookmarkId.equals(bookmarkId) & tb.tagId.equals(tag.id))).go();
      }

      // ブックマークの更新
      await (update(bookmarks)..where((b) => b.id.equals(bookmarkId))).write(
        BookmarksCompanion(
          content: Value(content),
          urlText: Value(url),
          tags: Value(newTagNames),
          imagePath: Value(imagePath),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }


  /*
  
   */

  Future<int> updateUpdatedAtBookmark(Bookmark bookmark, DateTime updatedAt) async {
    return (update(bookmarks)..where((tbl) => tbl.id.equals(bookmark.id))).write(
      BookmarksCompanion(
        updatedAt: Value(updatedAt),
      ),
    );
  }


  // MyDatabase クラス内

  Future<List<Bookmark>> getBookmarksForTag(int tagId) async {
    final bookmarkIds = await (select(taggedBookmarks)
          ..where((tb) => tb.tagId.equals(tagId)))
        .map((row) => row.bookmarkId)
        .get();

    final bookmarksQuery = select(bookmarks)..where((b) => b.id.isIn(bookmarkIds));
    return bookmarksQuery.get();
  }


  Future<void> deleteBookmark(Bookmark bookmark) async {
    return transaction(() async {
      // 1. ブックマークに関連付けられたタグのIDを取得
      final tagIds = await (select(taggedBookmarks)
            ..where((t) => t.bookmarkId.equals(bookmark.id)))
          .map((row) => row.tagId)
          .get();

      // 2. 各タグに対する処理
      for (final tagId in tagIds) {
        final tag = await (select(tags)..where((t) => t.id.equals(tagId))).getSingle();
        if (tag.sum > 1) {
          // Tagsテーブルのsumをデクリメント
          await (update(tags)..where((t) => t.id.equals(tagId))).write(
            TagsCompanion(sum: Value(tag.sum - 1)),
          );
        } else {
          // タグの使用回数が1の場合、タグを削除
          await (delete(tags)..where((t) => t.id.equals(tagId))).go();
        }
      }

      // 3. TaggedBookmarksからブックマークに関連付けられたレコードを削除
      await (delete(taggedBookmarks)..where((t) => t.bookmarkId.equals(bookmark.id))).go();

      // 4. ブックマーク自体を削除
      await (delete(bookmarks)..where((t) => t.id.equals(bookmark.id))).go();
      
    });
  }


  





    // MyDatabase クラス内に新しいメソッドを追加
  Stream<List<Bookmark>> watchBookmarksFilteredByTags(List<Tag> tags) {
    // タグIDのリストを抽出
    final tagIds = tags.map((tag) => tag.id).toList();

    // 指定されたタグIDにマッチするブックマークIDを取得するサブクエリ
    final matchingBookmarkIds = selectOnly(taggedBookmarks)
      ..addColumns([taggedBookmarks.bookmarkId])
      ..where(taggedBookmarks.tagId.isIn(tagIds))
      ..groupBy([taggedBookmarks.bookmarkId]);

    // フィルタリングされたブックマークを返すクエリ
    final query = select(bookmarks)..where((tbl) => tbl.id.isInQuery(matchingBookmarkIds));

    // クエリの結果をストリームとして返す
    return (query..orderBy(
      [
        (b) => OrderingTerm(expression: b.updatedAt, mode: OrderingMode.desc)
      ]
    )).watch();
  }




  Future<List<int>> test2(List<Tag> tags) async {
    Map<int, int> bookmarkTagCounts = {};
    List<int> tagIds = tags.map((tag) => tag.id).toList();

    // 各タグに対して、それを含むブックマークのIDを取得し、カウントを1増やす
    for (var tagId in tagIds) {
      final List<int> bookmarkIds = await _getBookmarkIdsByTagId(tagId);
      for (var bookmarkId in bookmarkIds) {
        if (!bookmarkTagCounts.containsKey(bookmarkId)) {
          bookmarkTagCounts[bookmarkId] = 1;
        } else {
          bookmarkTagCounts[bookmarkId] = bookmarkTagCounts[bookmarkId]! + 1;
        }
      }
    }

    // タグの数と一致するブックマークのIDのみを抽出
    return bookmarkTagCounts.entries
        .where((entry) => entry.value == tags.length)
        .map((entry) => entry.key)
        .toList();

    
  }





  
  //ここでタグのフィルターを付ける
  Future<List<Bookmark>> findBookmarksContainingAllTags(List<Tag> tags) async {
    Map<int, int> bookmarkTagCounts = {};
    List<int> tagIds = tags.map((tag) => tag.id).toList();

    if(tags.isEmpty){
      return await allBookmarks;
    }

    // 各タグに対して、それを含むブックマークのIDを取得し、カウントを1増やす
    for (var tagId in tagIds) {
      final List<int> bookmarkIds = await _getBookmarkIdsByTagId(tagId);
      for (var bookmarkId in bookmarkIds) {
        if (!bookmarkTagCounts.containsKey(bookmarkId)) {
          bookmarkTagCounts[bookmarkId] = 1;
        } else {
          bookmarkTagCounts[bookmarkId] = bookmarkTagCounts[bookmarkId]! + 1;
        }
      }
    }

    // タグの数と一致するブックマークのIDのみを抽出
    List<int> matchingBookmarkIds = bookmarkTagCounts.entries
        .where((entry) => entry.value == tags.length)
        .map((entry) => entry.key)
        .toList();

    // マッチングするブックマークIDに基づいてブックマークを取得
    return await _getBookmarksByIds(matchingBookmarkIds);
  }

  Future<List<int>> _getBookmarkIdsByTagId(int tagId) async {
    final query = selectOnly(taggedBookmarks)
      ..addColumns([taggedBookmarks.bookmarkId])
      ..where(taggedBookmarks.tagId.equals(tagId));
      //addColumnsは対象となるcolumnを指定する
      

    final rows = await query.get();

    return rows.map((row) => row.read(taggedBookmarks.bookmarkId))
      .whereType<int>()
      .toList();
  }

  Future<List<Bookmark>> _getBookmarksByIds(List<int> bookmarkIds) async {
    final query = select(bookmarks)..where((b) => b.id.isIn(bookmarkIds));
    return await query.get();
  }


  

  Future<List<Bookmark>> get allBookmarks => select(bookmarks).get();


  Stream<List<Bookmark>> watchBookmarks() {
    //return select(bookmarks).watch();
    return (
      select(bookmarks)..orderBy(
        [
          (b) => OrderingTerm(expression: b.updatedAt, mode: OrderingMode.desc)
        ]
      )
    ).watch();
  }





  

  Future<void> incrementWatchNum(int bookmarkId) async {
    // 指定されたIDのBookmarkを見つける
    final bookmark = await (select(bookmarks)..where((b) => b.id.equals(bookmarkId))).getSingle();
    // `watchNum`の現在値を取得して1増加させる
    final updatedWatchNum = bookmark.watchNum + 1;
    // 更新された`watchNum`でデータベースを更新
    await (update(bookmarks)..where((b) => b.id.equals(bookmarkId))).write(
      BookmarksCompanion(
        watchNum: Value(updatedWatchNum),
      ),
    );
  } 







  Future<int?> getTagIdByName(String tagName) async {
    final tag = await (select(tags)..where((t) => t.tagName.equals(tagName))).getSingleOrNull();
    return tag?.id; // タグが見つかればそのIDを返し、見つからなければnullを返す
  }

  // タグを追加または既存のタグのsumをインクリメントするヘルパーメソッド
  Future<int> _addOrUpdateTag(String tagName) async {
    final existingTag = await (select(tags)..where((t) => t.tagName.equals(tagName))).getSingleOrNull();
    if (existingTag == null) {
      // 新しいタグを追加してIDを取得
      return await into(tags).insert(TagsCompanion(
        tagName: Value(tagName),
        sum: Value(1),
      ));
    } else {
      // 既存のタグのsumをインクリメント
      await (update(tags)..where((t) => t.id.equals(existingTag.id))).write(
        TagsCompanion(sum: Value(existingTag.sum + 1)),
      );
      return existingTag.id;
    }
  }





  // Tagsテーブルのための操作
  Future<int> insertTag(String tagName) {
    return into(tags).insert(TagsCompanion(
      tagName: Value(tagName),
    ));
  }

  Stream<List<Tag>> watchTags() {
    return select(tags).watch();
  }

  Future<List<Tag>> get allTags => select(tags).get();

  Future<Tag> getTagById(int tagId) async {
    return (select(tags)..where((t) => t.id.equals(tagId))).getSingle();
  }



  Future<void> incrementNum(int tagId) async {
    // 指定されたIDのTagを見つける
    final tag = await (select(tags)..where((t) => t.id.equals(tagId))).getSingle();
    // `sum`の現在値を取得して1増加させる
    final updatedSum = tag.sum + 1;
    // 更新された`sum`でデータベースを更新
    await (update(tags)..where((t) => t.id.equals(tagId))).write(
      TagsCompanion(
        sum: Value(updatedSum),
      ),
    );
  }



  Future<void> decrementNum(int tagId) async {
    // 指定されたIDのTagを見つける
    final tag = await (select(tags)..where((t) => t.id.equals(tagId))).getSingle();
    // `sum`の現在値を取得して1減少させる
    final updatedSum = tag.sum + -1;
    // 更新された`sum`でデータベースを更新
    await (update(tags)..where((t) => t.id.equals(tagId))).write(
      TagsCompanion(
        sum: Value(updatedSum),
      ),
    );
  }





  //bookmarkについているtagを取得
  Future<List<Tag>> getTagsForBookmark(int bookmarkId) async {
    final tagIds = await (select(taggedBookmarks)
          ..where((t) => t.bookmarkId.equals(bookmarkId)))
        .map((row) => row.tagId)
        .get();
    final tagsQuery = select(tags)..where((t) => t.id.isIn(tagIds));
    return tagsQuery.get();
  }



  Future<void> updateTagGenre(int tagId, String newGenre) async {
    // タグのIDに基づいて、ジャンルを更新する
    await (update(tags)..where((t) => t.id.equals(tagId))).write(
      TagsCompanion(genre: Value(newGenre)),
    );
  }

  //isFirstは、タグを編集するときか、新規追加するときかを判別するためのもの
  Future<void> insertOrUpdateGenreColor(int tagId, String newGenre, bool isFirst) async {
    final existingGenreColor = await (select(genreColors)..where((g) => g.tagId.equals(tagId))).getSingleOrNull();
    if (existingGenreColor == null) {
      // ジャンルカラーが存在しない場合、新しく挿入
      await into(genreColors).insert(GenreColorsCompanion(
        tagId: Value(tagId),
        genre: Value(newGenre),
      ));
    } else {
      // 既に存在する場合は、ジャンルを更新

      if(newGenre == "分類なし" && isFirst) return;

      await (update(genreColors)..where((g) => g.tagId.equals(tagId))).write(
        GenreColorsCompanion(
          genre: Value(newGenre),
        ),
      );
    }
  }





















  



  




  /*
  Future<List<Bookmark>> getBookmarksForTag(String tagName) async {
    // 指定されたタグ名に一致するタグのIDを取得
    final tagIdQuery = select(tags)..where((t) => t.tagName.equals(tagName));
    final tag = await tagIdQuery.getSingle();

    // 上記で取得したタグIDに関連するすべてのブックマークIDを取得
    final taggedBookmarkQuery = select(taggedBookmarks)..where((tb) => tb.tagId.equals(tag.id));
    final List<int> bookmarkIds = await taggedBookmarkQuery.map((row) => row.bookmarkId).get();

    // 上記で取得したブックマークIDに一致するすべてのブックマークを取得
    final bookmarkQuery = select(bookmarks)..where((b) => b.id.isIn(bookmarkIds));
    return bookmarkQuery.get();
  }
   */










  Future<void> deleteTags(Tag tag) {
    return (delete(tags)..where((tbl) => tbl.id.equals(tag.id))).go();
  }



  //TODO ここから設定

  Future<int> insertTheme() async{
    return into(settings).insert(
      SettingsCompanion(
        themeMode: Value(1),
      )
    );
  }

  //settingsテーブルにコラムがあるかどうかを確認する。
  Future<bool> checkSettings() async{
    final settingsNow = await select(settings).get();
    if(settingsNow.isEmpty){
      return false;
    }else{
      return true;
    }
  }

  Future<int> getTheme() async {
  try {
    // settingsテーブルからIDが0のレコードを取得
    final themeMode = await (select(settings)..where((s) => s.id.equals(0))).getSingle();
    print(themeMode);
    // themeModeがnullではない場合、その値を返す
    return themeMode.themeMode ?? 0;
  } catch (e) {
    // テーブルが空か、レコードが見つからない場合に-1を返す
    print('Error: $e');
    myDatabase.insertTheme();
    return 1;
  }
}


  Future<int> updateTheme(int themeMode) async{
    return (update(settings)..where((s) => s.id.equals(0))).write(
      SettingsCompanion(
        themeMode: Value(themeMode),
      ),
    );
  }


  //axisCountを取得
  Future<int> getAxisCount() async {
    try {
      // settingsテーブルからIDが0のレコードを取得
      final axisCount = await (select(settings)..where((s) => s.id.equals(0))).getSingle();
      print(axisCount);
      //MediaQuery.of(context).size.width > 600 ? 4 : 2;
      //return axisCount.axisCount ?? 2;
      return SizeConfig.screenWidth! > 600 
        ? axisCount.axisCount ?? 4 
        : axisCount.axisCount ?? 2;
    } catch (e) {
      // テーブルが空か、レコードが見つからない場合に-1を返す
      return SizeConfig.screenWidth! > 600 
        ? 4 
        : 2;
    }
  }

  //axisCountを更新
  Future<int> updateAxisCount(int axisCount) async{
    return (update(settings)..where((s) => s.id.equals(0))).write(
      SettingsCompanion(
        axisCount: Value(axisCount),
      ),
    );
  }

  //AspectRatioを取得
  Future<double> getAspectRatio() async {
    try {
      // settingsテーブルからIDが0のレコードを取得
      final aspectRatio = await (select(settings)..where((s) => s.id.equals(0))).getSingle();
      print(aspectRatio);
      //return aspectRatio.aspectRatio ?? 0.4;
      return SizeConfig.screenWidth! > 600 
        ? aspectRatio.aspectRatio ?? 0.75 
        : aspectRatio.aspectRatio ?? 0.4;

    } catch (e) {
      // テーブルが空か、レコードが見つからない場合に-1を返す
      return SizeConfig.screenWidth! > 600 
        ? 0.75 
        : 0.4;
    }
  }

  //AspectRatioを更新
  Future<int> updateAspectRatio(double aspectRatio) async{
    return (update(settings)..where((s) => s.id.equals(0))).write(
      SettingsCompanion(
        aspectRatio: Value(aspectRatio),
      ),
    );
  }











  Future<void> backupDatabase(String newPath) async {
  final File file = File(newPath);

  print(file.path);
  print(file);

  print("ここでいろいろ確認する");

  // ディレクトリが存在することを確認
  await file.parent.create(recursive: true);

  /*
  // ファイルが既に存在する場合は削除
  
   */

  if (await file.exists()) {
    await file.delete();
  }

  // データベースを新しいファイルにエクスポート
  await customStatement('VACUUM INTO ?', [file.path]);
}


  /*
  // データベースを新しいファイルにバックアップする
  Future<void> backupDatabase(String newPath) async {
    await customStatement('VACUUM INTO ?', [newPath]);

  }
   */

  // 新しいデータベースファイルで現在のデータベースを置き換える
  Future<void> importDatabase(String newPath) async {

    await myDatabase.close(); // 最初にデータベース接続を閉じる
    await Future.delayed(Duration(seconds: 1)); // 接続が完全に閉じるのを確実に待つ

    //TODO databaseの名前を変更する
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'my_database2.sqlite'));
    await myDatabase.close();
    await file.delete();
    await File(newPath).copy(file.path);
    // データベースの再接続や初期化が必要な場合はここで実行
  }




  










  






}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    print(dbFolder);
    print(dbFolder.path);

    print("ここは初期化か？");
    final file = File(p.join(dbFolder.path, 'my_database.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }


    return NativeDatabase(file, logStatements: true);
  });
}

 */