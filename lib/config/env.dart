class Env {
  final String? secret;
  Env(this.secret);
}

class EnvValue {
  static final Env development = Env('development secret');
  static final Env staging = Env('staging secret');
  static final Env production = Env('production secret');
}
