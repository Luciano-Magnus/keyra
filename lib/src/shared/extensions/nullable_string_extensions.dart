extension NullableStringExtensions on String? {
  ///Retorna se é [null] ou vazio.
  bool get isNullOrWhiteSpace => (this ?? '').trim().isEmpty;
}
