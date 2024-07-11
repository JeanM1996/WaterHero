//Cloud Firestore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waterhero/core/data/network/http_client.dart';

class FirebaseRest {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<HttpServiceResponse> addData(
    String collection,
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await _firestore.collection(collection).add(data);
      return HttpServiceResponse(
        success: true,
        message: 'Data added',
        body: result.id,
      );
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> setData(
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(id).set(data);
      return HttpServiceResponse(success: true, message: 'Data setted');
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> updateData(
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
      return HttpServiceResponse(success: true, message: 'Data updated');
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> deleteData(String collection, String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
      return HttpServiceResponse(success: true, message: 'Data deleted');
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> getData(String collection, String id) async {
    try {
      final query = await _firestore.collection(collection).doc(id).get();
      return HttpServiceResponse(
        success: true,
        message: 'Data retrieved',
        body: (query.data() ?? {}).toString(),
      );
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> getCollection(String collection) async {
    try {
      final query = await _firestore.collection(collection).get();
      final data = query.docs.map((e) => e.data()).toList();
      return HttpServiceResponse(
        success: true,
        message: 'Data retrieved',
        body: data.toString(),
      );
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> getCollectionWhere(
    String collection,
    String field,
    dynamic value,
  ) async {
    try {
      final query = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();
      final data = query.docs.map((e) => e.data()).toList();
      return HttpServiceResponse(
        success: true,
        message: 'Data retrieved',
        body: data.toString(),
      );
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }
}
