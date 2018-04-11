#--- How to execute script ---
#1. open terminal in the directory, where this script is located
#2. execute installation script with: sudo bash CalculiX_install.sh


#--- Information ---
#script downloads libspooles-dev, libarpack++2-dev and netgen via apt-get
#will write the file CalculiX_uninstall.sh into this folder
#to uninstall type: sudo bash CalculiX_uninstall.sh


#--- Usage CGX - Pre- and Postprocessor ---
#open cgx to create a simulation: cgx -b FILE.fbd
#open output file from solver: cgx FILE.frd
#open inputfile to control simulation: cgx -c INPUTFILE.inp


#--- Usage CCX - Solver ---
#execute the solver: ccx -i INPUTFILE
#to use 2 CPU for solving, type in terminal: export OMP_NUM_THREADS=2




#variable, change for further versions
version="2.13"

#sudo-check
if [ $USER != "root" ];
then
echo "Error: execute as root! Type: sudo bash CalculiX_install.sh"
exit
fi

#downloads all required data from Guido Dhondt's website
wget http://dhondt.de/cgx_$version.bz2
wget http://dhondt.de/cgx_$version.htm.tar.bz2
wget http://dhondt.de/ccx_$version.src.tar.bz2
wget http://dhondt.de/ccx_$version.htm.tar.bz2
wget http://dhondt.de/ccx_$version.test.tar.bz2

#unzips downloaded data and removes unreqired data
bunzip2 -f cgx_$version.bz2
bunzip2 -f cgx_$version.htm.tar.bz2
bunzip2 -f ccx_$version.src.tar.bz2
bunzip2 -f ccx_$version.htm.tar.bz2
bunzip2 -f ccx_$version.test.tar.bz2
tar -xvf ccx_$version.test.tar
rm -rf cgx_$version.bz2
rm -rf cgx_$version.htm.tar.bz2
rm -rf ccx_$version.src.tar.bz2
rm -rf ccx_$version.htm.tar.bz2
rm -rf ccx_$version.test.tar.bz2
rm -rf ccx_$version.test.tar

#moves folder with test-files, deletes empty folder and gives default permissions to directory
cp -rp ./CalculiX/ccx_$version/test test_inputfiles
rm -rf CalculiX
chown -R $SUDO_USER:$SUDO_USER test_inputfiles

#reads text from from this script and creates so the makefile to compile ccx
LINE_START1=$(cat CalculiX_install.sh | awk '{if ($1 == "start1") print NR}')
LINE_END1=$(cat CalculiX_install.sh | awk '{if ($1 == "end1") print NR}')
LINE_START2=$(cat CalculiX_install.sh | awk '{if ($1 == "start2") print NR}')
LINE_END2=$(cat CalculiX_install.sh | awk '{if ($1 == "end2") print NR}')
rm -rf Makefile_MT-local
cat CalculiX_install.sh | awk '{if (NR > '"$LINE_START1"' && NR < '"$LINE_END1"') print $0}' >> Makefile_MT-local
echo "CCX_VER=${version}" >> Makefile_MT-local
cat CalculiX_install.sh | awk 'BEGIN{FS="#"}{if (NR > '"$LINE_START2"' && NR < '"$LINE_END2"') print $2}' >> Makefile_MT-local

#reads text from this script and creates so the ccx_cgx_uninstall.sh
LINE_START3=$(cat CalculiX_install.sh | awk '{if ($1 == "start3") print NR}')
LINE_END3=$(cat CalculiX_install.sh | awk '{if ($1 == "end3") print NR}')
echo "CCX_VER=${version}" >| CalculiX_uninstall.sh
cat CalculiX_install.sh | awk 'BEGIN{FS="#"}{if (NR > '"$LINE_START3"' && NR < '"$LINE_END3"') print $2}' >> CalculiX_uninstall.sh
chmod u=rwx CalculiX_uninstall.sh
chmod g=rx CalculiX_uninstall.sh
chmod o=rx CalculiX_uninstall.sh
chown -R $SUDO_USER:$SUDO_USER CalculiX_uninstall.sh

#moves cgx, ccx and the makefile into the correct folders
mv cgx_$version /usr/local/bin/cgx_$version
mv ccx_$version.htm.tar /usr/local/ccx_$version.htm.tar
mv ccx_$version.src.tar /usr/local/ccx_$version.src.tar
mv cgx_$version.htm.tar /usr/local/cgx_$version.htm.tar
mv Makefile_MT-local /usr/local/Makefile_MT-local

#navigates into folder /usr/local
cd /usr/local

#unzips the downloaded tar-files and deletes the unrequired files
tar -xvf ccx_$version.htm.tar
tar -xvf ccx_$version.src.tar
tar -xvf cgx_$version.htm.tar
rm -rf ccx_$version.htm.tar
rm -rf ccx_$version.src.tar
rm -rf cgx_$version.htm.tar

#moves the makefile to created directory
mv Makefile_MT-local /usr/local/CalculiX/ccx_$version/src/Makefile_MT-local

#downloads spooles, arpack and netgen
apt-get install libspooles-dev
apt-get install libarpack++2-dev
apt-get install netgen

#navigates to ccx-sourcecode-folder
cd /usr/local/CalculiX/ccx_$version/src

#compiles ccx
make -f Makefile_MT-local
make -f Makefile_MT-local install

#navigates to /usr/local/bin directory
cd /usr/local/bin

#makes cgx executable and renames the ccx- and cgx-executables for better user-experience
mv cgx_$version /usr/local/bin/cgx
chmod ao+rx /usr/local/bin/cgx
mv ccx_$version /usr/local/bin/ccx

#writes feedback to terminal
echo '------ installation done ------'














#text for the makefile - thanks for sharing

start1
# Makefile_MT-local
#
# Based on Debian source package (https://packages.debian.org/source/sid/calculix-ccx)
# Build depends: libspooles-dev libarpack2-dev
# Build with USE_MT=1
# Place this file in the Calculix src/ directory and run `make -f Makefile_MT-local` to build and `sudo make -f Makefile_MT-local install` to install
# EDITME - edit the next two lines if needed
end1

start2
#INSTALL_DIR=/usr/local/bin
#
#
#CFLAGS = -Wall -O3 -fopenmp -I/usr/include/spooles -DARCH="Linux" -DSPOOLES -DARPACK -DMATRIXSTORAGE -DUSE_MT=1
#FFLAGS = -Wall -O3 -fopenmp
#
#CC=cc
#FC=gfortran
#
#.c.o :
#	$(CC) $(CFLAGS) -c $<
#.f.o :
#	$(FC) $(FFLAGS) -c $<
#
#include Makefile.inc
#
#SCCXMAIN = ccx_$(CCX_VER).c
#
#OCCXF = $(SCCXF:.f=.o)
#OCCXC = $(SCCXC:.c=.o)
#OCCXMAIN = $(SCCXMAIN:.c=.o)
#
#LDFLAGS =  -lspooles -lpthread -larpack -llapack -lblas -lm -lc
#
#ccx_$(CCX_VER): $(OCCXMAIN) ccx_$(CCX_VER).a
#	$(CC) $(CFLAGS) -c ccx_$(CCX_VER).c; $(FC) $(FFLAGS) -o $@ $(OCCXMAIN) ccx_$(CCX_VER).a $(LDFLAGS)
#
#ccx_$(CCX_VER).a: $(OCCXF) $(OCCXC)
#	ar vr $@ $?
#
#install: ccx_$(CCX_VER)
#	mkdir -p $(INSTALL_DIR)
#	install -m755 ccx_$(CCX_VER) $(INSTALL_DIR)
#
#clean:
#	rm -f ccx_$(CCX_VER) *.a *.o
end2









#text for the file CalculiX_uninstall.sh

start3
#if [ $USER != "root" ];
#then
#echo "Error: execute as root! Type: sudo bash CalculiX_uninstall.sh"
#exit
#fi
#rm -rf test_inputfiles
#rm -rf /usr/local/CalculiX
#rm -rf /usr/local/bin/cgx
#rm -rf /usr/local/bin/ccx
#rm -rf /usr/local/ccx_$CCX_VER.htm.tar
#rm -rf /usr/local/ccx_$CCX_VER.src.tar
#rm -rf /usr/local/ccx_$CCX_VER.test.tar
#rm -rf /usr/local/cgx_$CCX_VER.htm.tar
#apt-get autoremove libspooles-dev
#apt-get autoremove libarpack++2-dev
#apt-get autoremove netgen
#echo 'uninstall done'
end3
