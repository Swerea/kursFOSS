% Kursmiljön med lite användarstöd
% N. Stenberg
% 11 april 2018


# En usb-sticka

- Xubuntu 16.04
- Med programvara
	- LibreCAD
	- Salome-Meca
	- CalculiX


# Xubuntu är en GNU/Linux distro

En distro är en massa program samlade under en flagg

Programmen paketerade i paket  (>40000 paket)

Ett paket talar om vilka andra paket som måste finns.

- .deb  (Debian)
- .rpm  (Red Hat)
- .tgz  (Slackware)

## Xubuntu baseras på

- Ubuntu
	- Som i sin tur baseras på Debian
	- har .deb-paket


# Xubuntu är en GNU/Linux distro


- Alla program i en distro-version fungerar ihop
- Samma program finns i olika distro. 
	- Går att flytta om samma versioner av beroende-paketen finns.


# Xubuntu är en GNU/Linux distro

## Utseende

- XFCE
- Finns också
	- Gnome
	- KDE
	- Cinnamon
	- många fler \ldots


# Så: GNU/Linux crash course

markera - mellanknappen

scrolla i ickeaktivt fönster

Är $USER som standard

>>  sudo


prova:

Öppna terminal:

```bash
$> whoami
$> sudo whoami
```

# Så: GNU/Linux crash course

Andra bra terminalkommandon:

\bco
\co

- ls
- cd
- rm
- cp / mv
- mkdir
- locate
- man

\co

- tail
- head
- grep
- cat
- less
- screen

\eco


# Så: GNU/Linux crash course

- `|`   ("pipe")

## exempel

```bash
$> cd
$> locate bashrc
$> locate bashrc|grep home
<markera filen som skall tittas på med dubbelklick>
$> cat <mellanklick> 
```

# Så: GNU/Linux crash course

TAB är bra 

```bash
$> ls
$> cd Do<TAB>  ev. <TAB>
```

# Lägga till program  :  git

Meny -- Software

- här finns inte allt med. Bara det vanligaste

## Installera synaptic

```bash
$> sudo apt install synaptic
```

Meny -- System -- synaptic

eller:

```bash
$> sudo apt install git
```

# Hämta dokumentationen

Öppna browsern

github.com/swerea
<klick> kursFOSS

i terminalen

```bash
$> cd
$> cd Desktop
$> git clone https://github.com/Swerea/kursFOSS.git
```



# Miljön:

- Salome Meca
- CalculiX
- FreeCAD
