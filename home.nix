# TODO
# Manual installed packages:
# x11-xserver-utils
# xserver-xephyr
# krew install oidc-login
# krew install get-all
# kubectl krew install get-all
# krew install oidc
{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "klst9498";
  home.homeDirectory = "/home/klst9498";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alacritty
    alejandra
    autojump
    cascadia-code
    cue
    clusterctl
    devbox
    devpod
    devspace
    feh
    zf
    fluxcd
    file
    firefox
    git
    git-crypt
    git-repo
    go
    gum
    gnupg
    gparted
    htop
    jq
    #k3d
    k9s
    kustomize
    kompose
    kubectl
    krew
    kubernetes-helm
    meslo-lg
    meld
    nerdfonts
    nushell
    pass
    #needed for docker login to get it working
    # call gpg --generate-key
    # pass init 123.....
    # check if this can be done via nix : sudo apt install libsecret-1-0
    # see https://stackoverflow.com/questions/50151833/cannot-login-to-docker-account
    # see: https://stackoverflow.com/questions/69808938/docker-credentials-store-on-wsl2-without-docker-desktop
    # -> export GPG_TTY=$(tty)
    python3
    ripgrep
    starship
    sops
    source-code-pro
    terminator
    tig
    timoni
    tmux
    tree
    velero
    wget
  ];

  fonts.fontconfig.enable = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/klst9498/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        set -gx PATH $PATH $HOME/.krew/bin
        set -gx FISH_HISTORY /mnt/d/work/SharedFishHistory/fish_history
      '';
      plugins = [
        {
          name = "foreign-env";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
          };
        }
      ];
      shellAbbrs = {
        hms = "home-manager switch";
      };
      shellAliases = {
        rbs = "~/.config/home-manager/rebuild.sh";
        # I know Thats a bad place but it's working :-)
        k = "kubectl";
        kaf = "kubectl apply -f";
        kccc = "kubectl config current-context";
        kcn = "kubectl config set-context --current --namespace";
        kcp = "kubectl cp";
        kcuc = "kubectl config use-context";
        kdel = "kubectl delete";
        kdelf = "kubectl delete -f";
        kd = "kubectl describe";
        kg = "kubectl get";
        kgpo = "kubectl get pod";
        kgpvc = "kubectl get pvc";
        kl = "kubectl logs";
        kl1h = "kubectl logs --since 1h";
        kl1m = "kubectl logs --since 1m";
        kl1s = "kubectl logs --since 1s";
        klf = "kubectl logs -f";
        klf1h = "kubectl logs --since 1h -f";
        klf1m = "kubectl logs --since 1m -f";
        klf1s = "kubectl logs --since 1s -f";
        kpf = "kubectl port-forward";
      };
    };

    starship = {
      enable = true;
      # todo
      # settings = {
      #   aws.disabled = false;
      #   gcloud.disabled = false;
      #   kubernetes.disabled = false;
      #   git_branch.style = "242";
      #   directory.style = "blue";
      #   directory.truncate_to_repo = false;
      #   directory.truncation_length = 8;
      #   python.disabled = false;
      #   ruby.disabled = true;
      #   hostname.ssh_only = false;
      #   hostname.style = "bold green";
      #   add_newline = true;
      #   format = ''
      #     [░▒▓](#a3aed2)
      #     [  ](bg:#a3aed2 fg:#090c0c)
      #     [](bg:#769ff0 fg:#a3aed2)
      #     $directory
      #     [](fg:#769ff0 bg:#394260)
      #     $git_branch
      #     $git_status
      #     [](fg:#394260 bg:#212736)
      #     $nodejs
      #     $rust
      #     $golang
      #     $php
      #     [](fg:#212736 bg:#1d2230)
      #     $time
      #     [ ](fg:#1d2230)
      #     \\n$character
      #   '';
      # };
    };

    fzf.enable = true;
    fzf.enableFishIntegration = true;

    git = {
      enable = true;
      userEmail = "klaus.Staudenmaier@elektrobit.com";
      userName = "Staudenmaier, Klaus";
      aliases = {
        gst = "status";
      };

      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };
  };
}
