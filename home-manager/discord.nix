{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
        withTTS = false;
      })
      discord-krisp-patch
    ];
  };
}