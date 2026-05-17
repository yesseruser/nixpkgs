{
  lib,
  fetchFromGitHub,
  rustPlatform,
  cacert,
  makeWrapper,
}:

rustPlatform.buildRustPackage (finalAttrs: rec {
  pname = "yesser-todo-cli";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "yesser-studios";
    repo = "yesser-todo-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WHSoHKrHE9BmyV9FTQCilC6EWbrRgdZYMBMXuN4idnI=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ cacert ];

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  postFixup = ''
    wrapProgram $out/bin/todo \
      --set-default SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  meta = {
    description = "CLI app for managing your tasks";
    homepage = "https://github.com/yesser-studios/yesser-todo-cli";
    changelog = "https://github.com/yesser-studios/yesser-todo-cli/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      yesseruser
    ];
    mainProgram = "todo";
  };
})
