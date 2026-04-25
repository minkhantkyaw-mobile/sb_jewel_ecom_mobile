// class CategoryModel {
//   final bool? status;
//   final String? message;
//   final List<CategoryData>? data;

//   CategoryModel({this.status, this.message, this.data});

//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       status: json['status'] as bool?,
//       message: json['message'] as String?,
//       data:
//           json['data'] != null
//               ? (json['data'] as List)
//                   .map((e) => CategoryData.fromJson(e))
//                   .toList()
//               : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       if (data != null) 'data': data!.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class CategoryData {
//   final int? id;
//   final String? name;
//   final String? image;
//   final String? createdAt;
//   final String? updatedAt;

//   CategoryData({
//     this.id,
//     this.name,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory CategoryData.fromJson(Map<String, dynamic> json) {
//     return CategoryData(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       image: json['image'] as String?,
//       createdAt: json['created_at'] as String?,
//       updatedAt: json['updated_at'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }

// class SubCategoryData {
//   final int? id;
//   final String? name;
//   final int? categoryId;
//   final String? categoryName;

//   SubCategoryData({this.id, this.name, this.categoryId, this.categoryName});

//   factory SubCategoryData.fromJson(Map<String, dynamic> json) {
//     return SubCategoryData(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       categoryId: json['category_id'] as int?,
//       categoryName: json['category_name'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category_id': categoryId,
//       'category_name': categoryName,
//     };
//   }
// }

// class SubProductModel {
//   final int? id;
//   final String? name;
//   final String? image;
//   final double? price;
//   final int? subCategoryId;

//   SubProductModel({
//     this.id,
//     this.name,
//     this.image,
//     this.price,
//     this.subCategoryId,
//   });

//   factory SubProductModel.fromJson(Map<String, dynamic> json) {
//     return SubProductModel(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       price:
//           (json['price'] != null)
//               ? double.tryParse(json['price'].toString())
//               : null,
//       subCategoryId: json['sub_category_id'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'image': image,
//     'price': price,
//     'sub_category_id': subCategoryId,
//   };
// }

// category_model.dart

class CategoryModel {
  final bool? status;
  final String? message;
  final List<CategoryData>? data;

  CategoryModel({this.status, this.message, this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => CategoryData.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryData {
  final int? id;
  final String? name;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  CategoryData({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class SubCategoryData {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? categoryName;

  SubCategoryData({this.id, this.name, this.categoryId, this.categoryName});

  factory SubCategoryData.fromJson(Map<String, dynamic> json) {
    return SubCategoryData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      categoryId: json['category_id'] as int?,
      categoryName: json['category_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}

class SubProductModel {
  final int? id;
  final String? name;
  final String? image;
  final double? price;
  final int? subCategoryId;

  SubProductModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.subCategoryId,
  });

  factory SubProductModel.fromJson(Map<String, dynamic> json) {
    return SubProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price:
          json['price'] != null
              ? double.tryParse(json['price'].toString())
              : null,
      subCategoryId: json['sub_category_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'sub_category_id': subCategoryId,
    };
  }
}

class SubBrandModel {
  final bool? success;
  final List<SubBrandData>? message;
  final String? data;

  SubBrandModel({this.success, this.message, this.data});

  factory SubBrandModel.fromJson(Map<String, dynamic> json) {
    return SubBrandModel(
      success: json['success'] as bool?,
      message:
          (json['message'] as List<dynamic>?)
              ?.map((e) => SubBrandData.fromJson(e))
              .toList(),
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message?.map((e) => e.toJson()).toList(),
      'data': data,
    };
  }
}

class SubBrandData {
  final int? id;
  final String? name;
  final String? brand;
  final int? brandId;
  final String? createdAt;
  final String? updatedAt;

  SubBrandData({
    this.id,
    this.name,
    this.brand,
    this.brandId,
    this.createdAt,
    this.updatedAt,
  });

  factory SubBrandData.fromJson(Map<String, dynamic> json) {
    return SubBrandData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      brandId: json['brand_id'] as int?, // ✅ ensure this key is present
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'brand_id': brandId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class BrandProductData {
  final int? id;
  final String? name;
  final String? image;
  final double? price;
  final int? subBrandId;

  BrandProductData({
    this.id,
    this.name,
    this.image,
    this.price,
    this.subBrandId,
  });

  factory BrandProductData.fromJson(Map<String, dynamic> json) {
    return BrandProductData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price:
          json['price'] != null
              ? double.tryParse(json['price'].toString())
              : null,
      subBrandId: json['sub_brand_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'sub_brand_id': subBrandId,
  };
}
