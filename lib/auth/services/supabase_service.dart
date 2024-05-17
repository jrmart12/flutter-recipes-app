import 'package:supabase/supabase.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  final supabaseClient = SupabaseClient(
    'supabaseUrl',
    'supabaseKey',
  );
}