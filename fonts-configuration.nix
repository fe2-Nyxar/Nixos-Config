{config, pkgs, ...}:
{
	fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];
}
