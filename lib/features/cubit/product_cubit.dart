import 'package:e_commerce/features/cubit/product_state.dart';
import 'package:e_commerce/features/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio;

  ProductCubit(this.dio) : super(ProductInitial());

  Future<void> FetchProduct() async {
    emit(ProductLoading());

    try {
      final response = await dio.get("https://fakestoreapi.com/products");
      final List productsJson = response.data;
      final products =
          productsJson.map((e) => ProductModel.fromJson(e)).toList();

      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFail("Failed to load products"));
    }
  }

  fetchproducts() {}
}
