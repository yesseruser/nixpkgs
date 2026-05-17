{
  lib,
  fetchFromGitHub,
  rustPlatform,
  cacert,
  makeWrapper
}:

rustPlatform.buildRustPackage (finalAttrs: rec {
  pname = "yesser-todo-server";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "yesser-studios";
    repo = "yesser-todo-cli";
    tag = "yesser-todo-server-v${finalAttrs.version}";
    hash = "sha256-8p/ma+XB2Jqva9NEMZYF8cuYSrEb7sa0bPAcJrNk+14=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ cacert ];

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  cargoBuildFlags = [ "--package" "yesser-todo-server" ];
  cargoTestFlags = [ "--package" "yesser-todo-server" "--" "--test-threads=1" ];

  postFixup = ''
    wrapProgram $out/bin/yesser-todo-server \
      --set-default SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  meta = {
    description = "Server for yesser-todo-cli";
    homepage = "https://github.com/yesser-studios/yesser-todo-cli";
    changelog = "https://github.com/yesser-studios/yesser-todo-cli/releases/tag/yesser-todo-server-v${finalAttrs.version}";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [
      yesseruser
    ];
    mainProgram = "yesser-todo-server";
  };
})
