Martin Pitt's desktop
=====================

This is an [rpm-ostree](https://coreos.github.io/rpm-ostree/) and
[bootc](https://docs.fedoraproject.org/en-US/bootc/) based minimal
[Fedora](https://getfedora.org/) developer desktop with the [sway window manager](https://swaywm.org/) and [podman](https://podman.io/)/[toolbox](https://docs.fedoraproject.org/en-US/fedora-silverblue/toolbox/) for doing development and running less common graphical applications.

It gets [automatically built](.github/workflows/build.yml) every week and [published as container image](https://github.com/martinpitt/ostree-bootc/pkgs/container/workstation-bootc), for using with [ostree native containers](https://coreos.github.io/rpm-ostree/container/).

To use it from an existing OSTree based system like [Fedora CoreOS](https://getfedora.org/coreos) or [Fedora Silverblue](https://docs.fedoraproject.org/en-US/fedora-silverblue/), rebase your tree to it:

```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/martinpitt/workstation-bootc
```

After that, you can install weekly updates with

```
sudo rpm-ostree upgrade
```

If anything goes wrong, you can go back to the previous version with `sudo rpm-ostree rollback`.

Login
-----

There is no graphical login manager. I log in on VT1, and my `.bashrc`
automatically starts the GNOME SSH agent and sway:

```sh
if [ "$(tty)" = "/dev/tty1" ]; then
    export `gnome-keyring-daemon --start --components=ssh`
    export BROWSER=firefox-wayland
    export XDG_CURRENT_DESKTOP=sway
    exec sway > $XDG_RUNTIME_DIR/sway.log 2>&1
fi
```
