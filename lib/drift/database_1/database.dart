import 'dart:io';
import 'package:ez_bookmarks/drift/type_converter.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';


part 'database.g.dart'; 





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
//ここはtagが持つジャンルを設定するためのテーブル
class GenreColors extends Table {
  IntColumn get id => integer().clientDefault(() => 0)();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id) ON DELETE CASCADE') ();

  TextColumn get genre => text().clientDefault(() => "分類なし")();

  @override
  Set<Column> get primaryKey => {tagId};
}






//Genreのテーブル
//ジャンルを保存するためのテーブル
class Genres extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get genre => text().nullable().customConstraint('UNIQUE') ();

}






//テーブルの設定を保存しておく
class Settings extends Table {
  IntColumn get id => integer().unique().clientDefault(() => 0 ) ();
  //IntColumn get id => integer().autoIncrement()();
  IntColumn get themeMode => integer().nullable()();
  TextColumn get databaseName => text().clientDefault(() => "データベース1")();

  //axisCountを保存する
  IntColumn get axisCount => integer().nullable()();

  //AspectRatioを保存する
  RealColumn get aspectRatio => real().nullable()();
}



















































// 両方のテーブルを含める
@DriftDatabase(tables: [Bookmarks, Tags, TaggedBookmarks, GenreColors, Settings, Genres])
class MyDatabase extends _$MyDatabase {
  final String dbName;
  MyDatabase({required this.dbName}) : super(_openConnection(dbName));
  @override
  int get schemaVersion => 23;


  @override
 MigrationStrategy get migration {
   return MigrationStrategy(
     onCreate: (Migrator m) async {
       await m.createAll();
     },


     onUpgrade: (Migrator m, int from, int to) async {
       if (from < 2) {
         await m.addColumn(bookmarks, bookmarks.tags);
       }

       if (from < 3) {
        // tagged_bookmarks テーブルの作成
        await m.createTable(taggedBookmarks);
      }

      if(from < 4){
        await m.addColumn(tags, tags.genre);
        await m.createTable(genreColors);

      }

      if(from < 5){
        // urlTextカラムをユニークにするマイグレーションを追加
        await m.alterTable(
          TableMigration(bookmarks)
        );
      }

      if(from < 6){
        // urlTextカラムをユニークにするマイグレーションを追加
        await m.alterTable(
          TableMigration(bookmarks)
        );
      }

      if(from < 7){
        // urlTextカラムをユニークにするマイグレーションを追加
        await m.alterTable(
          TableMigration(bookmarks)
        );
      }

      if (from < 8) {
        // imagePathカラムをBookmarksテーブルに追加
        await m.addColumn(bookmarks, bookmarks.imagePath);
      }

      if (from < 9) {
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);
      }

      if(from < 10){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }

      if(from < 11){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }

      if(from < 12){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }


      if(from < 13){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }

      if(from < 14){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }

      if(from < 15){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

      }

      if(from < 16){
        // GenreColorsテーブルを再作成する
        await m.deleteTable(genreColors.actualTableName);
        await m.createTable(genreColors);

        await m.alterTable(
          TableMigration(tags)
        );

      }

      if(from < 17){
        await m.createTable(settings);
      }

      /*
      //columnの追加
      if(from < 18){
        await m.addColumn(settings, settings.axisCount);
        await m.addColumn(settings, settings.aspectRatio);
      }
       */

      if(from < 19){
        await m.createTable(genres);
      } 

      if(from < 20){
        await m.deleteTable(genres.actualTableName);
        await m.createTable(genres);
      }

      if(from < 21){
        await m.deleteTable(settings.actualTableName);
        await m.createTable(settings);
      }
      
      if(from < 22){
        await m.deleteTable(settings.actualTableName);
        await m.createTable(settings);
      }

      if(from < 23){
        await m.deleteTable(settings.actualTableName);
        await m.createTable(settings);
      }

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
          sum: const Value(1), // 新しく挿入されるタグなので、sumを1に設定
          genre: const Value("分類なし",)
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









 //ブックマークの更新日時を更新
  Future<int> updateUpdatedAtBookmark(Bookmark bookmark, DateTime updatedAt) async {
    return (update(bookmarks)..where((tbl) => tbl.id.equals(bookmark.id))).write(
      BookmarksCompanion(
        updatedAt: Value(updatedAt),
      ),
    );
  }









  //タグ付きのブックマークを取得
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









  /* */
  //ここでタグのフィルターを付ける
  Future<List<Bookmark>> findBookmarksContainingAllTags(List<Tag> tags, String genre, bool isDesc) async {
    Map<int, int> bookmarkTagCounts = {};
    List<int> tagIds = tags.map((tag) => tag.id).toList();

    if(tags.isEmpty){
      return await sortedAllBookmarks(genre,isDesc);
      //return await getSortedBookmarksByIds(bookmarkIds, sortByCreatedAt: sortByCreatedAt)
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
    //これをcreatedAtもしくはupdatedAtでソートする
    List<int> matchingBookmarkIds = bookmarkTagCounts.entries
        .where((entry) => entry.value == tags.length)
        .map((entry) => entry.key)
        .toList();

    // マッチングするブックマークIDに基づいてブックマークを取得
    return await getSortedBookmarksByIds(matchingBookmarkIds, sortBy: genre, isDesc: isDesc);
  }


  /*
  Future<List<Bookmark>> _getBookmarksByIds(List<int> bookmarkIds) async {
    final query = select(bookmarks)..where((b) => b.id.isIn(bookmarkIds))..orderBy(
        [
          //(b) => OrderingTerm(expression: b.updatedAt, mode: OrderingMode.asc)
          (b) => OrderingTerm(expression: b.updatedAt, mode: OrderingMode.asc)
        ]
      );
    return await query.get();
  }
   */



  //ここでソートを行う、何でソートするかも
  Future<List<Bookmark>> getSortedBookmarksByIds(List<int> bookmarkIds, {required String sortBy, required bool isDesc}) async {
  
    final query = select(bookmarks)..where((b) => b.id.isIn(bookmarkIds));
    List<Bookmark> nowBookmarks = await query.get();

    // ソート条件の適用: createdAt または updatedAt
    if (sortBy == "createdAt") {
      nowBookmarks.sort((b, a) => a.createdAt.compareTo(b.createdAt));
    } 
    else if(sortBy == "updatedAt"){
      nowBookmarks.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    }
    
    //全てのブックマークのindexとcreatedAtをprintする
    /*
    for(int i = 0; i < nowBookmarks.length; i++){
      print("index: $i, createdAt: ${nowBookmarks[i].createdAt}");
    }

    for(int i = 0; i < nowBookmarks.length; i++){
      print("index: $i, updatedAt: ${nowBookmarks[i].updatedAt}");
    }
     */
    

    if(isDesc == false){
      nowBookmarks = nowBookmarks.reversed.toList();
    }

    return nowBookmarks;
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

  

  


  
  //get allBookmarks => select(bookmarks).get();
  Future<List<Bookmark>> sortedAllBookmarks(String genre, bool isDesc) async{
    List<Bookmark> tmpBookmarks = await select(bookmarks).get();

    if(genre == "updatedAt"){
      tmpBookmarks.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    }
    else if(genre == "createdAt"){
      tmpBookmarks.sort((b, a) => a.createdAt.compareTo(b.createdAt));
    }


    if(isDesc == false){
      tmpBookmarks = tmpBookmarks.reversed.toList();
    }

    return tmpBookmarks;

  }




  /*
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
   */





  

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
        sum: const Value(1),
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



  //Future<List<Tag>> get allTags => select(tags).get();
  
  Future<List<GenreColor>> allGenreColors() async{
    return await select(genreColors).get();
  }

  



  Future<void> deleteTags(Tag tag) {
    return (delete(tags)..where((tbl) => tbl.id.equals(tag.id))).go();
  }









































  //TODO ここからGenreテーブルについて
  // ジャンルが存在するかどうかをチェックするメソッド
  Future<bool> genreExists(String genre) async {
    final count = await (select(genres)..where((g) => g.genre.equals(genre))).getSingleOrNull();
    return count != null;
  }

  // 新しいジャンルをGenresテーブルに挿入するメソッド
  Future<void> insertGenre(String genre) async {
    await into(genres).insert(GenresCompanion.insert(genre: Value(genre)));
  }

  // MyDatabaseクラス内
Future<List<Genre>> allGenres() async {
  return select(genres).get();
}


















































  //TODO ここから設定

  Future<int> insertTheme() async{
    return into(settings).insert(
      const SettingsCompanion(
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


Future<int?> getTheme() async {
  try {
    // settingsテーブルからIDが0のレコードを取得
    final themeMode = await (select(settings)..where((s) => s.id.equals(0))).getSingleOrNull();
    // themeModeがnullの場合、デフォルト値として1を返す
    if (themeMode == null) {

      
      return null;
    }
    print("ここはテーマがnullではない");
    // themeModeがnullではない場合、その値を返す
    return themeMode.themeMode ?? 1; // themeModeがnullでなければその値、そうでなければ1を返す
  } catch (e) {
    // 予期しないエラーが発生した場合に-1を返す
    print('Error: $e');
    return 0;
  }
}



  Future<int> updateTheme(int themeMode) async{
    return (update(settings)..where((s) => s.id.equals(0))).write(
      SettingsCompanion(
        themeMode: Value(themeMode),
      ),
    );
  }




  Future<int> getAxisCount() async {
  try {
    // settingsテーブルからIDが0のレコードを取得し、存在しない場合はnullを返す
    final axisCount = await (select(settings)..where((s) => s.id.equals(0))).getSingleOrNull();
    if (axisCount == null) {
      return SizeConfig.screenWidth! > 600 ? 4 : 2;
    }
    return SizeConfig.screenWidth! > 600 
      ? axisCount.axisCount ?? 4 
      : axisCount.axisCount ?? 2;
  } catch (e) {
    // 予期しないエラーが発生した場合
    print('Error: $e');
    return SizeConfig.screenWidth! > 600 ? 4 : 2;
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



  


  Future<double> getAspectRatio() async {
  try {
    // settingsテーブルからIDが0のレコードを取得し、存在しない場合はnullを返す
    final aspectRatio = await (select(settings)..where((s) => s.id.equals(0))).getSingleOrNull();
    if (aspectRatio == null) {
      return SizeConfig.screenWidth! > 600 ? 0.75 : 0.4;
    }
    return SizeConfig.screenWidth! > 600 
      ? aspectRatio.aspectRatio ?? 0.75 
      : aspectRatio.aspectRatio ?? 0.4;
  } catch (e) {
    // 予期しないエラーが発生した場合
    print('Error: $e');
    return SizeConfig.screenWidth! > 600 ? 0.75 : 0.4;
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

    await file.parent.create(recursive: true);

    if (await file.exists()) {
      await file.delete();
    }

    // データベースを新しいファイルにエクスポート
    await customStatement('VACUUM INTO ?', [file.path]);
  }


  




  










  






}

LazyDatabase _openConnection(String dbName) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final fileName = '$dbName.sqlite';
    final file = File(p.join(dbFolder.path, fileName));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }


    return NativeDatabase(file, logStatements: true);
  });
}
