


![Release](https://img.shields.io/github/v/release/enexusde/Vereinsverwaltung)
![Downloads](https://img.shields.io/github/downloads/enexusde/Vereinsverwaltung/total)
![Last Commit](https://img.shields.io/github/last-commit/enexusde/Vereinsverwaltung)
![Issues](https://img.shields.io/github/issues/enexusde/Vereinsverwaltung)
![License](https://img.shields.io/github/license/enexusde/Vereinsverwaltung)
![Top Language](https://img.shields.io/github/languages/top/enexusde/Vereinsverwaltung)
![FreePascal](https://img.shields.io/badge/FreePascal-FPC-red)
![Lazarus](https://img.shields.io/badge/Lazarus-IDE-blue)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux-lightgrey)

# Vereinsverwaltung
Ein Lazarus-Projekt für die Verwaltung von Vereinen

# Windows

[▼ Vereinsverwaltung.exe (Windows-Download)](https://github.com/enexusde/Vereinsverwaltung/releases/latest/)

# Linux

Unter Windows wird libsodium als eingebettete DLL mitgeliefert. Unter Linux
wird stattdessen die vom System bereitgestellte libsodium zur Laufzeit
nachgeladen, daher wird folgendes Laufzeit-Paket benötigt:

```sh
# Debian/Ubuntu
sudo apt install libsodium23

# Fedora
sudo dnf install libsodium

# Arch
sudo pacman -S libsodium
```

## Selbst bauen

Voraussetzungen: Lazarus/FPC (Paket `lazarus`) sowie `libsodium23`.

```sh
lazbuild Vereinsverwaltung.lpi
./Vereinsverwaltung
```

# Beispiel Mitglied

![sdf](docu/mitglied-beispiel.png)

# Beispiel Barkasse

![sdf](docu/barkasse-beispiel.png)


# Beispiel Konto

![sdf](docu/bankkonto-beispiel.png)


# Beispiel Statistik

![sdf](docu/statistik-beispiel.png)

