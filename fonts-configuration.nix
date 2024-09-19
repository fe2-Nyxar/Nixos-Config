{config, pkgs, ...}:
{
	fonts.packages = with pkgs; [
        poppins
		fira-code
		fira-code-symbols
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];
}
