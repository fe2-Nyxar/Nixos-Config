{ pkgs, ... }:
{
  #enable tmux  
  programs = {
    tmux.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        scan_timeout = 10;
        format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
        character = {
          success_symbol = "[](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
        git_branch = {
          symbol = " ";
          style = "#fc937b";
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };
        git_commit = {
          tag_symbol = "󰜝 ";
          style = "#edb46a";
          format = "[\($hash$tag\)]($style) ";
        };
        git_state = {
          style = "bold #f9ce31";
          format = "\([󱇯 $state( $progress_current/$progress_total)]($style)\) ";
        };
        git_status = {
          #style = "bold dimmed #fc5e46)";
          up_to_date = "✓(bold dimmed #82f2a4)";
          format = "([$all_status$ahead_behind](bold #edb46a) )";
        };
        lua = {
          format = "[ $version](bold blue) ";
        };
        golang = {
          format = "[󰟓 ($version )($mod_version )](bold dimmed #00ADD8)";
        };
        php = {
          format = "[ $version](147 bold) ";
        };
        nodejs = {
          format = "[ ($version )](bold green)";
        };
        directory = {
          truncation_length = 2;
          read_only = " 󰈈 ";
          read_only_style = "bold #eeef8b";
          style = "bold #a4caea";
          use_os_path_sep = true;
          format = "[$path]($style)[$read_only]($read_only_style)[\\]\\$](bold #f26fa1) ";
          before_repo_root_style = "bold #f2cf6f";
          repo_root_style = "bold #f2cf6f";
          repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($repo_root_style)[$read_only]($read_only_style)[\\]\\$](bold #f26fa1) ";
        };
        hostname = {
          ssh_only = false;
          style = "bold #8bc5ef";
          format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style) ";
          disabled = false;
        };
        username = {
          style_user = "bold #bba8ed";
          style_root = "bold red";
          show_always = true;
          format = "[\\[](bold #f26fa1)[$user]($style)[@](bold #f26fa1)";
        };
        nix_shell = {
          format = "[$state(($name))]($style) ";
          disabled = false;
          impure_msg = "[ ](bold red)";
          pure_msg = "[ ](bold green)";
          style = "bold blue";
        };
        /*
          nix_shell = {
            symbol = "󰒷";
            impure_msg = "󰒷 (bold orange)";
            pure_msg = "󰒷 (bold blue)";
            unknown_msg = "󰒷 (bold yellow)";
            format = "[$state(\($name\))]";
          };
        */
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # ----awesome CLI tools----
    wl-clipboard
    fastfetch
    starship
    lazygit
    jq
    fzf
    fd
    bat
    htop
    btop
    autojump # jump over sub directories
    # delta
    eza
    # --------------------------  
  ];
}
