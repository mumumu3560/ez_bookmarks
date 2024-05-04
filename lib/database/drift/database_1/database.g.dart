// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _watchNumMeta =
      const VerificationMeta('watchNum');
  @override
  late final GeneratedColumn<int> watchNum = GeneratedColumn<int>(
      'watch_num', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _urlTextMeta =
      const VerificationMeta('urlText');
  @override
  late final GeneratedColumn<String> urlText = GeneratedColumn<String>(
      'url_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>('tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($BookmarksTable.$convertertagsn);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, watchNum, urlText, createdAt, updatedAt, tags, imagePath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('watch_num')) {
      context.handle(_watchNumMeta,
          watchNum.isAcceptableOrUnknown(data['watch_num']!, _watchNumMeta));
    }
    if (data.containsKey('url_text')) {
      context.handle(_urlTextMeta,
          urlText.isAcceptableOrUnknown(data['url_text']!, _urlTextMeta));
    } else if (isInserting) {
      context.missing(_urlTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    context.handle(_tagsMeta, const VerificationResult.success());
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      watchNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}watch_num'])!,
      urlText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      tags: $BookmarksTable.$convertertagsn.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const TagListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final String content;
  final int watchNum;
  final String urlText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? tags;
  final String? imagePath;
  const Bookmark(
      {required this.id,
      required this.content,
      required this.watchNum,
      required this.urlText,
      required this.createdAt,
      required this.updatedAt,
      this.tags,
      this.imagePath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['watch_num'] = Variable<int>(watchNum);
    map['url_text'] = Variable<String>(urlText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || tags != null) {
      map['tags'] =
          Variable<String>($BookmarksTable.$convertertagsn.toSql(tags));
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      content: Value(content),
      watchNum: Value(watchNum),
      urlText: Value(urlText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      watchNum: serializer.fromJson<int>(json['watchNum']),
      urlText: serializer.fromJson<String>(json['urlText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'watchNum': serializer.toJson<int>(watchNum),
      'urlText': serializer.toJson<String>(urlText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'tags': serializer.toJson<List<String>?>(tags),
      'imagePath': serializer.toJson<String?>(imagePath),
    };
  }

  Bookmark copyWith(
          {int? id,
          String? content,
          int? watchNum,
          String? urlText,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<List<String>?> tags = const Value.absent(),
          Value<String?> imagePath = const Value.absent()}) =>
      Bookmark(
        id: id ?? this.id,
        content: content ?? this.content,
        watchNum: watchNum ?? this.watchNum,
        urlText: urlText ?? this.urlText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tags: tags.present ? tags.value : this.tags,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('watchNum: $watchNum, ')
          ..write('urlText: $urlText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('tags: $tags, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, content, watchNum, urlText, createdAt, updatedAt, tags, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.content == this.content &&
          other.watchNum == this.watchNum &&
          other.urlText == this.urlText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.tags == this.tags &&
          other.imagePath == this.imagePath);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<String> content;
  final Value<int> watchNum;
  final Value<String> urlText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<List<String>?> tags;
  final Value<String?> imagePath;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.watchNum = const Value.absent(),
    this.urlText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.tags = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.watchNum = const Value.absent(),
    required String urlText,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.tags = const Value.absent(),
    this.imagePath = const Value.absent(),
  })  : content = Value(content),
        urlText = Value(urlText);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<int>? watchNum,
    Expression<String>? urlText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? tags,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (watchNum != null) 'watch_num': watchNum,
      if (urlText != null) 'url_text': urlText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (tags != null) 'tags': tags,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  BookmarksCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<int>? watchNum,
      Value<String>? urlText,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<List<String>?>? tags,
      Value<String?>? imagePath}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      watchNum: watchNum ?? this.watchNum,
      urlText: urlText ?? this.urlText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (watchNum.present) {
      map['watch_num'] = Variable<int>(watchNum.value);
    }
    if (urlText.present) {
      map['url_text'] = Variable<String>(urlText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (tags.present) {
      map['tags'] =
          Variable<String>($BookmarksTable.$convertertagsn.toSql(tags.value));
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('watchNum: $watchNum, ')
          ..write('urlText: $urlText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('tags: $tags, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagNameMeta =
      const VerificationMeta('tagName');
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
      'tag_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _sumMeta = const VerificationMeta('sum');
  @override
  late final GeneratedColumn<int> sum = GeneratedColumn<int>(
      'sum', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => "分類なし");
  @override
  List<GeneratedColumn> get $columns => [id, tagName, createdAt, sum, genre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta));
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('sum')) {
      context.handle(
          _sumMeta, sum.isAcceptableOrUnknown(data['sum']!, _sumMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      sum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sum'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String tagName;
  final DateTime createdAt;
  final int sum;
  final String genre;
  const Tag(
      {required this.id,
      required this.tagName,
      required this.createdAt,
      required this.sum,
      required this.genre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_name'] = Variable<String>(tagName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sum'] = Variable<int>(sum);
    map['genre'] = Variable<String>(genre);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      tagName: Value(tagName),
      createdAt: Value(createdAt),
      sum: Value(sum),
      genre: Value(genre),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      tagName: serializer.fromJson<String>(json['tagName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sum: serializer.fromJson<int>(json['sum']),
      genre: serializer.fromJson<String>(json['genre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagName': serializer.toJson<String>(tagName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sum': serializer.toJson<int>(sum),
      'genre': serializer.toJson<String>(genre),
    };
  }

  Tag copyWith(
          {int? id,
          String? tagName,
          DateTime? createdAt,
          int? sum,
          String? genre}) =>
      Tag(
        id: id ?? this.id,
        tagName: tagName ?? this.tagName,
        createdAt: createdAt ?? this.createdAt,
        sum: sum ?? this.sum,
        genre: genre ?? this.genre,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('tagName: $tagName, ')
          ..write('createdAt: $createdAt, ')
          ..write('sum: $sum, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagName, createdAt, sum, genre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.tagName == this.tagName &&
          other.createdAt == this.createdAt &&
          other.sum == this.sum &&
          other.genre == this.genre);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> tagName;
  final Value<DateTime> createdAt;
  final Value<int> sum;
  final Value<String> genre;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.tagName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sum = const Value.absent(),
    this.genre = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String tagName,
    this.createdAt = const Value.absent(),
    this.sum = const Value.absent(),
    this.genre = const Value.absent(),
  }) : tagName = Value(tagName);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? tagName,
    Expression<DateTime>? createdAt,
    Expression<int>? sum,
    Expression<String>? genre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagName != null) 'tag_name': tagName,
      if (createdAt != null) 'created_at': createdAt,
      if (sum != null) 'sum': sum,
      if (genre != null) 'genre': genre,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? tagName,
      Value<DateTime>? createdAt,
      Value<int>? sum,
      Value<String>? genre}) {
    return TagsCompanion(
      id: id ?? this.id,
      tagName: tagName ?? this.tagName,
      createdAt: createdAt ?? this.createdAt,
      sum: sum ?? this.sum,
      genre: genre ?? this.genre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sum.present) {
      map['sum'] = Variable<int>(sum.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('tagName: $tagName, ')
          ..write('createdAt: $createdAt, ')
          ..write('sum: $sum, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }
}

class $TaggedBookmarksTable extends TaggedBookmarks
    with TableInfo<$TaggedBookmarksTable, TaggedBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaggedBookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookmarkIdMeta =
      const VerificationMeta('bookmarkId');
  @override
  late final GeneratedColumn<int> bookmarkId = GeneratedColumn<int>(
      'bookmark_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES bookmarks(id) ON DELETE CASCADE');
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES tags(id) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [bookmarkId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tagged_bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<TaggedBookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bookmark_id')) {
      context.handle(
          _bookmarkIdMeta,
          bookmarkId.isAcceptableOrUnknown(
              data['bookmark_id']!, _bookmarkIdMeta));
    } else if (isInserting) {
      context.missing(_bookmarkIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookmarkId, tagId};
  @override
  TaggedBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaggedBookmark(
      bookmarkId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bookmark_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $TaggedBookmarksTable createAlias(String alias) {
    return $TaggedBookmarksTable(attachedDatabase, alias);
  }
}

class TaggedBookmark extends DataClass implements Insertable<TaggedBookmark> {
  final int bookmarkId;
  final int tagId;
  const TaggedBookmark({required this.bookmarkId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bookmark_id'] = Variable<int>(bookmarkId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  TaggedBookmarksCompanion toCompanion(bool nullToAbsent) {
    return TaggedBookmarksCompanion(
      bookmarkId: Value(bookmarkId),
      tagId: Value(tagId),
    );
  }

  factory TaggedBookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaggedBookmark(
      bookmarkId: serializer.fromJson<int>(json['bookmarkId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookmarkId': serializer.toJson<int>(bookmarkId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  TaggedBookmark copyWith({int? bookmarkId, int? tagId}) => TaggedBookmark(
        bookmarkId: bookmarkId ?? this.bookmarkId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('TaggedBookmark(')
          ..write('bookmarkId: $bookmarkId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bookmarkId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaggedBookmark &&
          other.bookmarkId == this.bookmarkId &&
          other.tagId == this.tagId);
}

class TaggedBookmarksCompanion extends UpdateCompanion<TaggedBookmark> {
  final Value<int> bookmarkId;
  final Value<int> tagId;
  final Value<int> rowid;
  const TaggedBookmarksCompanion({
    this.bookmarkId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaggedBookmarksCompanion.insert({
    required int bookmarkId,
    required int tagId,
    this.rowid = const Value.absent(),
  })  : bookmarkId = Value(bookmarkId),
        tagId = Value(tagId);
  static Insertable<TaggedBookmark> custom({
    Expression<int>? bookmarkId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookmarkId != null) 'bookmark_id': bookmarkId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaggedBookmarksCompanion copyWith(
      {Value<int>? bookmarkId, Value<int>? tagId, Value<int>? rowid}) {
    return TaggedBookmarksCompanion(
      bookmarkId: bookmarkId ?? this.bookmarkId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookmarkId.present) {
      map['bookmark_id'] = Variable<int>(bookmarkId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaggedBookmarksCompanion(')
          ..write('bookmarkId: $bookmarkId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenreColorsTable extends GenreColors
    with TableInfo<$GenreColorsTable, GenreColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenreColorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tags(id) ON DELETE CASCADE');
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => "分類なし");
  @override
  List<GeneratedColumn> get $columns => [id, tagId, genre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genre_colors';
  @override
  VerificationContext validateIntegrity(Insertable<GenreColor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId};
  @override
  GenreColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenreColor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
    );
  }

  @override
  $GenreColorsTable createAlias(String alias) {
    return $GenreColorsTable(attachedDatabase, alias);
  }
}

class GenreColor extends DataClass implements Insertable<GenreColor> {
  final int id;
  final int tagId;
  final String genre;
  const GenreColor(
      {required this.id, required this.tagId, required this.genre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_id'] = Variable<int>(tagId);
    map['genre'] = Variable<String>(genre);
    return map;
  }

  GenreColorsCompanion toCompanion(bool nullToAbsent) {
    return GenreColorsCompanion(
      id: Value(id),
      tagId: Value(tagId),
      genre: Value(genre),
    );
  }

  factory GenreColor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenreColor(
      id: serializer.fromJson<int>(json['id']),
      tagId: serializer.fromJson<int>(json['tagId']),
      genre: serializer.fromJson<String>(json['genre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagId': serializer.toJson<int>(tagId),
      'genre': serializer.toJson<String>(genre),
    };
  }

  GenreColor copyWith({int? id, int? tagId, String? genre}) => GenreColor(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        genre: genre ?? this.genre,
      );
  @override
  String toString() {
    return (StringBuffer('GenreColor(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagId, genre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenreColor &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.genre == this.genre);
}

class GenreColorsCompanion extends UpdateCompanion<GenreColor> {
  final Value<int> id;
  final Value<int> tagId;
  final Value<String> genre;
  const GenreColorsCompanion({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.genre = const Value.absent(),
  });
  GenreColorsCompanion.insert({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.genre = const Value.absent(),
  });
  static Insertable<GenreColor> custom({
    Expression<int>? id,
    Expression<int>? tagId,
    Expression<String>? genre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (genre != null) 'genre': genre,
    });
  }

  GenreColorsCompanion copyWith(
      {Value<int>? id, Value<int>? tagId, Value<String>? genre}) {
    return GenreColorsCompanion(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      genre: genre ?? this.genre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenreColorsCompanion(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      clientDefault: () => 0);
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<int> themeMode = GeneratedColumn<int>(
      'theme_mode', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _databaseNameMeta =
      const VerificationMeta('databaseName');
  @override
  late final GeneratedColumn<String> databaseName = GeneratedColumn<String>(
      'database_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => "データベース1");
  static const VerificationMeta _axisCountMeta =
      const VerificationMeta('axisCount');
  @override
  late final GeneratedColumn<int> axisCount = GeneratedColumn<int>(
      'axis_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _aspectRatioMeta =
      const VerificationMeta('aspectRatio');
  @override
  late final GeneratedColumn<double> aspectRatio = GeneratedColumn<double>(
      'aspect_ratio', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, themeMode, databaseName, axisCount, aspectRatio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('database_name')) {
      context.handle(
          _databaseNameMeta,
          databaseName.isAcceptableOrUnknown(
              data['database_name']!, _databaseNameMeta));
    }
    if (data.containsKey('axis_count')) {
      context.handle(_axisCountMeta,
          axisCount.isAcceptableOrUnknown(data['axis_count']!, _axisCountMeta));
    }
    if (data.containsKey('aspect_ratio')) {
      context.handle(
          _aspectRatioMeta,
          aspectRatio.isAcceptableOrUnknown(
              data['aspect_ratio']!, _aspectRatioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}theme_mode']),
      databaseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}database_name'])!,
      axisCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}axis_count']),
      aspectRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}aspect_ratio']),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final int? themeMode;
  final String databaseName;
  final int? axisCount;
  final double? aspectRatio;
  const Setting(
      {required this.id,
      this.themeMode,
      required this.databaseName,
      this.axisCount,
      this.aspectRatio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || themeMode != null) {
      map['theme_mode'] = Variable<int>(themeMode);
    }
    map['database_name'] = Variable<String>(databaseName);
    if (!nullToAbsent || axisCount != null) {
      map['axis_count'] = Variable<int>(axisCount);
    }
    if (!nullToAbsent || aspectRatio != null) {
      map['aspect_ratio'] = Variable<double>(aspectRatio);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      themeMode: themeMode == null && nullToAbsent
          ? const Value.absent()
          : Value(themeMode),
      databaseName: Value(databaseName),
      axisCount: axisCount == null && nullToAbsent
          ? const Value.absent()
          : Value(axisCount),
      aspectRatio: aspectRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(aspectRatio),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<int?>(json['themeMode']),
      databaseName: serializer.fromJson<String>(json['databaseName']),
      axisCount: serializer.fromJson<int?>(json['axisCount']),
      aspectRatio: serializer.fromJson<double?>(json['aspectRatio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<int?>(themeMode),
      'databaseName': serializer.toJson<String>(databaseName),
      'axisCount': serializer.toJson<int?>(axisCount),
      'aspectRatio': serializer.toJson<double?>(aspectRatio),
    };
  }

  Setting copyWith(
          {int? id,
          Value<int?> themeMode = const Value.absent(),
          String? databaseName,
          Value<int?> axisCount = const Value.absent(),
          Value<double?> aspectRatio = const Value.absent()}) =>
      Setting(
        id: id ?? this.id,
        themeMode: themeMode.present ? themeMode.value : this.themeMode,
        databaseName: databaseName ?? this.databaseName,
        axisCount: axisCount.present ? axisCount.value : this.axisCount,
        aspectRatio: aspectRatio.present ? aspectRatio.value : this.aspectRatio,
      );
  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('databaseName: $databaseName, ')
          ..write('axisCount: $axisCount, ')
          ..write('aspectRatio: $aspectRatio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, themeMode, databaseName, axisCount, aspectRatio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.databaseName == this.databaseName &&
          other.axisCount == this.axisCount &&
          other.aspectRatio == this.aspectRatio);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<int?> themeMode;
  final Value<String> databaseName;
  final Value<int?> axisCount;
  final Value<double?> aspectRatio;
  final Value<int> rowid;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.databaseName = const Value.absent(),
    this.axisCount = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.databaseName = const Value.absent(),
    this.axisCount = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<int>? themeMode,
    Expression<String>? databaseName,
    Expression<int>? axisCount,
    Expression<double>? aspectRatio,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (databaseName != null) 'database_name': databaseName,
      if (axisCount != null) 'axis_count': axisCount,
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? themeMode,
      Value<String>? databaseName,
      Value<int?>? axisCount,
      Value<double?>? aspectRatio,
      Value<int>? rowid}) {
    return SettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      databaseName: databaseName ?? this.databaseName,
      axisCount: axisCount ?? this.axisCount,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>(themeMode.value);
    }
    if (databaseName.present) {
      map['database_name'] = Variable<String>(databaseName.value);
    }
    if (axisCount.present) {
      map['axis_count'] = Variable<int>(axisCount.value);
    }
    if (aspectRatio.present) {
      map['aspect_ratio'] = Variable<double>(aspectRatio.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('databaseName: $databaseName, ')
          ..write('axisCount: $axisCount, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenresTable extends Genres with TableInfo<$GenresTable, Genre> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, genre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genres';
  @override
  VerificationContext validateIntegrity(Insertable<Genre> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Genre map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Genre(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre']),
    );
  }

  @override
  $GenresTable createAlias(String alias) {
    return $GenresTable(attachedDatabase, alias);
  }
}

class Genre extends DataClass implements Insertable<Genre> {
  final int id;
  final String? genre;
  const Genre({required this.id, this.genre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    return map;
  }

  GenresCompanion toCompanion(bool nullToAbsent) {
    return GenresCompanion(
      id: Value(id),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
    );
  }

  factory Genre.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Genre(
      id: serializer.fromJson<int>(json['id']),
      genre: serializer.fromJson<String?>(json['genre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'genre': serializer.toJson<String?>(genre),
    };
  }

  Genre copyWith({int? id, Value<String?> genre = const Value.absent()}) =>
      Genre(
        id: id ?? this.id,
        genre: genre.present ? genre.value : this.genre,
      );
  @override
  String toString() {
    return (StringBuffer('Genre(')
          ..write('id: $id, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, genre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Genre && other.id == this.id && other.genre == this.genre);
}

class GenresCompanion extends UpdateCompanion<Genre> {
  final Value<int> id;
  final Value<String?> genre;
  const GenresCompanion({
    this.id = const Value.absent(),
    this.genre = const Value.absent(),
  });
  GenresCompanion.insert({
    this.id = const Value.absent(),
    this.genre = const Value.absent(),
  });
  static Insertable<Genre> custom({
    Expression<int>? id,
    Expression<String>? genre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (genre != null) 'genre': genre,
    });
  }

  GenresCompanion copyWith({Value<int>? id, Value<String?>? genre}) {
    return GenresCompanion(
      id: id ?? this.id,
      genre: genre ?? this.genre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenresCompanion(')
          ..write('id: $id, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TaggedBookmarksTable taggedBookmarks =
      $TaggedBookmarksTable(this);
  late final $GenreColorsTable genreColors = $GenreColorsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $GenresTable genres = $GenresTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [bookmarks, tags, taggedBookmarks, genreColors, settings, genres];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('bookmarks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tagged_bookmarks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tagged_bookmarks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('genre_colors', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}
