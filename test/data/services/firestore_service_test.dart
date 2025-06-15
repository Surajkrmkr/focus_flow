import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:focus_flow/data/models/task_model.dart';
import 'package:focus_flow/data/services/firestore_service.dart';

import '../../mocks/firebase_mocks.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late MockCollectionReference<Map<String, dynamic>> mockTasksCollection;
  late MockDocumentReference<Map<String, dynamic>> mockTaskDoc;
  late FirestoreService firestoreService;

  const testUID = 'testUID';
  final testTask = TaskModel(
    id: 'task1',
    title: 'Test Task',
    description: 'Test description',
    isCompleted: false,
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUsersCollection = MockCollectionReference();
    mockUserDoc = MockDocumentReference();
    mockTasksCollection = MockCollectionReference();
    mockTaskDoc = MockDocumentReference();

    firestoreService = FirestoreService(firestore: mockFirestore);
  });

  group('FirestoreService', () {
    test('addTask calls Firestore with correct data', () async {
      when(mockFirestore.collection('users')).thenReturn(mockUsersCollection);
      when(mockUsersCollection.doc(testUID)).thenReturn(mockUserDoc);
      when(mockUserDoc.collection('tasks')).thenReturn(mockTasksCollection);
      when(mockTasksCollection.add(any)).thenAnswer((_) async => mockTaskDoc);

      await firestoreService.addTask(testUID, testTask);

      verify(mockTasksCollection.add(testTask.toMap())).called(1);
      if (kDebugMode) print('✅ addTask test executed successfully');
    });

    test('updateTask calls Firestore update with correct task data', () async {
      when(mockFirestore.collection('users')).thenReturn(mockUsersCollection);
      when(mockUsersCollection.doc(testUID)).thenReturn(mockUserDoc);
      when(mockUserDoc.collection('tasks')).thenReturn(mockTasksCollection);
      when(mockTasksCollection.doc(testTask.id)).thenReturn(mockTaskDoc);
      when(mockTaskDoc.update(any)).thenAnswer((_) async => Future.value());

      await firestoreService.updateTask(testUID, testTask);

      verify(mockTaskDoc.update(testTask.toMap())).called(1);
      if (kDebugMode) print('✅ updateTask test executed successfully');
    });

    test('deleteTask calls Firestore delete on correct document', () async {
      when(mockFirestore.collection('users')).thenReturn(mockUsersCollection);
      when(mockUsersCollection.doc(testUID)).thenReturn(mockUserDoc);
      when(mockUserDoc.collection('tasks')).thenReturn(mockTasksCollection);
      when(mockTasksCollection.doc(testTask.id)).thenReturn(mockTaskDoc);
      when(mockTaskDoc.delete()).thenAnswer((_) async => Future.value());

      await firestoreService.deleteTask(testUID, testTask.id);

      verify(mockTaskDoc.delete()).called(1);
      if (kDebugMode) print('✅ deleteTask test executed successfully');
    });
  });
}
