Martin Pitt's desktop
=====================

This is [bootc](https://docs.fedoraproject.org/en-US/bootc/) based minimal
[Fedora](https://getfedora.org/) developer desktop with the [sway window manager](https://swaywm.org/) and [podman](https://podman.io/)/[toolbox](https://docs.fedoraproject.org/en-US/fedora-silverblue/toolbox/) for doing development and running less common graphical applications.

It gets [automatically built](.github/workflows/build.yml) every week and [published as container image](https://github.com/martinpitt/workstation-bootc/pkgs/container/workstation-bootc/versions), for using with [ostree native containers](https://coreos.github.io/rpm-ostree/container/).

You can switch to it from an existing bootc based system like [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/):

```sh
sudo bootc switch ghcr.io/martinpitt/workstation-bootc:latest
```

After that, you can install weekly updates with

```
sudo bootc upgrade
```

If anything goes wrong, you can go back to the previous version with `sudo bootc rollback`.

Login
-----

There is no graphical login manager. I log in on VT1, and my `.bashrc`
automatically starts the GNOME SSH agent and sway:

```sh
if [ "$(tty)" = "/dev/tty1" ]; then
    export `gnome-keyring-daemon --start --components=ssh`
    export XDG_CURRENT_DESKTOP=sway
    exec sway > $XDG_RUNTIME_DIR/sway.log 2>&1
fi
```
