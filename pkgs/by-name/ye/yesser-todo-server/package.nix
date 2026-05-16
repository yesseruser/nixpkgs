{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "yesser-todo-server";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "yesser-studios";
    repo = "yesser-todo-cli";
    tag = "yesser-todo-server-v${finalAttrs.version}";
    hash = "sha256-8p/ma+XB2Jqva9NEMZYF8cuYSrEb7sa0bPAcJrNk+14=";
  };

  cargoHash = "sha256-ikjda/f9/gebSDOmKTSdDveI0kHZmQoh3X8AEg9MR2g=";
  cargoBuildFlags = [ "--package" "yesser-todo-server" ];
  cargoTestFlags = [ "--package" "yesser-todo-server" "--" "--test-threads=1" ];

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
