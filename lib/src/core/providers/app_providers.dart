import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';
import '../services/notification_service.dart';
import '../services/nlp_service.dart';

// Service Providers
final firebaseServiceProvider = Provider((ref) => FirebaseService());

final notificationServiceProvider = Provider((ref) => NotificationService());

final nlpServiceProvider = Provider((ref) => NLPService());

// Auth State
final authStateProvider = StreamProvider((ref) {
  return ref.watch(firebaseServiceProvider).authStateChanges;
});

final currentUserProvider = StateProvider<String?>((ref) {
  return ref.watch(firebaseServiceProvider).currentUser?.uid;
});

// Theme State
final darkModeProvider = StateProvider<bool>((ref) => false);

// Loading State
final isLoadingProvider = StateProvider<bool>((ref) => false);
