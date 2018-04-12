

# kommandon för att lägga in elmer freecad octave 

## Först "repositories" och sedan programmen

```bash
$> sudo add-apt-repository ppa:elmer-csc-ubuntu/elmer-csc-ppa
$> sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
$> sudo add-apt-repository ppa:neomilium/heekscnc-devel
$> sudo add-apt-repository ppa:octave/stable


$> sudo apt-get update
$> sudo apt install elmer freecad octave 

```

# Salome Meca

gå till:

[https://www.code-aster.org/spip.php?article303](https://www.code-aster.org/spip.php?article303)

1. ladda ner senaste versionen.

2. klicka på "Prerequisities"

3. Installera paketen:

- gcc, g++, gfortran (or other compilers),
- cmake,
- python,
- python-dev,
- python-numpy,
- python-qt4,
- tk,
- bison,
- flex,
- liblapack-dev, libblas-dev ou libopenblas-dev,
- zlib (named zlib1g-dev on debian/ubuntu).
	
 På ubuntu blir det då

```bash

$> sudo apt install gcc g++ gfortran cmake python python-dev \
   python-numpy python-qt4 tk bison flex liblapack-dev libblas-dev \
   libopenblas-dev zlib1g-dev

```

4. Och kör salome-meca filen för installation

