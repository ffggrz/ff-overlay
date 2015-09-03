Freifunk Gentoo Overlay
=======================

Das ist das Gentoo Portage Overlay für Freifunk-spezifische
Ebuilds.

Nutzung
-------

Die Installation erfolgt z.B. mittels:

```
 # emerge -av layman
 # cd /etc/layman/overlays
 # wget https://raw.githubusercontent.com/ffggrz/ff-overlay/master/ff-overlay.xml
 # layman -L
 # layman -a ff-overlay
```