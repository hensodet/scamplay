// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedScenarioCategoriesTable extends CachedScenarioCategories
    with TableInfo<$CachedScenarioCategoriesTable, CachedScenarioCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScenarioCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, slug, sortOrder, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scenario_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedScenarioCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedScenarioCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScenarioCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedScenarioCategoriesTable createAlias(String alias) {
    return $CachedScenarioCategoriesTable(attachedDatabase, alias);
  }
}

class CachedScenarioCategory extends DataClass
    implements Insertable<CachedScenarioCategory> {
  final String id;
  final String slug;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedScenarioCategory(
      {required this.id,
      required this.slug,
      required this.sortOrder,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedScenarioCategoriesCompanion toCompanion(bool nullToAbsent) {
    return CachedScenarioCategoriesCompanion(
      id: Value(id),
      slug: Value(slug),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedScenarioCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScenarioCategory(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedScenarioCategory copyWith(
          {String? id,
          String? slug,
          int? sortOrder,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedScenarioCategory(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedScenarioCategory copyWithCompanion(
      CachedScenarioCategoriesCompanion data) {
    return CachedScenarioCategory(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioCategory(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScenarioCategory &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedScenarioCategoriesCompanion
    extends UpdateCompanion<CachedScenarioCategory> {
  final Value<String> id;
  final Value<String> slug;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedScenarioCategoriesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScenarioCategoriesCompanion.insert({
    required String id,
    required String slug,
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        slug = Value(slug),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedScenarioCategory> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScenarioCategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? slug,
      Value<int>? sortOrder,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedScenarioCategoriesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedScenarioCategoryLocalizationsTable
    extends CachedScenarioCategoryLocalizations
    with
        TableInfo<$CachedScenarioCategoryLocalizationsTable,
            CachedScenarioCategoryLocalization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScenarioCategoryLocalizationsTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [categoryId, locale, name, description, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scenario_category_localizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedScenarioCategoryLocalization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId, locale};
  @override
  CachedScenarioCategoryLocalization map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScenarioCategoryLocalization(
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedScenarioCategoryLocalizationsTable createAlias(String alias) {
    return $CachedScenarioCategoryLocalizationsTable(attachedDatabase, alias);
  }
}

class CachedScenarioCategoryLocalization extends DataClass
    implements Insertable<CachedScenarioCategoryLocalization> {
  final String categoryId;
  final String locale;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedScenarioCategoryLocalization(
      {required this.categoryId,
      required this.locale,
      required this.name,
      required this.description,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<String>(categoryId);
    map['locale'] = Variable<String>(locale);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedScenarioCategoryLocalizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedScenarioCategoryLocalizationsCompanion(
      categoryId: Value(categoryId),
      locale: Value(locale),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedScenarioCategoryLocalization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScenarioCategoryLocalization(
      categoryId: serializer.fromJson<String>(json['categoryId']),
      locale: serializer.fromJson<String>(json['locale']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<String>(categoryId),
      'locale': serializer.toJson<String>(locale),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedScenarioCategoryLocalization copyWith(
          {String? categoryId,
          String? locale,
          String? name,
          String? description,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedScenarioCategoryLocalization(
        categoryId: categoryId ?? this.categoryId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedScenarioCategoryLocalization copyWithCompanion(
      CachedScenarioCategoryLocalizationsCompanion data) {
    return CachedScenarioCategoryLocalization(
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      locale: data.locale.present ? data.locale.value : this.locale,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioCategoryLocalization(')
          ..write('categoryId: $categoryId, ')
          ..write('locale: $locale, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(categoryId, locale, name, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScenarioCategoryLocalization &&
          other.categoryId == this.categoryId &&
          other.locale == this.locale &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedScenarioCategoryLocalizationsCompanion
    extends UpdateCompanion<CachedScenarioCategoryLocalization> {
  final Value<String> categoryId;
  final Value<String> locale;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedScenarioCategoryLocalizationsCompanion({
    this.categoryId = const Value.absent(),
    this.locale = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScenarioCategoryLocalizationsCompanion.insert({
    required String categoryId,
    required String locale,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : categoryId = Value(categoryId),
        locale = Value(locale),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedScenarioCategoryLocalization> custom({
    Expression<String>? categoryId,
    Expression<String>? locale,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (locale != null) 'locale': locale,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScenarioCategoryLocalizationsCompanion copyWith(
      {Value<String>? categoryId,
      Value<String>? locale,
      Value<String>? name,
      Value<String>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedScenarioCategoryLocalizationsCompanion(
      categoryId: categoryId ?? this.categoryId,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioCategoryLocalizationsCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('locale: $locale, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMediaAssetsTable extends CachedMediaAssets
    with TableInfo<$CachedMediaAssetsTable, CachedMediaAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMediaAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storagePathMeta =
      const VerificationMeta('storagePath');
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
      'storage_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaTypeMeta =
      const VerificationMeta('mediaType');
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
      'media_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _contentHashMeta =
      const VerificationMeta('contentHash');
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
      'content_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _licenseStatusMeta =
      const VerificationMeta('licenseStatus');
  @override
  late final GeneratedColumn<String> licenseStatus = GeneratedColumn<String>(
      'license_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewStatusMeta =
      const VerificationMeta('reviewStatus');
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
      'review_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        storagePath,
        mediaType,
        mimeType,
        sizeBytes,
        contentHash,
        licenseStatus,
        reviewStatus,
        localPath,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_media_assets';
  @override
  VerificationContext validateIntegrity(Insertable<CachedMediaAsset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('storage_path')) {
      context.handle(
          _storagePathMeta,
          storagePath.isAcceptableOrUnknown(
              data['storage_path']!, _storagePathMeta));
    } else if (isInserting) {
      context.missing(_storagePathMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(_mediaTypeMeta,
          mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta));
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    }
    if (data.containsKey('content_hash')) {
      context.handle(
          _contentHashMeta,
          contentHash.isAcceptableOrUnknown(
              data['content_hash']!, _contentHashMeta));
    }
    if (data.containsKey('license_status')) {
      context.handle(
          _licenseStatusMeta,
          licenseStatus.isAcceptableOrUnknown(
              data['license_status']!, _licenseStatusMeta));
    } else if (isInserting) {
      context.missing(_licenseStatusMeta);
    }
    if (data.containsKey('review_status')) {
      context.handle(
          _reviewStatusMeta,
          reviewStatus.isAcceptableOrUnknown(
              data['review_status']!, _reviewStatusMeta));
    } else if (isInserting) {
      context.missing(_reviewStatusMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedMediaAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMediaAsset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      storagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_path'])!,
      mediaType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_type'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes']),
      contentHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_hash']),
      licenseStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}license_status'])!,
      reviewStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_status'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedMediaAssetsTable createAlias(String alias) {
    return $CachedMediaAssetsTable(attachedDatabase, alias);
  }
}

class CachedMediaAsset extends DataClass
    implements Insertable<CachedMediaAsset> {
  final String id;
  final String storagePath;
  final String mediaType;
  final String mimeType;
  final int? sizeBytes;
  final String? contentHash;
  final String licenseStatus;
  final String reviewStatus;
  final String? localPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedMediaAsset(
      {required this.id,
      required this.storagePath,
      required this.mediaType,
      required this.mimeType,
      this.sizeBytes,
      this.contentHash,
      required this.licenseStatus,
      required this.reviewStatus,
      this.localPath,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['storage_path'] = Variable<String>(storagePath);
    map['media_type'] = Variable<String>(mediaType);
    map['mime_type'] = Variable<String>(mimeType);
    if (!nullToAbsent || sizeBytes != null) {
      map['size_bytes'] = Variable<int>(sizeBytes);
    }
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['license_status'] = Variable<String>(licenseStatus);
    map['review_status'] = Variable<String>(reviewStatus);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedMediaAssetsCompanion toCompanion(bool nullToAbsent) {
    return CachedMediaAssetsCompanion(
      id: Value(id),
      storagePath: Value(storagePath),
      mediaType: Value(mediaType),
      mimeType: Value(mimeType),
      sizeBytes: sizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeBytes),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      licenseStatus: Value(licenseStatus),
      reviewStatus: Value(reviewStatus),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedMediaAsset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMediaAsset(
      id: serializer.fromJson<String>(json['id']),
      storagePath: serializer.fromJson<String>(json['storagePath']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int?>(json['sizeBytes']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      licenseStatus: serializer.fromJson<String>(json['licenseStatus']),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storagePath': serializer.toJson<String>(storagePath),
      'mediaType': serializer.toJson<String>(mediaType),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int?>(sizeBytes),
      'contentHash': serializer.toJson<String?>(contentHash),
      'licenseStatus': serializer.toJson<String>(licenseStatus),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'localPath': serializer.toJson<String?>(localPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedMediaAsset copyWith(
          {String? id,
          String? storagePath,
          String? mediaType,
          String? mimeType,
          Value<int?> sizeBytes = const Value.absent(),
          Value<String?> contentHash = const Value.absent(),
          String? licenseStatus,
          String? reviewStatus,
          Value<String?> localPath = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedMediaAsset(
        id: id ?? this.id,
        storagePath: storagePath ?? this.storagePath,
        mediaType: mediaType ?? this.mediaType,
        mimeType: mimeType ?? this.mimeType,
        sizeBytes: sizeBytes.present ? sizeBytes.value : this.sizeBytes,
        contentHash: contentHash.present ? contentHash.value : this.contentHash,
        licenseStatus: licenseStatus ?? this.licenseStatus,
        reviewStatus: reviewStatus ?? this.reviewStatus,
        localPath: localPath.present ? localPath.value : this.localPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedMediaAsset copyWithCompanion(CachedMediaAssetsCompanion data) {
    return CachedMediaAsset(
      id: data.id.present ? data.id.value : this.id,
      storagePath:
          data.storagePath.present ? data.storagePath.value : this.storagePath,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      contentHash:
          data.contentHash.present ? data.contentHash.value : this.contentHash,
      licenseStatus: data.licenseStatus.present
          ? data.licenseStatus.value
          : this.licenseStatus,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMediaAsset(')
          ..write('id: $id, ')
          ..write('storagePath: $storagePath, ')
          ..write('mediaType: $mediaType, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('contentHash: $contentHash, ')
          ..write('licenseStatus: $licenseStatus, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      storagePath,
      mediaType,
      mimeType,
      sizeBytes,
      contentHash,
      licenseStatus,
      reviewStatus,
      localPath,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMediaAsset &&
          other.id == this.id &&
          other.storagePath == this.storagePath &&
          other.mediaType == this.mediaType &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.contentHash == this.contentHash &&
          other.licenseStatus == this.licenseStatus &&
          other.reviewStatus == this.reviewStatus &&
          other.localPath == this.localPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedMediaAssetsCompanion extends UpdateCompanion<CachedMediaAsset> {
  final Value<String> id;
  final Value<String> storagePath;
  final Value<String> mediaType;
  final Value<String> mimeType;
  final Value<int?> sizeBytes;
  final Value<String?> contentHash;
  final Value<String> licenseStatus;
  final Value<String> reviewStatus;
  final Value<String?> localPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedMediaAssetsCompanion({
    this.id = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.licenseStatus = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.localPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMediaAssetsCompanion.insert({
    required String id,
    required String storagePath,
    required String mediaType,
    required String mimeType,
    this.sizeBytes = const Value.absent(),
    this.contentHash = const Value.absent(),
    required String licenseStatus,
    required String reviewStatus,
    this.localPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        storagePath = Value(storagePath),
        mediaType = Value(mediaType),
        mimeType = Value(mimeType),
        licenseStatus = Value(licenseStatus),
        reviewStatus = Value(reviewStatus),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedMediaAsset> custom({
    Expression<String>? id,
    Expression<String>? storagePath,
    Expression<String>? mediaType,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? contentHash,
    Expression<String>? licenseStatus,
    Expression<String>? reviewStatus,
    Expression<String>? localPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storagePath != null) 'storage_path': storagePath,
      if (mediaType != null) 'media_type': mediaType,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (contentHash != null) 'content_hash': contentHash,
      if (licenseStatus != null) 'license_status': licenseStatus,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (localPath != null) 'local_path': localPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMediaAssetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? storagePath,
      Value<String>? mediaType,
      Value<String>? mimeType,
      Value<int?>? sizeBytes,
      Value<String?>? contentHash,
      Value<String>? licenseStatus,
      Value<String>? reviewStatus,
      Value<String?>? localPath,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedMediaAssetsCompanion(
      id: id ?? this.id,
      storagePath: storagePath ?? this.storagePath,
      mediaType: mediaType ?? this.mediaType,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      contentHash: contentHash ?? this.contentHash,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      localPath: localPath ?? this.localPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (licenseStatus.present) {
      map['license_status'] = Variable<String>(licenseStatus.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMediaAssetsCompanion(')
          ..write('id: $id, ')
          ..write('storagePath: $storagePath, ')
          ..write('mediaType: $mediaType, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('contentHash: $contentHash, ')
          ..write('licenseStatus: $licenseStatus, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMediaLocalizationsTable extends CachedMediaLocalizations
    with TableInfo<$CachedMediaLocalizationsTable, CachedMediaLocalization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMediaLocalizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaAssetIdMeta =
      const VerificationMeta('mediaAssetId');
  @override
  late final GeneratedColumn<String> mediaAssetId = GeneratedColumn<String>(
      'media_asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _altTextMeta =
      const VerificationMeta('altText');
  @override
  late final GeneratedColumn<String> altText = GeneratedColumn<String>(
      'alt_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [mediaAssetId, locale, altText, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_media_localizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedMediaLocalization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_asset_id')) {
      context.handle(
          _mediaAssetIdMeta,
          mediaAssetId.isAcceptableOrUnknown(
              data['media_asset_id']!, _mediaAssetIdMeta));
    } else if (isInserting) {
      context.missing(_mediaAssetIdMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('alt_text')) {
      context.handle(_altTextMeta,
          altText.isAcceptableOrUnknown(data['alt_text']!, _altTextMeta));
    } else if (isInserting) {
      context.missing(_altTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaAssetId, locale};
  @override
  CachedMediaLocalization map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMediaLocalization(
      mediaAssetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_asset_id'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      altText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alt_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedMediaLocalizationsTable createAlias(String alias) {
    return $CachedMediaLocalizationsTable(attachedDatabase, alias);
  }
}

class CachedMediaLocalization extends DataClass
    implements Insertable<CachedMediaLocalization> {
  final String mediaAssetId;
  final String locale;
  final String altText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedMediaLocalization(
      {required this.mediaAssetId,
      required this.locale,
      required this.altText,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_asset_id'] = Variable<String>(mediaAssetId);
    map['locale'] = Variable<String>(locale);
    map['alt_text'] = Variable<String>(altText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedMediaLocalizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedMediaLocalizationsCompanion(
      mediaAssetId: Value(mediaAssetId),
      locale: Value(locale),
      altText: Value(altText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedMediaLocalization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMediaLocalization(
      mediaAssetId: serializer.fromJson<String>(json['mediaAssetId']),
      locale: serializer.fromJson<String>(json['locale']),
      altText: serializer.fromJson<String>(json['altText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaAssetId': serializer.toJson<String>(mediaAssetId),
      'locale': serializer.toJson<String>(locale),
      'altText': serializer.toJson<String>(altText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedMediaLocalization copyWith(
          {String? mediaAssetId,
          String? locale,
          String? altText,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedMediaLocalization(
        mediaAssetId: mediaAssetId ?? this.mediaAssetId,
        locale: locale ?? this.locale,
        altText: altText ?? this.altText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedMediaLocalization copyWithCompanion(
      CachedMediaLocalizationsCompanion data) {
    return CachedMediaLocalization(
      mediaAssetId: data.mediaAssetId.present
          ? data.mediaAssetId.value
          : this.mediaAssetId,
      locale: data.locale.present ? data.locale.value : this.locale,
      altText: data.altText.present ? data.altText.value : this.altText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMediaLocalization(')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('locale: $locale, ')
          ..write('altText: $altText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(mediaAssetId, locale, altText, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMediaLocalization &&
          other.mediaAssetId == this.mediaAssetId &&
          other.locale == this.locale &&
          other.altText == this.altText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedMediaLocalizationsCompanion
    extends UpdateCompanion<CachedMediaLocalization> {
  final Value<String> mediaAssetId;
  final Value<String> locale;
  final Value<String> altText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedMediaLocalizationsCompanion({
    this.mediaAssetId = const Value.absent(),
    this.locale = const Value.absent(),
    this.altText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMediaLocalizationsCompanion.insert({
    required String mediaAssetId,
    required String locale,
    required String altText,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : mediaAssetId = Value(mediaAssetId),
        locale = Value(locale),
        altText = Value(altText),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedMediaLocalization> custom({
    Expression<String>? mediaAssetId,
    Expression<String>? locale,
    Expression<String>? altText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaAssetId != null) 'media_asset_id': mediaAssetId,
      if (locale != null) 'locale': locale,
      if (altText != null) 'alt_text': altText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMediaLocalizationsCompanion copyWith(
      {Value<String>? mediaAssetId,
      Value<String>? locale,
      Value<String>? altText,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedMediaLocalizationsCompanion(
      mediaAssetId: mediaAssetId ?? this.mediaAssetId,
      locale: locale ?? this.locale,
      altText: altText ?? this.altText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaAssetId.present) {
      map['media_asset_id'] = Variable<String>(mediaAssetId.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (altText.present) {
      map['alt_text'] = Variable<String>(altText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMediaLocalizationsCompanion(')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('locale: $locale, ')
          ..write('altText: $altText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedScenariosTable extends CachedScenarios
    with TableInfo<$CachedScenariosTable, CachedScenario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScenariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverMediaIdMeta =
      const VerificationMeta('coverMediaId');
  @override
  late final GeneratedColumn<String> coverMediaId = GeneratedColumn<String>(
      'cover_media_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estimatedMinutesMeta =
      const VerificationMeta('estimatedMinutes');
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
      'estimated_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        slug,
        categoryId,
        coverMediaId,
        estimatedMinutes,
        status,
        version,
        publishedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scenarios';
  @override
  VerificationContext validateIntegrity(Insertable<CachedScenario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('cover_media_id')) {
      context.handle(
          _coverMediaIdMeta,
          coverMediaId.isAcceptableOrUnknown(
              data['cover_media_id']!, _coverMediaIdMeta));
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
          _estimatedMinutesMeta,
          estimatedMinutes.isAcceptableOrUnknown(
              data['estimated_minutes']!, _estimatedMinutesMeta));
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedScenario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScenario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      coverMediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_media_id']),
      estimatedMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estimated_minutes'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedScenariosTable createAlias(String alias) {
    return $CachedScenariosTable(attachedDatabase, alias);
  }
}

class CachedScenario extends DataClass implements Insertable<CachedScenario> {
  final String id;
  final String slug;
  final String categoryId;
  final String? coverMediaId;
  final int estimatedMinutes;
  final String status;
  final int version;
  final DateTime? publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedScenario(
      {required this.id,
      required this.slug,
      required this.categoryId,
      this.coverMediaId,
      required this.estimatedMinutes,
      required this.status,
      required this.version,
      this.publishedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || coverMediaId != null) {
      map['cover_media_id'] = Variable<String>(coverMediaId);
    }
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['status'] = Variable<String>(status);
    map['version'] = Variable<int>(version);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedScenariosCompanion toCompanion(bool nullToAbsent) {
    return CachedScenariosCompanion(
      id: Value(id),
      slug: Value(slug),
      categoryId: Value(categoryId),
      coverMediaId: coverMediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaId),
      estimatedMinutes: Value(estimatedMinutes),
      status: Value(status),
      version: Value(version),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedScenario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScenario(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      coverMediaId: serializer.fromJson<String?>(json['coverMediaId']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      status: serializer.fromJson<String>(json['status']),
      version: serializer.fromJson<int>(json['version']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'categoryId': serializer.toJson<String>(categoryId),
      'coverMediaId': serializer.toJson<String?>(coverMediaId),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'status': serializer.toJson<String>(status),
      'version': serializer.toJson<int>(version),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedScenario copyWith(
          {String? id,
          String? slug,
          String? categoryId,
          Value<String?> coverMediaId = const Value.absent(),
          int? estimatedMinutes,
          String? status,
          int? version,
          Value<DateTime?> publishedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedScenario(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        categoryId: categoryId ?? this.categoryId,
        coverMediaId:
            coverMediaId.present ? coverMediaId.value : this.coverMediaId,
        estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
        status: status ?? this.status,
        version: version ?? this.version,
        publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedScenario copyWithCompanion(CachedScenariosCompanion data) {
    return CachedScenario(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      coverMediaId: data.coverMediaId.present
          ? data.coverMediaId.value
          : this.coverMediaId,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      status: data.status.present ? data.status.value : this.status,
      version: data.version.present ? data.version.value : this.version,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenario(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('categoryId: $categoryId, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, categoryId, coverMediaId,
      estimatedMinutes, status, version, publishedAt, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScenario &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.categoryId == this.categoryId &&
          other.coverMediaId == this.coverMediaId &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.status == this.status &&
          other.version == this.version &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedScenariosCompanion extends UpdateCompanion<CachedScenario> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> categoryId;
  final Value<String?> coverMediaId;
  final Value<int> estimatedMinutes;
  final Value<String> status;
  final Value<int> version;
  final Value<DateTime?> publishedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedScenariosCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.version = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScenariosCompanion.insert({
    required String id,
    required String slug,
    required String categoryId,
    this.coverMediaId = const Value.absent(),
    required int estimatedMinutes,
    required String status,
    this.version = const Value.absent(),
    this.publishedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        slug = Value(slug),
        categoryId = Value(categoryId),
        estimatedMinutes = Value(estimatedMinutes),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedScenario> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? categoryId,
    Expression<String>? coverMediaId,
    Expression<int>? estimatedMinutes,
    Expression<String>? status,
    Expression<int>? version,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (categoryId != null) 'category_id': categoryId,
      if (coverMediaId != null) 'cover_media_id': coverMediaId,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (status != null) 'status': status,
      if (version != null) 'version': version,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScenariosCompanion copyWith(
      {Value<String>? id,
      Value<String>? slug,
      Value<String>? categoryId,
      Value<String?>? coverMediaId,
      Value<int>? estimatedMinutes,
      Value<String>? status,
      Value<int>? version,
      Value<DateTime?>? publishedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedScenariosCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      categoryId: categoryId ?? this.categoryId,
      coverMediaId: coverMediaId ?? this.coverMediaId,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      status: status ?? this.status,
      version: version ?? this.version,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (coverMediaId.present) {
      map['cover_media_id'] = Variable<String>(coverMediaId.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenariosCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('categoryId: $categoryId, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedScenarioLocalizationsTable extends CachedScenarioLocalizations
    with
        TableInfo<$CachedScenarioLocalizationsTable,
            CachedScenarioLocalization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScenarioLocalizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scenarioIdMeta =
      const VerificationMeta('scenarioId');
  @override
  late final GeneratedColumn<String> scenarioId = GeneratedColumn<String>(
      'scenario_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _introMeta = const VerificationMeta('intro');
  @override
  late final GeneratedColumn<String> intro = GeneratedColumn<String>(
      'intro', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _closingSummaryMeta =
      const VerificationMeta('closingSummary');
  @override
  late final GeneratedColumn<String> closingSummary = GeneratedColumn<String>(
      'closing_summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        scenarioId,
        locale,
        title,
        summary,
        intro,
        closingSummary,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scenario_localizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedScenarioLocalization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scenario_id')) {
      context.handle(
          _scenarioIdMeta,
          scenarioId.isAcceptableOrUnknown(
              data['scenario_id']!, _scenarioIdMeta));
    } else if (isInserting) {
      context.missing(_scenarioIdMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('intro')) {
      context.handle(
          _introMeta, intro.isAcceptableOrUnknown(data['intro']!, _introMeta));
    } else if (isInserting) {
      context.missing(_introMeta);
    }
    if (data.containsKey('closing_summary')) {
      context.handle(
          _closingSummaryMeta,
          closingSummary.isAcceptableOrUnknown(
              data['closing_summary']!, _closingSummaryMeta));
    } else if (isInserting) {
      context.missing(_closingSummaryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scenarioId, locale};
  @override
  CachedScenarioLocalization map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScenarioLocalization(
      scenarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scenario_id'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      intro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intro'])!,
      closingSummary: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}closing_summary'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedScenarioLocalizationsTable createAlias(String alias) {
    return $CachedScenarioLocalizationsTable(attachedDatabase, alias);
  }
}

class CachedScenarioLocalization extends DataClass
    implements Insertable<CachedScenarioLocalization> {
  final String scenarioId;
  final String locale;
  final String title;
  final String summary;
  final String intro;
  final String closingSummary;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedScenarioLocalization(
      {required this.scenarioId,
      required this.locale,
      required this.title,
      required this.summary,
      required this.intro,
      required this.closingSummary,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scenario_id'] = Variable<String>(scenarioId);
    map['locale'] = Variable<String>(locale);
    map['title'] = Variable<String>(title);
    map['summary'] = Variable<String>(summary);
    map['intro'] = Variable<String>(intro);
    map['closing_summary'] = Variable<String>(closingSummary);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedScenarioLocalizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedScenarioLocalizationsCompanion(
      scenarioId: Value(scenarioId),
      locale: Value(locale),
      title: Value(title),
      summary: Value(summary),
      intro: Value(intro),
      closingSummary: Value(closingSummary),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedScenarioLocalization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScenarioLocalization(
      scenarioId: serializer.fromJson<String>(json['scenarioId']),
      locale: serializer.fromJson<String>(json['locale']),
      title: serializer.fromJson<String>(json['title']),
      summary: serializer.fromJson<String>(json['summary']),
      intro: serializer.fromJson<String>(json['intro']),
      closingSummary: serializer.fromJson<String>(json['closingSummary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scenarioId': serializer.toJson<String>(scenarioId),
      'locale': serializer.toJson<String>(locale),
      'title': serializer.toJson<String>(title),
      'summary': serializer.toJson<String>(summary),
      'intro': serializer.toJson<String>(intro),
      'closingSummary': serializer.toJson<String>(closingSummary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedScenarioLocalization copyWith(
          {String? scenarioId,
          String? locale,
          String? title,
          String? summary,
          String? intro,
          String? closingSummary,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedScenarioLocalization(
        scenarioId: scenarioId ?? this.scenarioId,
        locale: locale ?? this.locale,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        intro: intro ?? this.intro,
        closingSummary: closingSummary ?? this.closingSummary,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedScenarioLocalization copyWithCompanion(
      CachedScenarioLocalizationsCompanion data) {
    return CachedScenarioLocalization(
      scenarioId:
          data.scenarioId.present ? data.scenarioId.value : this.scenarioId,
      locale: data.locale.present ? data.locale.value : this.locale,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      intro: data.intro.present ? data.intro.value : this.intro,
      closingSummary: data.closingSummary.present
          ? data.closingSummary.value
          : this.closingSummary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioLocalization(')
          ..write('scenarioId: $scenarioId, ')
          ..write('locale: $locale, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('intro: $intro, ')
          ..write('closingSummary: $closingSummary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scenarioId, locale, title, summary, intro,
      closingSummary, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScenarioLocalization &&
          other.scenarioId == this.scenarioId &&
          other.locale == this.locale &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.intro == this.intro &&
          other.closingSummary == this.closingSummary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedScenarioLocalizationsCompanion
    extends UpdateCompanion<CachedScenarioLocalization> {
  final Value<String> scenarioId;
  final Value<String> locale;
  final Value<String> title;
  final Value<String> summary;
  final Value<String> intro;
  final Value<String> closingSummary;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedScenarioLocalizationsCompanion({
    this.scenarioId = const Value.absent(),
    this.locale = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.intro = const Value.absent(),
    this.closingSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScenarioLocalizationsCompanion.insert({
    required String scenarioId,
    required String locale,
    required String title,
    required String summary,
    required String intro,
    required String closingSummary,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : scenarioId = Value(scenarioId),
        locale = Value(locale),
        title = Value(title),
        summary = Value(summary),
        intro = Value(intro),
        closingSummary = Value(closingSummary),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedScenarioLocalization> custom({
    Expression<String>? scenarioId,
    Expression<String>? locale,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? intro,
    Expression<String>? closingSummary,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (scenarioId != null) 'scenario_id': scenarioId,
      if (locale != null) 'locale': locale,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (intro != null) 'intro': intro,
      if (closingSummary != null) 'closing_summary': closingSummary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScenarioLocalizationsCompanion copyWith(
      {Value<String>? scenarioId,
      Value<String>? locale,
      Value<String>? title,
      Value<String>? summary,
      Value<String>? intro,
      Value<String>? closingSummary,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedScenarioLocalizationsCompanion(
      scenarioId: scenarioId ?? this.scenarioId,
      locale: locale ?? this.locale,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      intro: intro ?? this.intro,
      closingSummary: closingSummary ?? this.closingSummary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scenarioId.present) {
      map['scenario_id'] = Variable<String>(scenarioId.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (intro.present) {
      map['intro'] = Variable<String>(intro.value);
    }
    if (closingSummary.present) {
      map['closing_summary'] = Variable<String>(closingSummary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioLocalizationsCompanion(')
          ..write('scenarioId: $scenarioId, ')
          ..write('locale: $locale, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('intro: $intro, ')
          ..write('closingSummary: $closingSummary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedScenarioStepsTable extends CachedScenarioSteps
    with TableInfo<$CachedScenarioStepsTable, CachedScenarioStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScenarioStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scenarioIdMeta =
      const VerificationMeta('scenarioId');
  @override
  late final GeneratedColumn<String> scenarioId = GeneratedColumn<String>(
      'scenario_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stepKeyMeta =
      const VerificationMeta('stepKey');
  @override
  late final GeneratedColumn<String> stepKey = GeneratedColumn<String>(
      'step_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mediaAssetIdMeta =
      const VerificationMeta('mediaAssetId');
  @override
  late final GeneratedColumn<String> mediaAssetId = GeneratedColumn<String>(
      'media_asset_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scenarioId,
        stepKey,
        kind,
        orderIndex,
        mediaAssetId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scenario_steps';
  @override
  VerificationContext validateIntegrity(Insertable<CachedScenarioStep> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scenario_id')) {
      context.handle(
          _scenarioIdMeta,
          scenarioId.isAcceptableOrUnknown(
              data['scenario_id']!, _scenarioIdMeta));
    } else if (isInserting) {
      context.missing(_scenarioIdMeta);
    }
    if (data.containsKey('step_key')) {
      context.handle(_stepKeyMeta,
          stepKey.isAcceptableOrUnknown(data['step_key']!, _stepKeyMeta));
    } else if (isInserting) {
      context.missing(_stepKeyMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('media_asset_id')) {
      context.handle(
          _mediaAssetIdMeta,
          mediaAssetId.isAcceptableOrUnknown(
              data['media_asset_id']!, _mediaAssetIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedScenarioStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScenarioStep(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      scenarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scenario_id'])!,
      stepKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_key'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      mediaAssetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_asset_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedScenarioStepsTable createAlias(String alias) {
    return $CachedScenarioStepsTable(attachedDatabase, alias);
  }
}

class CachedScenarioStep extends DataClass
    implements Insertable<CachedScenarioStep> {
  final String id;
  final String scenarioId;
  final String stepKey;
  final String kind;
  final int orderIndex;
  final String? mediaAssetId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedScenarioStep(
      {required this.id,
      required this.scenarioId,
      required this.stepKey,
      required this.kind,
      required this.orderIndex,
      this.mediaAssetId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scenario_id'] = Variable<String>(scenarioId);
    map['step_key'] = Variable<String>(stepKey);
    map['kind'] = Variable<String>(kind);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || mediaAssetId != null) {
      map['media_asset_id'] = Variable<String>(mediaAssetId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedScenarioStepsCompanion toCompanion(bool nullToAbsent) {
    return CachedScenarioStepsCompanion(
      id: Value(id),
      scenarioId: Value(scenarioId),
      stepKey: Value(stepKey),
      kind: Value(kind),
      orderIndex: Value(orderIndex),
      mediaAssetId: mediaAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaAssetId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedScenarioStep.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScenarioStep(
      id: serializer.fromJson<String>(json['id']),
      scenarioId: serializer.fromJson<String>(json['scenarioId']),
      stepKey: serializer.fromJson<String>(json['stepKey']),
      kind: serializer.fromJson<String>(json['kind']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      mediaAssetId: serializer.fromJson<String?>(json['mediaAssetId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scenarioId': serializer.toJson<String>(scenarioId),
      'stepKey': serializer.toJson<String>(stepKey),
      'kind': serializer.toJson<String>(kind),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'mediaAssetId': serializer.toJson<String?>(mediaAssetId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedScenarioStep copyWith(
          {String? id,
          String? scenarioId,
          String? stepKey,
          String? kind,
          int? orderIndex,
          Value<String?> mediaAssetId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedScenarioStep(
        id: id ?? this.id,
        scenarioId: scenarioId ?? this.scenarioId,
        stepKey: stepKey ?? this.stepKey,
        kind: kind ?? this.kind,
        orderIndex: orderIndex ?? this.orderIndex,
        mediaAssetId:
            mediaAssetId.present ? mediaAssetId.value : this.mediaAssetId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedScenarioStep copyWithCompanion(CachedScenarioStepsCompanion data) {
    return CachedScenarioStep(
      id: data.id.present ? data.id.value : this.id,
      scenarioId:
          data.scenarioId.present ? data.scenarioId.value : this.scenarioId,
      stepKey: data.stepKey.present ? data.stepKey.value : this.stepKey,
      kind: data.kind.present ? data.kind.value : this.kind,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      mediaAssetId: data.mediaAssetId.present
          ? data.mediaAssetId.value
          : this.mediaAssetId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioStep(')
          ..write('id: $id, ')
          ..write('scenarioId: $scenarioId, ')
          ..write('stepKey: $stepKey, ')
          ..write('kind: $kind, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scenarioId, stepKey, kind, orderIndex,
      mediaAssetId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScenarioStep &&
          other.id == this.id &&
          other.scenarioId == this.scenarioId &&
          other.stepKey == this.stepKey &&
          other.kind == this.kind &&
          other.orderIndex == this.orderIndex &&
          other.mediaAssetId == this.mediaAssetId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedScenarioStepsCompanion extends UpdateCompanion<CachedScenarioStep> {
  final Value<String> id;
  final Value<String> scenarioId;
  final Value<String> stepKey;
  final Value<String> kind;
  final Value<int> orderIndex;
  final Value<String?> mediaAssetId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedScenarioStepsCompanion({
    this.id = const Value.absent(),
    this.scenarioId = const Value.absent(),
    this.stepKey = const Value.absent(),
    this.kind = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.mediaAssetId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScenarioStepsCompanion.insert({
    required String id,
    required String scenarioId,
    required String stepKey,
    required String kind,
    required int orderIndex,
    this.mediaAssetId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        scenarioId = Value(scenarioId),
        stepKey = Value(stepKey),
        kind = Value(kind),
        orderIndex = Value(orderIndex),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedScenarioStep> custom({
    Expression<String>? id,
    Expression<String>? scenarioId,
    Expression<String>? stepKey,
    Expression<String>? kind,
    Expression<int>? orderIndex,
    Expression<String>? mediaAssetId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scenarioId != null) 'scenario_id': scenarioId,
      if (stepKey != null) 'step_key': stepKey,
      if (kind != null) 'kind': kind,
      if (orderIndex != null) 'order_index': orderIndex,
      if (mediaAssetId != null) 'media_asset_id': mediaAssetId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScenarioStepsCompanion copyWith(
      {Value<String>? id,
      Value<String>? scenarioId,
      Value<String>? stepKey,
      Value<String>? kind,
      Value<int>? orderIndex,
      Value<String?>? mediaAssetId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedScenarioStepsCompanion(
      id: id ?? this.id,
      scenarioId: scenarioId ?? this.scenarioId,
      stepKey: stepKey ?? this.stepKey,
      kind: kind ?? this.kind,
      orderIndex: orderIndex ?? this.orderIndex,
      mediaAssetId: mediaAssetId ?? this.mediaAssetId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (scenarioId.present) {
      map['scenario_id'] = Variable<String>(scenarioId.value);
    }
    if (stepKey.present) {
      map['step_key'] = Variable<String>(stepKey.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (mediaAssetId.present) {
      map['media_asset_id'] = Variable<String>(mediaAssetId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScenarioStepsCompanion(')
          ..write('id: $id, ')
          ..write('scenarioId: $scenarioId, ')
          ..write('stepKey: $stepKey, ')
          ..write('kind: $kind, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedStepLocalizationsTable extends CachedStepLocalizations
    with TableInfo<$CachedStepLocalizationsTable, CachedStepLocalization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedStepLocalizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<String> stepId = GeneratedColumn<String>(
      'step_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyTextMeta =
      const VerificationMeta('bodyText');
  @override
  late final GeneratedColumn<String> bodyText = GeneratedColumn<String>(
      'body_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _narrationMediaIdMeta =
      const VerificationMeta('narrationMediaId');
  @override
  late final GeneratedColumn<String> narrationMediaId = GeneratedColumn<String>(
      'narration_media_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [stepId, locale, bodyText, narrationMediaId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_step_localizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedStepLocalization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta,
          stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('body_text')) {
      context.handle(_bodyTextMeta,
          bodyText.isAcceptableOrUnknown(data['body_text']!, _bodyTextMeta));
    } else if (isInserting) {
      context.missing(_bodyTextMeta);
    }
    if (data.containsKey('narration_media_id')) {
      context.handle(
          _narrationMediaIdMeta,
          narrationMediaId.isAcceptableOrUnknown(
              data['narration_media_id']!, _narrationMediaIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {stepId, locale};
  @override
  CachedStepLocalization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedStepLocalization(
      stepId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_id'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      bodyText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_text'])!,
      narrationMediaId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}narration_media_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedStepLocalizationsTable createAlias(String alias) {
    return $CachedStepLocalizationsTable(attachedDatabase, alias);
  }
}

class CachedStepLocalization extends DataClass
    implements Insertable<CachedStepLocalization> {
  final String stepId;
  final String locale;
  final String bodyText;
  final String? narrationMediaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedStepLocalization(
      {required this.stepId,
      required this.locale,
      required this.bodyText,
      this.narrationMediaId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['step_id'] = Variable<String>(stepId);
    map['locale'] = Variable<String>(locale);
    map['body_text'] = Variable<String>(bodyText);
    if (!nullToAbsent || narrationMediaId != null) {
      map['narration_media_id'] = Variable<String>(narrationMediaId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedStepLocalizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedStepLocalizationsCompanion(
      stepId: Value(stepId),
      locale: Value(locale),
      bodyText: Value(bodyText),
      narrationMediaId: narrationMediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(narrationMediaId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedStepLocalization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedStepLocalization(
      stepId: serializer.fromJson<String>(json['stepId']),
      locale: serializer.fromJson<String>(json['locale']),
      bodyText: serializer.fromJson<String>(json['bodyText']),
      narrationMediaId: serializer.fromJson<String?>(json['narrationMediaId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'stepId': serializer.toJson<String>(stepId),
      'locale': serializer.toJson<String>(locale),
      'bodyText': serializer.toJson<String>(bodyText),
      'narrationMediaId': serializer.toJson<String?>(narrationMediaId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedStepLocalization copyWith(
          {String? stepId,
          String? locale,
          String? bodyText,
          Value<String?> narrationMediaId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedStepLocalization(
        stepId: stepId ?? this.stepId,
        locale: locale ?? this.locale,
        bodyText: bodyText ?? this.bodyText,
        narrationMediaId: narrationMediaId.present
            ? narrationMediaId.value
            : this.narrationMediaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedStepLocalization copyWithCompanion(
      CachedStepLocalizationsCompanion data) {
    return CachedStepLocalization(
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      locale: data.locale.present ? data.locale.value : this.locale,
      bodyText: data.bodyText.present ? data.bodyText.value : this.bodyText,
      narrationMediaId: data.narrationMediaId.present
          ? data.narrationMediaId.value
          : this.narrationMediaId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedStepLocalization(')
          ..write('stepId: $stepId, ')
          ..write('locale: $locale, ')
          ..write('bodyText: $bodyText, ')
          ..write('narrationMediaId: $narrationMediaId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      stepId, locale, bodyText, narrationMediaId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedStepLocalization &&
          other.stepId == this.stepId &&
          other.locale == this.locale &&
          other.bodyText == this.bodyText &&
          other.narrationMediaId == this.narrationMediaId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedStepLocalizationsCompanion
    extends UpdateCompanion<CachedStepLocalization> {
  final Value<String> stepId;
  final Value<String> locale;
  final Value<String> bodyText;
  final Value<String?> narrationMediaId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedStepLocalizationsCompanion({
    this.stepId = const Value.absent(),
    this.locale = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.narrationMediaId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedStepLocalizationsCompanion.insert({
    required String stepId,
    required String locale,
    required String bodyText,
    this.narrationMediaId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : stepId = Value(stepId),
        locale = Value(locale),
        bodyText = Value(bodyText),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedStepLocalization> custom({
    Expression<String>? stepId,
    Expression<String>? locale,
    Expression<String>? bodyText,
    Expression<String>? narrationMediaId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (stepId != null) 'step_id': stepId,
      if (locale != null) 'locale': locale,
      if (bodyText != null) 'body_text': bodyText,
      if (narrationMediaId != null) 'narration_media_id': narrationMediaId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedStepLocalizationsCompanion copyWith(
      {Value<String>? stepId,
      Value<String>? locale,
      Value<String>? bodyText,
      Value<String?>? narrationMediaId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedStepLocalizationsCompanion(
      stepId: stepId ?? this.stepId,
      locale: locale ?? this.locale,
      bodyText: bodyText ?? this.bodyText,
      narrationMediaId: narrationMediaId ?? this.narrationMediaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (bodyText.present) {
      map['body_text'] = Variable<String>(bodyText.value);
    }
    if (narrationMediaId.present) {
      map['narration_media_id'] = Variable<String>(narrationMediaId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedStepLocalizationsCompanion(')
          ..write('stepId: $stepId, ')
          ..write('locale: $locale, ')
          ..write('bodyText: $bodyText, ')
          ..write('narrationMediaId: $narrationMediaId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedAnswerOptionsTable extends CachedAnswerOptions
    with TableInfo<$CachedAnswerOptionsTable, CachedAnswerOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAnswerOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<String> stepId = GeneratedColumn<String>(
      'step_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionKeyMeta =
      const VerificationMeta('optionKey');
  @override
  late final GeneratedColumn<String> optionKey = GeneratedColumn<String>(
      'option_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreValueMeta =
      const VerificationMeta('scoreValue');
  @override
  late final GeneratedColumn<int> scoreValue = GeneratedColumn<int>(
      'score_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _safetyCategoryMeta =
      const VerificationMeta('safetyCategory');
  @override
  late final GeneratedColumn<String> safetyCategory = GeneratedColumn<String>(
      'safety_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextStepIdMeta =
      const VerificationMeta('nextStepId');
  @override
  late final GeneratedColumn<String> nextStepId = GeneratedColumn<String>(
      'next_step_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        stepId,
        optionKey,
        orderIndex,
        scoreValue,
        safetyCategory,
        nextStepId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_answer_options';
  @override
  VerificationContext validateIntegrity(Insertable<CachedAnswerOption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta,
          stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('option_key')) {
      context.handle(_optionKeyMeta,
          optionKey.isAcceptableOrUnknown(data['option_key']!, _optionKeyMeta));
    } else if (isInserting) {
      context.missing(_optionKeyMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('score_value')) {
      context.handle(
          _scoreValueMeta,
          scoreValue.isAcceptableOrUnknown(
              data['score_value']!, _scoreValueMeta));
    }
    if (data.containsKey('safety_category')) {
      context.handle(
          _safetyCategoryMeta,
          safetyCategory.isAcceptableOrUnknown(
              data['safety_category']!, _safetyCategoryMeta));
    } else if (isInserting) {
      context.missing(_safetyCategoryMeta);
    }
    if (data.containsKey('next_step_id')) {
      context.handle(
          _nextStepIdMeta,
          nextStepId.isAcceptableOrUnknown(
              data['next_step_id']!, _nextStepIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedAnswerOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAnswerOption(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      stepId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_id'])!,
      optionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option_key'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      scoreValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score_value'])!,
      safetyCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}safety_category'])!,
      nextStepId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_step_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedAnswerOptionsTable createAlias(String alias) {
    return $CachedAnswerOptionsTable(attachedDatabase, alias);
  }
}

class CachedAnswerOption extends DataClass
    implements Insertable<CachedAnswerOption> {
  final String id;
  final String stepId;
  final String optionKey;
  final int orderIndex;
  final int scoreValue;
  final String safetyCategory;
  final String? nextStepId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedAnswerOption(
      {required this.id,
      required this.stepId,
      required this.optionKey,
      required this.orderIndex,
      required this.scoreValue,
      required this.safetyCategory,
      this.nextStepId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['step_id'] = Variable<String>(stepId);
    map['option_key'] = Variable<String>(optionKey);
    map['order_index'] = Variable<int>(orderIndex);
    map['score_value'] = Variable<int>(scoreValue);
    map['safety_category'] = Variable<String>(safetyCategory);
    if (!nullToAbsent || nextStepId != null) {
      map['next_step_id'] = Variable<String>(nextStepId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedAnswerOptionsCompanion toCompanion(bool nullToAbsent) {
    return CachedAnswerOptionsCompanion(
      id: Value(id),
      stepId: Value(stepId),
      optionKey: Value(optionKey),
      orderIndex: Value(orderIndex),
      scoreValue: Value(scoreValue),
      safetyCategory: Value(safetyCategory),
      nextStepId: nextStepId == null && nullToAbsent
          ? const Value.absent()
          : Value(nextStepId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedAnswerOption.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAnswerOption(
      id: serializer.fromJson<String>(json['id']),
      stepId: serializer.fromJson<String>(json['stepId']),
      optionKey: serializer.fromJson<String>(json['optionKey']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      scoreValue: serializer.fromJson<int>(json['scoreValue']),
      safetyCategory: serializer.fromJson<String>(json['safetyCategory']),
      nextStepId: serializer.fromJson<String?>(json['nextStepId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'stepId': serializer.toJson<String>(stepId),
      'optionKey': serializer.toJson<String>(optionKey),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'scoreValue': serializer.toJson<int>(scoreValue),
      'safetyCategory': serializer.toJson<String>(safetyCategory),
      'nextStepId': serializer.toJson<String?>(nextStepId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedAnswerOption copyWith(
          {String? id,
          String? stepId,
          String? optionKey,
          int? orderIndex,
          int? scoreValue,
          String? safetyCategory,
          Value<String?> nextStepId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedAnswerOption(
        id: id ?? this.id,
        stepId: stepId ?? this.stepId,
        optionKey: optionKey ?? this.optionKey,
        orderIndex: orderIndex ?? this.orderIndex,
        scoreValue: scoreValue ?? this.scoreValue,
        safetyCategory: safetyCategory ?? this.safetyCategory,
        nextStepId: nextStepId.present ? nextStepId.value : this.nextStepId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedAnswerOption copyWithCompanion(CachedAnswerOptionsCompanion data) {
    return CachedAnswerOption(
      id: data.id.present ? data.id.value : this.id,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      optionKey: data.optionKey.present ? data.optionKey.value : this.optionKey,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      scoreValue:
          data.scoreValue.present ? data.scoreValue.value : this.scoreValue,
      safetyCategory: data.safetyCategory.present
          ? data.safetyCategory.value
          : this.safetyCategory,
      nextStepId:
          data.nextStepId.present ? data.nextStepId.value : this.nextStepId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnswerOption(')
          ..write('id: $id, ')
          ..write('stepId: $stepId, ')
          ..write('optionKey: $optionKey, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('scoreValue: $scoreValue, ')
          ..write('safetyCategory: $safetyCategory, ')
          ..write('nextStepId: $nextStepId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stepId, optionKey, orderIndex, scoreValue,
      safetyCategory, nextStepId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAnswerOption &&
          other.id == this.id &&
          other.stepId == this.stepId &&
          other.optionKey == this.optionKey &&
          other.orderIndex == this.orderIndex &&
          other.scoreValue == this.scoreValue &&
          other.safetyCategory == this.safetyCategory &&
          other.nextStepId == this.nextStepId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedAnswerOptionsCompanion extends UpdateCompanion<CachedAnswerOption> {
  final Value<String> id;
  final Value<String> stepId;
  final Value<String> optionKey;
  final Value<int> orderIndex;
  final Value<int> scoreValue;
  final Value<String> safetyCategory;
  final Value<String?> nextStepId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedAnswerOptionsCompanion({
    this.id = const Value.absent(),
    this.stepId = const Value.absent(),
    this.optionKey = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.scoreValue = const Value.absent(),
    this.safetyCategory = const Value.absent(),
    this.nextStepId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAnswerOptionsCompanion.insert({
    required String id,
    required String stepId,
    required String optionKey,
    required int orderIndex,
    this.scoreValue = const Value.absent(),
    required String safetyCategory,
    this.nextStepId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        stepId = Value(stepId),
        optionKey = Value(optionKey),
        orderIndex = Value(orderIndex),
        safetyCategory = Value(safetyCategory),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedAnswerOption> custom({
    Expression<String>? id,
    Expression<String>? stepId,
    Expression<String>? optionKey,
    Expression<int>? orderIndex,
    Expression<int>? scoreValue,
    Expression<String>? safetyCategory,
    Expression<String>? nextStepId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stepId != null) 'step_id': stepId,
      if (optionKey != null) 'option_key': optionKey,
      if (orderIndex != null) 'order_index': orderIndex,
      if (scoreValue != null) 'score_value': scoreValue,
      if (safetyCategory != null) 'safety_category': safetyCategory,
      if (nextStepId != null) 'next_step_id': nextStepId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAnswerOptionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? stepId,
      Value<String>? optionKey,
      Value<int>? orderIndex,
      Value<int>? scoreValue,
      Value<String>? safetyCategory,
      Value<String?>? nextStepId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedAnswerOptionsCompanion(
      id: id ?? this.id,
      stepId: stepId ?? this.stepId,
      optionKey: optionKey ?? this.optionKey,
      orderIndex: orderIndex ?? this.orderIndex,
      scoreValue: scoreValue ?? this.scoreValue,
      safetyCategory: safetyCategory ?? this.safetyCategory,
      nextStepId: nextStepId ?? this.nextStepId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (optionKey.present) {
      map['option_key'] = Variable<String>(optionKey.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (scoreValue.present) {
      map['score_value'] = Variable<int>(scoreValue.value);
    }
    if (safetyCategory.present) {
      map['safety_category'] = Variable<String>(safetyCategory.value);
    }
    if (nextStepId.present) {
      map['next_step_id'] = Variable<String>(nextStepId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnswerOptionsCompanion(')
          ..write('id: $id, ')
          ..write('stepId: $stepId, ')
          ..write('optionKey: $optionKey, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('scoreValue: $scoreValue, ')
          ..write('safetyCategory: $safetyCategory, ')
          ..write('nextStepId: $nextStepId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedAnswerLocalizationsTable extends CachedAnswerLocalizations
    with TableInfo<$CachedAnswerLocalizationsTable, CachedAnswerLocalization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAnswerLocalizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _optionIdMeta =
      const VerificationMeta('optionId');
  @override
  late final GeneratedColumn<String> optionId = GeneratedColumn<String>(
      'option_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _feedbackTextMeta =
      const VerificationMeta('feedbackText');
  @override
  late final GeneratedColumn<String> feedbackText = GeneratedColumn<String>(
      'feedback_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [optionId, locale, label, feedbackText, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_answer_localizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<CachedAnswerLocalization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('option_id')) {
      context.handle(_optionIdMeta,
          optionId.isAcceptableOrUnknown(data['option_id']!, _optionIdMeta));
    } else if (isInserting) {
      context.missing(_optionIdMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('feedback_text')) {
      context.handle(
          _feedbackTextMeta,
          feedbackText.isAcceptableOrUnknown(
              data['feedback_text']!, _feedbackTextMeta));
    } else if (isInserting) {
      context.missing(_feedbackTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {optionId, locale};
  @override
  CachedAnswerLocalization map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAnswerLocalization(
      optionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option_id'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      feedbackText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feedback_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedAnswerLocalizationsTable createAlias(String alias) {
    return $CachedAnswerLocalizationsTable(attachedDatabase, alias);
  }
}

class CachedAnswerLocalization extends DataClass
    implements Insertable<CachedAnswerLocalization> {
  final String optionId;
  final String locale;
  final String label;
  final String feedbackText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedAnswerLocalization(
      {required this.optionId,
      required this.locale,
      required this.label,
      required this.feedbackText,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['option_id'] = Variable<String>(optionId);
    map['locale'] = Variable<String>(locale);
    map['label'] = Variable<String>(label);
    map['feedback_text'] = Variable<String>(feedbackText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedAnswerLocalizationsCompanion toCompanion(bool nullToAbsent) {
    return CachedAnswerLocalizationsCompanion(
      optionId: Value(optionId),
      locale: Value(locale),
      label: Value(label),
      feedbackText: Value(feedbackText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedAnswerLocalization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAnswerLocalization(
      optionId: serializer.fromJson<String>(json['optionId']),
      locale: serializer.fromJson<String>(json['locale']),
      label: serializer.fromJson<String>(json['label']),
      feedbackText: serializer.fromJson<String>(json['feedbackText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'optionId': serializer.toJson<String>(optionId),
      'locale': serializer.toJson<String>(locale),
      'label': serializer.toJson<String>(label),
      'feedbackText': serializer.toJson<String>(feedbackText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedAnswerLocalization copyWith(
          {String? optionId,
          String? locale,
          String? label,
          String? feedbackText,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CachedAnswerLocalization(
        optionId: optionId ?? this.optionId,
        locale: locale ?? this.locale,
        label: label ?? this.label,
        feedbackText: feedbackText ?? this.feedbackText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedAnswerLocalization copyWithCompanion(
      CachedAnswerLocalizationsCompanion data) {
    return CachedAnswerLocalization(
      optionId: data.optionId.present ? data.optionId.value : this.optionId,
      locale: data.locale.present ? data.locale.value : this.locale,
      label: data.label.present ? data.label.value : this.label,
      feedbackText: data.feedbackText.present
          ? data.feedbackText.value
          : this.feedbackText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnswerLocalization(')
          ..write('optionId: $optionId, ')
          ..write('locale: $locale, ')
          ..write('label: $label, ')
          ..write('feedbackText: $feedbackText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(optionId, locale, label, feedbackText, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAnswerLocalization &&
          other.optionId == this.optionId &&
          other.locale == this.locale &&
          other.label == this.label &&
          other.feedbackText == this.feedbackText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedAnswerLocalizationsCompanion
    extends UpdateCompanion<CachedAnswerLocalization> {
  final Value<String> optionId;
  final Value<String> locale;
  final Value<String> label;
  final Value<String> feedbackText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedAnswerLocalizationsCompanion({
    this.optionId = const Value.absent(),
    this.locale = const Value.absent(),
    this.label = const Value.absent(),
    this.feedbackText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAnswerLocalizationsCompanion.insert({
    required String optionId,
    required String locale,
    required String label,
    required String feedbackText,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : optionId = Value(optionId),
        locale = Value(locale),
        label = Value(label),
        feedbackText = Value(feedbackText),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CachedAnswerLocalization> custom({
    Expression<String>? optionId,
    Expression<String>? locale,
    Expression<String>? label,
    Expression<String>? feedbackText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (optionId != null) 'option_id': optionId,
      if (locale != null) 'locale': locale,
      if (label != null) 'label': label,
      if (feedbackText != null) 'feedback_text': feedbackText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAnswerLocalizationsCompanion copyWith(
      {Value<String>? optionId,
      Value<String>? locale,
      Value<String>? label,
      Value<String>? feedbackText,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedAnswerLocalizationsCompanion(
      optionId: optionId ?? this.optionId,
      locale: locale ?? this.locale,
      label: label ?? this.label,
      feedbackText: feedbackText ?? this.feedbackText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (optionId.present) {
      map['option_id'] = Variable<String>(optionId.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (feedbackText.present) {
      map['feedback_text'] = Variable<String>(feedbackText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnswerLocalizationsCompanion(')
          ..write('optionId: $optionId, ')
          ..write('locale: $locale, ')
          ..write('label: $label, ')
          ..write('feedbackText: $feedbackText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GuestAttemptsTable extends GuestAttempts
    with TableInfo<$GuestAttemptsTable, GuestAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuestAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attemptIdMeta =
      const VerificationMeta('attemptId');
  @override
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
      'attempt_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scenarioIdMeta =
      const VerificationMeta('scenarioId');
  @override
  late final GeneratedColumn<String> scenarioId = GeneratedColumn<String>(
      'scenario_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scenarioVersionMeta =
      const VerificationMeta('scenarioVersion');
  @override
  late final GeneratedColumn<int> scenarioVersion = GeneratedColumn<int>(
      'scenario_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _answersJsonMeta =
      const VerificationMeta('answersJson');
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
      'answers_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _scoreLocalMeta =
      const VerificationMeta('scoreLocal');
  @override
  late final GeneratedColumn<int> scoreLocal = GeneratedColumn<int>(
      'score_local', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        attemptId,
        scenarioId,
        scenarioVersion,
        answersJson,
        scoreLocal,
        completed,
        completedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guest_attempts';
  @override
  VerificationContext validateIntegrity(Insertable<GuestAttempt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attempt_id')) {
      context.handle(_attemptIdMeta,
          attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta));
    } else if (isInserting) {
      context.missing(_attemptIdMeta);
    }
    if (data.containsKey('scenario_id')) {
      context.handle(
          _scenarioIdMeta,
          scenarioId.isAcceptableOrUnknown(
              data['scenario_id']!, _scenarioIdMeta));
    } else if (isInserting) {
      context.missing(_scenarioIdMeta);
    }
    if (data.containsKey('scenario_version')) {
      context.handle(
          _scenarioVersionMeta,
          scenarioVersion.isAcceptableOrUnknown(
              data['scenario_version']!, _scenarioVersionMeta));
    } else if (isInserting) {
      context.missing(_scenarioVersionMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
          _answersJsonMeta,
          answersJson.isAcceptableOrUnknown(
              data['answers_json']!, _answersJsonMeta));
    }
    if (data.containsKey('score_local')) {
      context.handle(
          _scoreLocalMeta,
          scoreLocal.isAcceptableOrUnknown(
              data['score_local']!, _scoreLocalMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attemptId};
  @override
  GuestAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuestAttempt(
      attemptId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attempt_id'])!,
      scenarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scenario_id'])!,
      scenarioVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scenario_version'])!,
      answersJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answers_json'])!,
      scoreLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score_local'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $GuestAttemptsTable createAlias(String alias) {
    return $GuestAttemptsTable(attachedDatabase, alias);
  }
}

class GuestAttempt extends DataClass implements Insertable<GuestAttempt> {
  final String attemptId;
  final String scenarioId;
  final int scenarioVersion;
  final String answersJson;
  final int scoreLocal;
  final bool completed;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GuestAttempt(
      {required this.attemptId,
      required this.scenarioId,
      required this.scenarioVersion,
      required this.answersJson,
      required this.scoreLocal,
      required this.completed,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attempt_id'] = Variable<String>(attemptId);
    map['scenario_id'] = Variable<String>(scenarioId);
    map['scenario_version'] = Variable<int>(scenarioVersion);
    map['answers_json'] = Variable<String>(answersJson);
    map['score_local'] = Variable<int>(scoreLocal);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GuestAttemptsCompanion toCompanion(bool nullToAbsent) {
    return GuestAttemptsCompanion(
      attemptId: Value(attemptId),
      scenarioId: Value(scenarioId),
      scenarioVersion: Value(scenarioVersion),
      answersJson: Value(answersJson),
      scoreLocal: Value(scoreLocal),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GuestAttempt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuestAttempt(
      attemptId: serializer.fromJson<String>(json['attemptId']),
      scenarioId: serializer.fromJson<String>(json['scenarioId']),
      scenarioVersion: serializer.fromJson<int>(json['scenarioVersion']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      scoreLocal: serializer.fromJson<int>(json['scoreLocal']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attemptId': serializer.toJson<String>(attemptId),
      'scenarioId': serializer.toJson<String>(scenarioId),
      'scenarioVersion': serializer.toJson<int>(scenarioVersion),
      'answersJson': serializer.toJson<String>(answersJson),
      'scoreLocal': serializer.toJson<int>(scoreLocal),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GuestAttempt copyWith(
          {String? attemptId,
          String? scenarioId,
          int? scenarioVersion,
          String? answersJson,
          int? scoreLocal,
          bool? completed,
          Value<DateTime?> completedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GuestAttempt(
        attemptId: attemptId ?? this.attemptId,
        scenarioId: scenarioId ?? this.scenarioId,
        scenarioVersion: scenarioVersion ?? this.scenarioVersion,
        answersJson: answersJson ?? this.answersJson,
        scoreLocal: scoreLocal ?? this.scoreLocal,
        completed: completed ?? this.completed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GuestAttempt copyWithCompanion(GuestAttemptsCompanion data) {
    return GuestAttempt(
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      scenarioId:
          data.scenarioId.present ? data.scenarioId.value : this.scenarioId,
      scenarioVersion: data.scenarioVersion.present
          ? data.scenarioVersion.value
          : this.scenarioVersion,
      answersJson:
          data.answersJson.present ? data.answersJson.value : this.answersJson,
      scoreLocal:
          data.scoreLocal.present ? data.scoreLocal.value : this.scoreLocal,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuestAttempt(')
          ..write('attemptId: $attemptId, ')
          ..write('scenarioId: $scenarioId, ')
          ..write('scenarioVersion: $scenarioVersion, ')
          ..write('answersJson: $answersJson, ')
          ..write('scoreLocal: $scoreLocal, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attemptId, scenarioId, scenarioVersion,
      answersJson, scoreLocal, completed, completedAt, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuestAttempt &&
          other.attemptId == this.attemptId &&
          other.scenarioId == this.scenarioId &&
          other.scenarioVersion == this.scenarioVersion &&
          other.answersJson == this.answersJson &&
          other.scoreLocal == this.scoreLocal &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GuestAttemptsCompanion extends UpdateCompanion<GuestAttempt> {
  final Value<String> attemptId;
  final Value<String> scenarioId;
  final Value<int> scenarioVersion;
  final Value<String> answersJson;
  final Value<int> scoreLocal;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GuestAttemptsCompanion({
    this.attemptId = const Value.absent(),
    this.scenarioId = const Value.absent(),
    this.scenarioVersion = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.scoreLocal = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GuestAttemptsCompanion.insert({
    required String attemptId,
    required String scenarioId,
    required int scenarioVersion,
    this.answersJson = const Value.absent(),
    this.scoreLocal = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : attemptId = Value(attemptId),
        scenarioId = Value(scenarioId),
        scenarioVersion = Value(scenarioVersion),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GuestAttempt> custom({
    Expression<String>? attemptId,
    Expression<String>? scenarioId,
    Expression<int>? scenarioVersion,
    Expression<String>? answersJson,
    Expression<int>? scoreLocal,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attemptId != null) 'attempt_id': attemptId,
      if (scenarioId != null) 'scenario_id': scenarioId,
      if (scenarioVersion != null) 'scenario_version': scenarioVersion,
      if (answersJson != null) 'answers_json': answersJson,
      if (scoreLocal != null) 'score_local': scoreLocal,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GuestAttemptsCompanion copyWith(
      {Value<String>? attemptId,
      Value<String>? scenarioId,
      Value<int>? scenarioVersion,
      Value<String>? answersJson,
      Value<int>? scoreLocal,
      Value<bool>? completed,
      Value<DateTime?>? completedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return GuestAttemptsCompanion(
      attemptId: attemptId ?? this.attemptId,
      scenarioId: scenarioId ?? this.scenarioId,
      scenarioVersion: scenarioVersion ?? this.scenarioVersion,
      answersJson: answersJson ?? this.answersJson,
      scoreLocal: scoreLocal ?? this.scoreLocal,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (scenarioId.present) {
      map['scenario_id'] = Variable<String>(scenarioId.value);
    }
    if (scenarioVersion.present) {
      map['scenario_version'] = Variable<int>(scenarioVersion.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (scoreLocal.present) {
      map['score_local'] = Variable<int>(scoreLocal.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuestAttemptsCompanion(')
          ..write('attemptId: $attemptId, ')
          ..write('scenarioId: $scenarioId, ')
          ..write('scenarioVersion: $scenarioVersion, ')
          ..write('answersJson: $answersJson, ')
          ..write('scoreLocal: $scoreLocal, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(Insertable<AppPreference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreference(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreference extends DataClass implements Insertable<AppPreference> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppPreference(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppPreference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreference(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppPreference copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppPreference(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppPreference copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreference(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreference(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreference &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreference> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<AppPreference> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPreferencesCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<SyncMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    } else if (isInserting) {
      context.missing(_lastSyncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at'])!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final String value;
  final DateTime lastSyncedAt;
  const SyncMetadataData(
      {required this.key, required this.value, required this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      value: Value(value),
      lastSyncedAt: Value(lastSyncedAt),
    );
  }

  factory SyncMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      lastSyncedAt: serializer.fromJson<DateTime>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'lastSyncedAt': serializer.toJson<DateTime>(lastSyncedAt),
    };
  }

  SyncMetadataData copyWith(
          {String? key, String? value, DateTime? lastSyncedAt}) =>
      SyncMetadataData(
        key: key ?? this.key,
        value: value ?? this.value,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> lastSyncedAt;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required String value,
    required DateTime lastSyncedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        lastSyncedAt = Value(lastSyncedAt);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? lastSyncedAt,
      Value<int>? rowid}) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedScenarioCategoriesTable cachedScenarioCategories =
      $CachedScenarioCategoriesTable(this);
  late final $CachedScenarioCategoryLocalizationsTable
      cachedScenarioCategoryLocalizations =
      $CachedScenarioCategoryLocalizationsTable(this);
  late final $CachedMediaAssetsTable cachedMediaAssets =
      $CachedMediaAssetsTable(this);
  late final $CachedMediaLocalizationsTable cachedMediaLocalizations =
      $CachedMediaLocalizationsTable(this);
  late final $CachedScenariosTable cachedScenarios =
      $CachedScenariosTable(this);
  late final $CachedScenarioLocalizationsTable cachedScenarioLocalizations =
      $CachedScenarioLocalizationsTable(this);
  late final $CachedScenarioStepsTable cachedScenarioSteps =
      $CachedScenarioStepsTable(this);
  late final $CachedStepLocalizationsTable cachedStepLocalizations =
      $CachedStepLocalizationsTable(this);
  late final $CachedAnswerOptionsTable cachedAnswerOptions =
      $CachedAnswerOptionsTable(this);
  late final $CachedAnswerLocalizationsTable cachedAnswerLocalizations =
      $CachedAnswerLocalizationsTable(this);
  late final $GuestAttemptsTable guestAttempts = $GuestAttemptsTable(this);
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cachedScenarioCategories,
        cachedScenarioCategoryLocalizations,
        cachedMediaAssets,
        cachedMediaLocalizations,
        cachedScenarios,
        cachedScenarioLocalizations,
        cachedScenarioSteps,
        cachedStepLocalizations,
        cachedAnswerOptions,
        cachedAnswerLocalizations,
        guestAttempts,
        appPreferences,
        syncMetadata
      ];
}

typedef $$CachedScenarioCategoriesTableCreateCompanionBuilder
    = CachedScenarioCategoriesCompanion Function({
  required String id,
  required String slug,
  Value<int> sortOrder,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedScenarioCategoriesTableUpdateCompanionBuilder
    = CachedScenarioCategoriesCompanion Function({
  Value<String> id,
  Value<String> slug,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedScenarioCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoriesTable> {
  $$CachedScenarioCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedScenarioCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoriesTable> {
  $$CachedScenarioCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedScenarioCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoriesTable> {
  $$CachedScenarioCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedScenarioCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedScenarioCategoriesTable,
    CachedScenarioCategory,
    $$CachedScenarioCategoriesTableFilterComposer,
    $$CachedScenarioCategoriesTableOrderingComposer,
    $$CachedScenarioCategoriesTableAnnotationComposer,
    $$CachedScenarioCategoriesTableCreateCompanionBuilder,
    $$CachedScenarioCategoriesTableUpdateCompanionBuilder,
    (
      CachedScenarioCategory,
      BaseReferences<_$AppDatabase, $CachedScenarioCategoriesTable,
          CachedScenarioCategory>
    ),
    CachedScenarioCategory,
    PrefetchHooks Function()> {
  $$CachedScenarioCategoriesTableTableManager(
      _$AppDatabase db, $CachedScenarioCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedScenarioCategoriesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedScenarioCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedScenarioCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioCategoriesCompanion(
            id: id,
            slug: slug,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String slug,
            Value<int> sortOrder = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioCategoriesCompanion.insert(
            id: id,
            slug: slug,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedScenarioCategoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedScenarioCategoriesTable,
        CachedScenarioCategory,
        $$CachedScenarioCategoriesTableFilterComposer,
        $$CachedScenarioCategoriesTableOrderingComposer,
        $$CachedScenarioCategoriesTableAnnotationComposer,
        $$CachedScenarioCategoriesTableCreateCompanionBuilder,
        $$CachedScenarioCategoriesTableUpdateCompanionBuilder,
        (
          CachedScenarioCategory,
          BaseReferences<_$AppDatabase, $CachedScenarioCategoriesTable,
              CachedScenarioCategory>
        ),
        CachedScenarioCategory,
        PrefetchHooks Function()>;
typedef $$CachedScenarioCategoryLocalizationsTableCreateCompanionBuilder
    = CachedScenarioCategoryLocalizationsCompanion Function({
  required String categoryId,
  required String locale,
  required String name,
  Value<String> description,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedScenarioCategoryLocalizationsTableUpdateCompanionBuilder
    = CachedScenarioCategoryLocalizationsCompanion Function({
  Value<String> categoryId,
  Value<String> locale,
  Value<String> name,
  Value<String> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedScenarioCategoryLocalizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoryLocalizationsTable> {
  $$CachedScenarioCategoryLocalizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedScenarioCategoryLocalizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoryLocalizationsTable> {
  $$CachedScenarioCategoryLocalizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedScenarioCategoryLocalizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedScenarioCategoryLocalizationsTable> {
  $$CachedScenarioCategoryLocalizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedScenarioCategoryLocalizationsTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $CachedScenarioCategoryLocalizationsTable,
        CachedScenarioCategoryLocalization,
        $$CachedScenarioCategoryLocalizationsTableFilterComposer,
        $$CachedScenarioCategoryLocalizationsTableOrderingComposer,
        $$CachedScenarioCategoryLocalizationsTableAnnotationComposer,
        $$CachedScenarioCategoryLocalizationsTableCreateCompanionBuilder,
        $$CachedScenarioCategoryLocalizationsTableUpdateCompanionBuilder,
        (
          CachedScenarioCategoryLocalization,
          BaseReferences<
              _$AppDatabase,
              $CachedScenarioCategoryLocalizationsTable,
              CachedScenarioCategoryLocalization>
        ),
        CachedScenarioCategoryLocalization,
        PrefetchHooks Function()> {
  $$CachedScenarioCategoryLocalizationsTableTableManager(
      _$AppDatabase db, $CachedScenarioCategoryLocalizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedScenarioCategoryLocalizationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedScenarioCategoryLocalizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedScenarioCategoryLocalizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> categoryId = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioCategoryLocalizationsCompanion(
            categoryId: categoryId,
            locale: locale,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String categoryId,
            required String locale,
            required String name,
            Value<String> description = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioCategoryLocalizationsCompanion.insert(
            categoryId: categoryId,
            locale: locale,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedScenarioCategoryLocalizationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedScenarioCategoryLocalizationsTable,
        CachedScenarioCategoryLocalization,
        $$CachedScenarioCategoryLocalizationsTableFilterComposer,
        $$CachedScenarioCategoryLocalizationsTableOrderingComposer,
        $$CachedScenarioCategoryLocalizationsTableAnnotationComposer,
        $$CachedScenarioCategoryLocalizationsTableCreateCompanionBuilder,
        $$CachedScenarioCategoryLocalizationsTableUpdateCompanionBuilder,
        (
          CachedScenarioCategoryLocalization,
          BaseReferences<
              _$AppDatabase,
              $CachedScenarioCategoryLocalizationsTable,
              CachedScenarioCategoryLocalization>
        ),
        CachedScenarioCategoryLocalization,
        PrefetchHooks Function()>;
typedef $$CachedMediaAssetsTableCreateCompanionBuilder
    = CachedMediaAssetsCompanion Function({
  required String id,
  required String storagePath,
  required String mediaType,
  required String mimeType,
  Value<int?> sizeBytes,
  Value<String?> contentHash,
  required String licenseStatus,
  required String reviewStatus,
  Value<String?> localPath,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedMediaAssetsTableUpdateCompanionBuilder
    = CachedMediaAssetsCompanion Function({
  Value<String> id,
  Value<String> storagePath,
  Value<String> mediaType,
  Value<String> mimeType,
  Value<int?> sizeBytes,
  Value<String?> contentHash,
  Value<String> licenseStatus,
  Value<String> reviewStatus,
  Value<String?> localPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedMediaAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMediaAssetsTable> {
  $$CachedMediaAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentHash => $composableBuilder(
      column: $table.contentHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get licenseStatus => $composableBuilder(
      column: $table.licenseStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedMediaAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMediaAssetsTable> {
  $$CachedMediaAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentHash => $composableBuilder(
      column: $table.contentHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get licenseStatus => $composableBuilder(
      column: $table.licenseStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedMediaAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMediaAssetsTable> {
  $$CachedMediaAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
      column: $table.contentHash, builder: (column) => column);

  GeneratedColumn<String> get licenseStatus => $composableBuilder(
      column: $table.licenseStatus, builder: (column) => column);

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedMediaAssetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedMediaAssetsTable,
    CachedMediaAsset,
    $$CachedMediaAssetsTableFilterComposer,
    $$CachedMediaAssetsTableOrderingComposer,
    $$CachedMediaAssetsTableAnnotationComposer,
    $$CachedMediaAssetsTableCreateCompanionBuilder,
    $$CachedMediaAssetsTableUpdateCompanionBuilder,
    (
      CachedMediaAsset,
      BaseReferences<_$AppDatabase, $CachedMediaAssetsTable, CachedMediaAsset>
    ),
    CachedMediaAsset,
    PrefetchHooks Function()> {
  $$CachedMediaAssetsTableTableManager(
      _$AppDatabase db, $CachedMediaAssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMediaAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMediaAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMediaAssetsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> storagePath = const Value.absent(),
            Value<String> mediaType = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<int?> sizeBytes = const Value.absent(),
            Value<String?> contentHash = const Value.absent(),
            Value<String> licenseStatus = const Value.absent(),
            Value<String> reviewStatus = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMediaAssetsCompanion(
            id: id,
            storagePath: storagePath,
            mediaType: mediaType,
            mimeType: mimeType,
            sizeBytes: sizeBytes,
            contentHash: contentHash,
            licenseStatus: licenseStatus,
            reviewStatus: reviewStatus,
            localPath: localPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String storagePath,
            required String mediaType,
            required String mimeType,
            Value<int?> sizeBytes = const Value.absent(),
            Value<String?> contentHash = const Value.absent(),
            required String licenseStatus,
            required String reviewStatus,
            Value<String?> localPath = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMediaAssetsCompanion.insert(
            id: id,
            storagePath: storagePath,
            mediaType: mediaType,
            mimeType: mimeType,
            sizeBytes: sizeBytes,
            contentHash: contentHash,
            licenseStatus: licenseStatus,
            reviewStatus: reviewStatus,
            localPath: localPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedMediaAssetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedMediaAssetsTable,
    CachedMediaAsset,
    $$CachedMediaAssetsTableFilterComposer,
    $$CachedMediaAssetsTableOrderingComposer,
    $$CachedMediaAssetsTableAnnotationComposer,
    $$CachedMediaAssetsTableCreateCompanionBuilder,
    $$CachedMediaAssetsTableUpdateCompanionBuilder,
    (
      CachedMediaAsset,
      BaseReferences<_$AppDatabase, $CachedMediaAssetsTable, CachedMediaAsset>
    ),
    CachedMediaAsset,
    PrefetchHooks Function()>;
typedef $$CachedMediaLocalizationsTableCreateCompanionBuilder
    = CachedMediaLocalizationsCompanion Function({
  required String mediaAssetId,
  required String locale,
  required String altText,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedMediaLocalizationsTableUpdateCompanionBuilder
    = CachedMediaLocalizationsCompanion Function({
  Value<String> mediaAssetId,
  Value<String> locale,
  Value<String> altText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedMediaLocalizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMediaLocalizationsTable> {
  $$CachedMediaLocalizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get altText => $composableBuilder(
      column: $table.altText, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedMediaLocalizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMediaLocalizationsTable> {
  $$CachedMediaLocalizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get altText => $composableBuilder(
      column: $table.altText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedMediaLocalizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMediaLocalizationsTable> {
  $$CachedMediaLocalizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get altText =>
      $composableBuilder(column: $table.altText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedMediaLocalizationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedMediaLocalizationsTable,
    CachedMediaLocalization,
    $$CachedMediaLocalizationsTableFilterComposer,
    $$CachedMediaLocalizationsTableOrderingComposer,
    $$CachedMediaLocalizationsTableAnnotationComposer,
    $$CachedMediaLocalizationsTableCreateCompanionBuilder,
    $$CachedMediaLocalizationsTableUpdateCompanionBuilder,
    (
      CachedMediaLocalization,
      BaseReferences<_$AppDatabase, $CachedMediaLocalizationsTable,
          CachedMediaLocalization>
    ),
    CachedMediaLocalization,
    PrefetchHooks Function()> {
  $$CachedMediaLocalizationsTableTableManager(
      _$AppDatabase db, $CachedMediaLocalizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMediaLocalizationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMediaLocalizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMediaLocalizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> mediaAssetId = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<String> altText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMediaLocalizationsCompanion(
            mediaAssetId: mediaAssetId,
            locale: locale,
            altText: altText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String mediaAssetId,
            required String locale,
            required String altText,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMediaLocalizationsCompanion.insert(
            mediaAssetId: mediaAssetId,
            locale: locale,
            altText: altText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedMediaLocalizationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedMediaLocalizationsTable,
        CachedMediaLocalization,
        $$CachedMediaLocalizationsTableFilterComposer,
        $$CachedMediaLocalizationsTableOrderingComposer,
        $$CachedMediaLocalizationsTableAnnotationComposer,
        $$CachedMediaLocalizationsTableCreateCompanionBuilder,
        $$CachedMediaLocalizationsTableUpdateCompanionBuilder,
        (
          CachedMediaLocalization,
          BaseReferences<_$AppDatabase, $CachedMediaLocalizationsTable,
              CachedMediaLocalization>
        ),
        CachedMediaLocalization,
        PrefetchHooks Function()>;
typedef $$CachedScenariosTableCreateCompanionBuilder = CachedScenariosCompanion
    Function({
  required String id,
  required String slug,
  required String categoryId,
  Value<String?> coverMediaId,
  required int estimatedMinutes,
  required String status,
  Value<int> version,
  Value<DateTime?> publishedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedScenariosTableUpdateCompanionBuilder = CachedScenariosCompanion
    Function({
  Value<String> id,
  Value<String> slug,
  Value<String> categoryId,
  Value<String?> coverMediaId,
  Value<int> estimatedMinutes,
  Value<String> status,
  Value<int> version,
  Value<DateTime?> publishedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedScenariosTableFilterComposer
    extends Composer<_$AppDatabase, $CachedScenariosTable> {
  $$CachedScenariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverMediaId => $composableBuilder(
      column: $table.coverMediaId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedScenariosTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedScenariosTable> {
  $$CachedScenariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverMediaId => $composableBuilder(
      column: $table.coverMediaId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedScenariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedScenariosTable> {
  $$CachedScenariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get coverMediaId => $composableBuilder(
      column: $table.coverMediaId, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedScenariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedScenariosTable,
    CachedScenario,
    $$CachedScenariosTableFilterComposer,
    $$CachedScenariosTableOrderingComposer,
    $$CachedScenariosTableAnnotationComposer,
    $$CachedScenariosTableCreateCompanionBuilder,
    $$CachedScenariosTableUpdateCompanionBuilder,
    (
      CachedScenario,
      BaseReferences<_$AppDatabase, $CachedScenariosTable, CachedScenario>
    ),
    CachedScenario,
    PrefetchHooks Function()> {
  $$CachedScenariosTableTableManager(
      _$AppDatabase db, $CachedScenariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedScenariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedScenariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedScenariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String?> coverMediaId = const Value.absent(),
            Value<int> estimatedMinutes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<DateTime?> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenariosCompanion(
            id: id,
            slug: slug,
            categoryId: categoryId,
            coverMediaId: coverMediaId,
            estimatedMinutes: estimatedMinutes,
            status: status,
            version: version,
            publishedAt: publishedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String slug,
            required String categoryId,
            Value<String?> coverMediaId = const Value.absent(),
            required int estimatedMinutes,
            required String status,
            Value<int> version = const Value.absent(),
            Value<DateTime?> publishedAt = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenariosCompanion.insert(
            id: id,
            slug: slug,
            categoryId: categoryId,
            coverMediaId: coverMediaId,
            estimatedMinutes: estimatedMinutes,
            status: status,
            version: version,
            publishedAt: publishedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedScenariosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedScenariosTable,
    CachedScenario,
    $$CachedScenariosTableFilterComposer,
    $$CachedScenariosTableOrderingComposer,
    $$CachedScenariosTableAnnotationComposer,
    $$CachedScenariosTableCreateCompanionBuilder,
    $$CachedScenariosTableUpdateCompanionBuilder,
    (
      CachedScenario,
      BaseReferences<_$AppDatabase, $CachedScenariosTable, CachedScenario>
    ),
    CachedScenario,
    PrefetchHooks Function()>;
typedef $$CachedScenarioLocalizationsTableCreateCompanionBuilder
    = CachedScenarioLocalizationsCompanion Function({
  required String scenarioId,
  required String locale,
  required String title,
  required String summary,
  required String intro,
  required String closingSummary,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedScenarioLocalizationsTableUpdateCompanionBuilder
    = CachedScenarioLocalizationsCompanion Function({
  Value<String> scenarioId,
  Value<String> locale,
  Value<String> title,
  Value<String> summary,
  Value<String> intro,
  Value<String> closingSummary,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedScenarioLocalizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedScenarioLocalizationsTable> {
  $$CachedScenarioLocalizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get intro => $composableBuilder(
      column: $table.intro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get closingSummary => $composableBuilder(
      column: $table.closingSummary,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedScenarioLocalizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedScenarioLocalizationsTable> {
  $$CachedScenarioLocalizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get intro => $composableBuilder(
      column: $table.intro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get closingSummary => $composableBuilder(
      column: $table.closingSummary,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedScenarioLocalizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedScenarioLocalizationsTable> {
  $$CachedScenarioLocalizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get intro =>
      $composableBuilder(column: $table.intro, builder: (column) => column);

  GeneratedColumn<String> get closingSummary => $composableBuilder(
      column: $table.closingSummary, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedScenarioLocalizationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedScenarioLocalizationsTable,
    CachedScenarioLocalization,
    $$CachedScenarioLocalizationsTableFilterComposer,
    $$CachedScenarioLocalizationsTableOrderingComposer,
    $$CachedScenarioLocalizationsTableAnnotationComposer,
    $$CachedScenarioLocalizationsTableCreateCompanionBuilder,
    $$CachedScenarioLocalizationsTableUpdateCompanionBuilder,
    (
      CachedScenarioLocalization,
      BaseReferences<_$AppDatabase, $CachedScenarioLocalizationsTable,
          CachedScenarioLocalization>
    ),
    CachedScenarioLocalization,
    PrefetchHooks Function()> {
  $$CachedScenarioLocalizationsTableTableManager(
      _$AppDatabase db, $CachedScenarioLocalizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedScenarioLocalizationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedScenarioLocalizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedScenarioLocalizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> scenarioId = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> intro = const Value.absent(),
            Value<String> closingSummary = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioLocalizationsCompanion(
            scenarioId: scenarioId,
            locale: locale,
            title: title,
            summary: summary,
            intro: intro,
            closingSummary: closingSummary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String scenarioId,
            required String locale,
            required String title,
            required String summary,
            required String intro,
            required String closingSummary,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioLocalizationsCompanion.insert(
            scenarioId: scenarioId,
            locale: locale,
            title: title,
            summary: summary,
            intro: intro,
            closingSummary: closingSummary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedScenarioLocalizationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedScenarioLocalizationsTable,
        CachedScenarioLocalization,
        $$CachedScenarioLocalizationsTableFilterComposer,
        $$CachedScenarioLocalizationsTableOrderingComposer,
        $$CachedScenarioLocalizationsTableAnnotationComposer,
        $$CachedScenarioLocalizationsTableCreateCompanionBuilder,
        $$CachedScenarioLocalizationsTableUpdateCompanionBuilder,
        (
          CachedScenarioLocalization,
          BaseReferences<_$AppDatabase, $CachedScenarioLocalizationsTable,
              CachedScenarioLocalization>
        ),
        CachedScenarioLocalization,
        PrefetchHooks Function()>;
typedef $$CachedScenarioStepsTableCreateCompanionBuilder
    = CachedScenarioStepsCompanion Function({
  required String id,
  required String scenarioId,
  required String stepKey,
  required String kind,
  required int orderIndex,
  Value<String?> mediaAssetId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedScenarioStepsTableUpdateCompanionBuilder
    = CachedScenarioStepsCompanion Function({
  Value<String> id,
  Value<String> scenarioId,
  Value<String> stepKey,
  Value<String> kind,
  Value<int> orderIndex,
  Value<String?> mediaAssetId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedScenarioStepsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedScenarioStepsTable> {
  $$CachedScenarioStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepKey => $composableBuilder(
      column: $table.stepKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedScenarioStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedScenarioStepsTable> {
  $$CachedScenarioStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepKey => $composableBuilder(
      column: $table.stepKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedScenarioStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedScenarioStepsTable> {
  $$CachedScenarioStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => column);

  GeneratedColumn<String> get stepKey =>
      $composableBuilder(column: $table.stepKey, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<String> get mediaAssetId => $composableBuilder(
      column: $table.mediaAssetId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedScenarioStepsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedScenarioStepsTable,
    CachedScenarioStep,
    $$CachedScenarioStepsTableFilterComposer,
    $$CachedScenarioStepsTableOrderingComposer,
    $$CachedScenarioStepsTableAnnotationComposer,
    $$CachedScenarioStepsTableCreateCompanionBuilder,
    $$CachedScenarioStepsTableUpdateCompanionBuilder,
    (
      CachedScenarioStep,
      BaseReferences<_$AppDatabase, $CachedScenarioStepsTable,
          CachedScenarioStep>
    ),
    CachedScenarioStep,
    PrefetchHooks Function()> {
  $$CachedScenarioStepsTableTableManager(
      _$AppDatabase db, $CachedScenarioStepsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedScenarioStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedScenarioStepsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedScenarioStepsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> scenarioId = const Value.absent(),
            Value<String> stepKey = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<String?> mediaAssetId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioStepsCompanion(
            id: id,
            scenarioId: scenarioId,
            stepKey: stepKey,
            kind: kind,
            orderIndex: orderIndex,
            mediaAssetId: mediaAssetId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String scenarioId,
            required String stepKey,
            required String kind,
            required int orderIndex,
            Value<String?> mediaAssetId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedScenarioStepsCompanion.insert(
            id: id,
            scenarioId: scenarioId,
            stepKey: stepKey,
            kind: kind,
            orderIndex: orderIndex,
            mediaAssetId: mediaAssetId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedScenarioStepsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedScenarioStepsTable,
    CachedScenarioStep,
    $$CachedScenarioStepsTableFilterComposer,
    $$CachedScenarioStepsTableOrderingComposer,
    $$CachedScenarioStepsTableAnnotationComposer,
    $$CachedScenarioStepsTableCreateCompanionBuilder,
    $$CachedScenarioStepsTableUpdateCompanionBuilder,
    (
      CachedScenarioStep,
      BaseReferences<_$AppDatabase, $CachedScenarioStepsTable,
          CachedScenarioStep>
    ),
    CachedScenarioStep,
    PrefetchHooks Function()>;
typedef $$CachedStepLocalizationsTableCreateCompanionBuilder
    = CachedStepLocalizationsCompanion Function({
  required String stepId,
  required String locale,
  required String bodyText,
  Value<String?> narrationMediaId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedStepLocalizationsTableUpdateCompanionBuilder
    = CachedStepLocalizationsCompanion Function({
  Value<String> stepId,
  Value<String> locale,
  Value<String> bodyText,
  Value<String?> narrationMediaId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedStepLocalizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedStepLocalizationsTable> {
  $$CachedStepLocalizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get stepId => $composableBuilder(
      column: $table.stepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodyText => $composableBuilder(
      column: $table.bodyText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get narrationMediaId => $composableBuilder(
      column: $table.narrationMediaId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedStepLocalizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedStepLocalizationsTable> {
  $$CachedStepLocalizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get stepId => $composableBuilder(
      column: $table.stepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodyText => $composableBuilder(
      column: $table.bodyText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get narrationMediaId => $composableBuilder(
      column: $table.narrationMediaId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedStepLocalizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedStepLocalizationsTable> {
  $$CachedStepLocalizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => column);

  GeneratedColumn<String> get narrationMediaId => $composableBuilder(
      column: $table.narrationMediaId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedStepLocalizationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedStepLocalizationsTable,
    CachedStepLocalization,
    $$CachedStepLocalizationsTableFilterComposer,
    $$CachedStepLocalizationsTableOrderingComposer,
    $$CachedStepLocalizationsTableAnnotationComposer,
    $$CachedStepLocalizationsTableCreateCompanionBuilder,
    $$CachedStepLocalizationsTableUpdateCompanionBuilder,
    (
      CachedStepLocalization,
      BaseReferences<_$AppDatabase, $CachedStepLocalizationsTable,
          CachedStepLocalization>
    ),
    CachedStepLocalization,
    PrefetchHooks Function()> {
  $$CachedStepLocalizationsTableTableManager(
      _$AppDatabase db, $CachedStepLocalizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedStepLocalizationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedStepLocalizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedStepLocalizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> stepId = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<String> bodyText = const Value.absent(),
            Value<String?> narrationMediaId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedStepLocalizationsCompanion(
            stepId: stepId,
            locale: locale,
            bodyText: bodyText,
            narrationMediaId: narrationMediaId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String stepId,
            required String locale,
            required String bodyText,
            Value<String?> narrationMediaId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedStepLocalizationsCompanion.insert(
            stepId: stepId,
            locale: locale,
            bodyText: bodyText,
            narrationMediaId: narrationMediaId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedStepLocalizationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedStepLocalizationsTable,
        CachedStepLocalization,
        $$CachedStepLocalizationsTableFilterComposer,
        $$CachedStepLocalizationsTableOrderingComposer,
        $$CachedStepLocalizationsTableAnnotationComposer,
        $$CachedStepLocalizationsTableCreateCompanionBuilder,
        $$CachedStepLocalizationsTableUpdateCompanionBuilder,
        (
          CachedStepLocalization,
          BaseReferences<_$AppDatabase, $CachedStepLocalizationsTable,
              CachedStepLocalization>
        ),
        CachedStepLocalization,
        PrefetchHooks Function()>;
typedef $$CachedAnswerOptionsTableCreateCompanionBuilder
    = CachedAnswerOptionsCompanion Function({
  required String id,
  required String stepId,
  required String optionKey,
  required int orderIndex,
  Value<int> scoreValue,
  required String safetyCategory,
  Value<String?> nextStepId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedAnswerOptionsTableUpdateCompanionBuilder
    = CachedAnswerOptionsCompanion Function({
  Value<String> id,
  Value<String> stepId,
  Value<String> optionKey,
  Value<int> orderIndex,
  Value<int> scoreValue,
  Value<String> safetyCategory,
  Value<String?> nextStepId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedAnswerOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedAnswerOptionsTable> {
  $$CachedAnswerOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepId => $composableBuilder(
      column: $table.stepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionKey => $composableBuilder(
      column: $table.optionKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scoreValue => $composableBuilder(
      column: $table.scoreValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safetyCategory => $composableBuilder(
      column: $table.safetyCategory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextStepId => $composableBuilder(
      column: $table.nextStepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedAnswerOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedAnswerOptionsTable> {
  $$CachedAnswerOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepId => $composableBuilder(
      column: $table.stepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionKey => $composableBuilder(
      column: $table.optionKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scoreValue => $composableBuilder(
      column: $table.scoreValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safetyCategory => $composableBuilder(
      column: $table.safetyCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextStepId => $composableBuilder(
      column: $table.nextStepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedAnswerOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedAnswerOptionsTable> {
  $$CachedAnswerOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<String> get optionKey =>
      $composableBuilder(column: $table.optionKey, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<int> get scoreValue => $composableBuilder(
      column: $table.scoreValue, builder: (column) => column);

  GeneratedColumn<String> get safetyCategory => $composableBuilder(
      column: $table.safetyCategory, builder: (column) => column);

  GeneratedColumn<String> get nextStepId => $composableBuilder(
      column: $table.nextStepId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedAnswerOptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedAnswerOptionsTable,
    CachedAnswerOption,
    $$CachedAnswerOptionsTableFilterComposer,
    $$CachedAnswerOptionsTableOrderingComposer,
    $$CachedAnswerOptionsTableAnnotationComposer,
    $$CachedAnswerOptionsTableCreateCompanionBuilder,
    $$CachedAnswerOptionsTableUpdateCompanionBuilder,
    (
      CachedAnswerOption,
      BaseReferences<_$AppDatabase, $CachedAnswerOptionsTable,
          CachedAnswerOption>
    ),
    CachedAnswerOption,
    PrefetchHooks Function()> {
  $$CachedAnswerOptionsTableTableManager(
      _$AppDatabase db, $CachedAnswerOptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAnswerOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedAnswerOptionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedAnswerOptionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> stepId = const Value.absent(),
            Value<String> optionKey = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> scoreValue = const Value.absent(),
            Value<String> safetyCategory = const Value.absent(),
            Value<String?> nextStepId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedAnswerOptionsCompanion(
            id: id,
            stepId: stepId,
            optionKey: optionKey,
            orderIndex: orderIndex,
            scoreValue: scoreValue,
            safetyCategory: safetyCategory,
            nextStepId: nextStepId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String stepId,
            required String optionKey,
            required int orderIndex,
            Value<int> scoreValue = const Value.absent(),
            required String safetyCategory,
            Value<String?> nextStepId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedAnswerOptionsCompanion.insert(
            id: id,
            stepId: stepId,
            optionKey: optionKey,
            orderIndex: orderIndex,
            scoreValue: scoreValue,
            safetyCategory: safetyCategory,
            nextStepId: nextStepId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedAnswerOptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedAnswerOptionsTable,
    CachedAnswerOption,
    $$CachedAnswerOptionsTableFilterComposer,
    $$CachedAnswerOptionsTableOrderingComposer,
    $$CachedAnswerOptionsTableAnnotationComposer,
    $$CachedAnswerOptionsTableCreateCompanionBuilder,
    $$CachedAnswerOptionsTableUpdateCompanionBuilder,
    (
      CachedAnswerOption,
      BaseReferences<_$AppDatabase, $CachedAnswerOptionsTable,
          CachedAnswerOption>
    ),
    CachedAnswerOption,
    PrefetchHooks Function()>;
typedef $$CachedAnswerLocalizationsTableCreateCompanionBuilder
    = CachedAnswerLocalizationsCompanion Function({
  required String optionId,
  required String locale,
  required String label,
  required String feedbackText,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedAnswerLocalizationsTableUpdateCompanionBuilder
    = CachedAnswerLocalizationsCompanion Function({
  Value<String> optionId,
  Value<String> locale,
  Value<String> label,
  Value<String> feedbackText,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedAnswerLocalizationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedAnswerLocalizationsTable> {
  $$CachedAnswerLocalizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get optionId => $composableBuilder(
      column: $table.optionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedbackText => $composableBuilder(
      column: $table.feedbackText, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedAnswerLocalizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedAnswerLocalizationsTable> {
  $$CachedAnswerLocalizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get optionId => $composableBuilder(
      column: $table.optionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedbackText => $composableBuilder(
      column: $table.feedbackText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedAnswerLocalizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedAnswerLocalizationsTable> {
  $$CachedAnswerLocalizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get optionId =>
      $composableBuilder(column: $table.optionId, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get feedbackText => $composableBuilder(
      column: $table.feedbackText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedAnswerLocalizationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedAnswerLocalizationsTable,
    CachedAnswerLocalization,
    $$CachedAnswerLocalizationsTableFilterComposer,
    $$CachedAnswerLocalizationsTableOrderingComposer,
    $$CachedAnswerLocalizationsTableAnnotationComposer,
    $$CachedAnswerLocalizationsTableCreateCompanionBuilder,
    $$CachedAnswerLocalizationsTableUpdateCompanionBuilder,
    (
      CachedAnswerLocalization,
      BaseReferences<_$AppDatabase, $CachedAnswerLocalizationsTable,
          CachedAnswerLocalization>
    ),
    CachedAnswerLocalization,
    PrefetchHooks Function()> {
  $$CachedAnswerLocalizationsTableTableManager(
      _$AppDatabase db, $CachedAnswerLocalizationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAnswerLocalizationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedAnswerLocalizationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedAnswerLocalizationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> optionId = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> feedbackText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedAnswerLocalizationsCompanion(
            optionId: optionId,
            locale: locale,
            label: label,
            feedbackText: feedbackText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String optionId,
            required String locale,
            required String label,
            required String feedbackText,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedAnswerLocalizationsCompanion.insert(
            optionId: optionId,
            locale: locale,
            label: label,
            feedbackText: feedbackText,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedAnswerLocalizationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CachedAnswerLocalizationsTable,
        CachedAnswerLocalization,
        $$CachedAnswerLocalizationsTableFilterComposer,
        $$CachedAnswerLocalizationsTableOrderingComposer,
        $$CachedAnswerLocalizationsTableAnnotationComposer,
        $$CachedAnswerLocalizationsTableCreateCompanionBuilder,
        $$CachedAnswerLocalizationsTableUpdateCompanionBuilder,
        (
          CachedAnswerLocalization,
          BaseReferences<_$AppDatabase, $CachedAnswerLocalizationsTable,
              CachedAnswerLocalization>
        ),
        CachedAnswerLocalization,
        PrefetchHooks Function()>;
typedef $$GuestAttemptsTableCreateCompanionBuilder = GuestAttemptsCompanion
    Function({
  required String attemptId,
  required String scenarioId,
  required int scenarioVersion,
  Value<String> answersJson,
  Value<int> scoreLocal,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$GuestAttemptsTableUpdateCompanionBuilder = GuestAttemptsCompanion
    Function({
  Value<String> attemptId,
  Value<String> scenarioId,
  Value<int> scenarioVersion,
  Value<String> answersJson,
  Value<int> scoreLocal,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$GuestAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $GuestAttemptsTable> {
  $$GuestAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get attemptId => $composableBuilder(
      column: $table.attemptId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scenarioVersion => $composableBuilder(
      column: $table.scenarioVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scoreLocal => $composableBuilder(
      column: $table.scoreLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$GuestAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $GuestAttemptsTable> {
  $$GuestAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get attemptId => $composableBuilder(
      column: $table.attemptId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scenarioVersion => $composableBuilder(
      column: $table.scenarioVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scoreLocal => $composableBuilder(
      column: $table.scoreLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$GuestAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuestAttemptsTable> {
  $$GuestAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get attemptId =>
      $composableBuilder(column: $table.attemptId, builder: (column) => column);

  GeneratedColumn<String> get scenarioId => $composableBuilder(
      column: $table.scenarioId, builder: (column) => column);

  GeneratedColumn<int> get scenarioVersion => $composableBuilder(
      column: $table.scenarioVersion, builder: (column) => column);

  GeneratedColumn<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => column);

  GeneratedColumn<int> get scoreLocal => $composableBuilder(
      column: $table.scoreLocal, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GuestAttemptsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GuestAttemptsTable,
    GuestAttempt,
    $$GuestAttemptsTableFilterComposer,
    $$GuestAttemptsTableOrderingComposer,
    $$GuestAttemptsTableAnnotationComposer,
    $$GuestAttemptsTableCreateCompanionBuilder,
    $$GuestAttemptsTableUpdateCompanionBuilder,
    (
      GuestAttempt,
      BaseReferences<_$AppDatabase, $GuestAttemptsTable, GuestAttempt>
    ),
    GuestAttempt,
    PrefetchHooks Function()> {
  $$GuestAttemptsTableTableManager(_$AppDatabase db, $GuestAttemptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuestAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuestAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuestAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> attemptId = const Value.absent(),
            Value<String> scenarioId = const Value.absent(),
            Value<int> scenarioVersion = const Value.absent(),
            Value<String> answersJson = const Value.absent(),
            Value<int> scoreLocal = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GuestAttemptsCompanion(
            attemptId: attemptId,
            scenarioId: scenarioId,
            scenarioVersion: scenarioVersion,
            answersJson: answersJson,
            scoreLocal: scoreLocal,
            completed: completed,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String attemptId,
            required String scenarioId,
            required int scenarioVersion,
            Value<String> answersJson = const Value.absent(),
            Value<int> scoreLocal = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              GuestAttemptsCompanion.insert(
            attemptId: attemptId,
            scenarioId: scenarioId,
            scenarioVersion: scenarioVersion,
            answersJson: answersJson,
            scoreLocal: scoreLocal,
            completed: completed,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GuestAttemptsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GuestAttemptsTable,
    GuestAttempt,
    $$GuestAttemptsTableFilterComposer,
    $$GuestAttemptsTableOrderingComposer,
    $$GuestAttemptsTableAnnotationComposer,
    $$GuestAttemptsTableCreateCompanionBuilder,
    $$GuestAttemptsTableUpdateCompanionBuilder,
    (
      GuestAttempt,
      BaseReferences<_$AppDatabase, $GuestAttemptsTable, GuestAttempt>
    ),
    GuestAttempt,
    PrefetchHooks Function()>;
typedef $$AppPreferencesTableCreateCompanionBuilder = AppPreferencesCompanion
    Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AppPreferencesTableUpdateCompanionBuilder = AppPreferencesCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppPreferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppPreferencesTable,
    AppPreference,
    $$AppPreferencesTableFilterComposer,
    $$AppPreferencesTableOrderingComposer,
    $$AppPreferencesTableAnnotationComposer,
    $$AppPreferencesTableCreateCompanionBuilder,
    $$AppPreferencesTableUpdateCompanionBuilder,
    (
      AppPreference,
      BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>
    ),
    AppPreference,
    PrefetchHooks Function()> {
  $$AppPreferencesTableTableManager(
      _$AppDatabase db, $AppPreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPreferencesCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPreferencesCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppPreferencesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppPreferencesTable,
    AppPreference,
    $$AppPreferencesTableFilterComposer,
    $$AppPreferencesTableOrderingComposer,
    $$AppPreferencesTableAnnotationComposer,
    $$AppPreferencesTableCreateCompanionBuilder,
    $$AppPreferencesTableUpdateCompanionBuilder,
    (
      AppPreference,
      BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>
    ),
    AppPreference,
    PrefetchHooks Function()>;
typedef $$SyncMetadataTableCreateCompanionBuilder = SyncMetadataCompanion
    Function({
  required String key,
  required String value,
  required DateTime lastSyncedAt,
  Value<int> rowid,
});
typedef $$SyncMetadataTableUpdateCompanionBuilder = SyncMetadataCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> lastSyncedAt,
  Value<int> rowid,
});

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);
}

class $$SyncMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()> {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> lastSyncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion(
            key: key,
            value: value,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime lastSyncedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion.insert(
            key: key,
            value: value,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetadataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedScenarioCategoriesTableTableManager get cachedScenarioCategories =>
      $$CachedScenarioCategoriesTableTableManager(
          _db, _db.cachedScenarioCategories);
  $$CachedScenarioCategoryLocalizationsTableTableManager
      get cachedScenarioCategoryLocalizations =>
          $$CachedScenarioCategoryLocalizationsTableTableManager(
              _db, _db.cachedScenarioCategoryLocalizations);
  $$CachedMediaAssetsTableTableManager get cachedMediaAssets =>
      $$CachedMediaAssetsTableTableManager(_db, _db.cachedMediaAssets);
  $$CachedMediaLocalizationsTableTableManager get cachedMediaLocalizations =>
      $$CachedMediaLocalizationsTableTableManager(
          _db, _db.cachedMediaLocalizations);
  $$CachedScenariosTableTableManager get cachedScenarios =>
      $$CachedScenariosTableTableManager(_db, _db.cachedScenarios);
  $$CachedScenarioLocalizationsTableTableManager
      get cachedScenarioLocalizations =>
          $$CachedScenarioLocalizationsTableTableManager(
              _db, _db.cachedScenarioLocalizations);
  $$CachedScenarioStepsTableTableManager get cachedScenarioSteps =>
      $$CachedScenarioStepsTableTableManager(_db, _db.cachedScenarioSteps);
  $$CachedStepLocalizationsTableTableManager get cachedStepLocalizations =>
      $$CachedStepLocalizationsTableTableManager(
          _db, _db.cachedStepLocalizations);
  $$CachedAnswerOptionsTableTableManager get cachedAnswerOptions =>
      $$CachedAnswerOptionsTableTableManager(_db, _db.cachedAnswerOptions);
  $$CachedAnswerLocalizationsTableTableManager get cachedAnswerLocalizations =>
      $$CachedAnswerLocalizationsTableTableManager(
          _db, _db.cachedAnswerLocalizations);
  $$GuestAttemptsTableTableManager get guestAttempts =>
      $$GuestAttemptsTableTableManager(_db, _db.guestAttempts);
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
