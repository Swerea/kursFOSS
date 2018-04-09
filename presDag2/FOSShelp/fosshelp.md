% FOSS och hur v�rlden finns d�r ute och delar med sig
% N. Stenberg
% 12 april 2018

# Denna timme

- FOSS utvecklingsmodell
- Hur f�r man tag p� hj�lp?
- Hur bidrar man?
- Var hittar man programvaran
- Services som finns



# FOSS utvecklingsmodell - f�ruts�ttningar

\bco
\co

- Antalet utvecklare varierar
- Inget kontor
- Inga fasta arbetstider
- Deltagare fr�n hela v�rlden

\co



\eco


# FOSS utvecklingsmodell - p�verkar framtiden

\bco
\co

- Antalet utvecklare varierar
- Inget kontor
- Inga fasta arbetstider
- Deltagare fr�n hela v�rlden

\co

Har p�verkat dagens f�retag

- \sg Detta har lett till en arbetsmetodik som �ven annan typ av
utveckling anv�nder\wi
- \sg Det har ocks� lett till att ledarfunktionen i organisationer �ndras\wi
- \sg i.e. Sj�lvstyrande organisationer\wi

\eco




# FOSS utvecklingsmodell  (varierar otroligt!!)

Generiskt f�r ett projekt:

- Alla kan delta
	- bara att anm�la sig
- Det finns regler
	- "Code of conduct"
- Executiv "ledning"
	- R�stas fram, eller de som h�ller i id�n
- M�nga f�retag har sina anst�llda att skriva FOSS kod.
- Har ofta buggrapportering fr�n anv�ndare (inbyggd)
- Gemensam versionshantering
- Mejllistor
- Chat: IRC hyfsat vanligt
- Allt �r �ppet


# FOSS utveckling

- Anv�nds i m�nga projekt f�r att det �r effektivt

F�r personer:

- Vill ni koda s� g�r det!!
- Ofta efters�ks dokumentat�rer


# Hj�lp med FOSS fr�gor

- S�kmotor: google, duckduckgo et dyl.
	- Ubuntu forum
	- Arch linux forum
- Online documentation
- Mejllistorna till det programmet
- Chatkanaler f�r programmet
- Browsa gamla poster
	- gamla svar, mejllistor
- Betala support


# Vi hj�lper varandra

![](bilder/help.jpg)


# En kommentar om FOSS

## F�retag best�mmer sig f�r licensiera deras program som FOSS f�r att:

- De tj�nar p� det
- eller f�rlorar inte s� mycket...
- De vill ha kontakt med "community"


# Vad �r FOSS community?

- **Personerna som hj�lper utvecklingen**
	- Programmerare
	- Dokumentat�rer

	*De f�rb�ttrar hela tiden*

- **Anv�ndare**
	- Bugg-rapport�rer
	- Feedback

	*De svarar p� anv�ndarfr�gor*


# Som exempel: Blender communities

![](bilder/blenderCom.png)

# Mer Blender : Utveckling

![](bilder/blenderInvolve.png)


# Ubuntu forum

![](bilder/ubuntuforum.png)


# F�r FOSS-ingenj�ren

## CalculiX:

\sg mejllista: \wi

[http://groups.yahoo.com/group/calculix](http://groups.yahoo.com/group/calculix) 

## Salome - Code Aster:

\sg Forum: \wi

[https://www.code-aster.org/forum2/](https://www.code-aster.org/forum2/)


# Var finns all FOSS?



# Var finns all FOSS?

## Om linux distro anv�nds:

- I "Repositories"
	- strukturerade databaser f�r distron

\sg eller i:\wi

- till�ggsrepositories
	- databaser som har samma struktur som den officiella


# Var finns all FOSS?

## St�rre projekt:

- P� respektive sida
	- B�de bin�rer och k�llkod
- Exempel
	- [Blender](https://www.blender.org/download/)
	- [GIMP](https://www.gimp.org/downloads/)
	- [Octave](https://www.gnu.org/software/octave/#install)


# Var finns all FOSS?

## Versionshanteringssiter

- github.com
- sourceforge.net
- savannah.gnu.org

ofta h�mta hem k�llkoden och kompilera

## Annars

- ostrukturerat:
	- s� s�k!

\red Ett tips\wi : l�gg till *GPL* n�r ni s�ker program f�r att hitta FOSS


# Services som finns d�r ute

Tj�nster som kan anv�ndas d�r FOSS f�r ber�kningsingenj�rer har en
stor del.

# Services som finns d�r ute

## Services som h�rstammar fr�n EU-projekt

- Fortissimo:  [https://www.fortissimo-project.eu/](https://www.fortissimo-project.eu/)
	- Buying Services (betala anv�ndande per timme)
	- Knowledge Database  (dokumentation)
	- Domain Experts (det det l�ter som)
- cloudSME:  [http://www.cloudsme-apps.com/](http://www.cloudsme-apps.com/)
	- Platform as a Service (PaaS)
	- Software as a Service (SaaS) 
		- CalculiX, OpenFOAM, ...
	
# Sedan s�: ... s�klart ...

- Amazon Web Service (AWS)
	- Elastic Cloud 2
- Google Cloud 
	- Compute Engine (Virtual Machines)
- Microsoft Azure
	- Virtual Machines

\sg Kostnad (Ubuntu, standard tidsbaserad):\wi  

- 64 k�rnor approx: $4/timme
- 16 k�rnor approx: $1/timme


# Rent praktiskt: Varje tj�nst har sin milj�

Det finns att ladda ner:

- F�r Amazon Web Service (AWS)
	- `aws`
- F�r Google Cloud
	- `gcloud`
- F�r Azure
	- `vet ej`

Annars s� funkar browsern och `ssh` bra, dock utan
automatiseringsm�jligheter. 


# Anv�ndning:

1. Skapa konto
2. Starta en "instance"
3. Flytta �ver bin�r och input-fil
4. k�r!

# Anv�ndning:

Skriv ett script som

- startar �nskad instans
- flyttar �ver motor och input-fil
- startar
- flyttar tillbaka n�r klart
- st�nger instans

sedan k�r:

`$>: ccxAWS simfil.inp`


# ccxAWS

\scriptsize

```bash
#! /bin/bash
# Only works for t2.micro AWS instances (1 cpu and free tier)
export AWS_DEFAULT_OUTPUT="text"
ID=$(aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query Reservations[].Instances[].InstanceId)
STATE=$(aws ec2 describe-instance-status --instance-ids $ID --query InstanceStatuses[].InstanceState[].Name)
if [[ -z $STATE ]]; then
    aws ec2 start-instances --instance-ids $ID
fi
# create something to run  (copy ccx and make executable)
scp -i /home/$USER/.ssh/EUcentralKIM.pem /home/$USER/aws/ccx \
    ubuntu@ec2-xx-xxx-xxx-xxx.eu-central-1.compute.amazonaws.com:
ssh -i /home/$USER/.ssh/EUcentralKIM.pem ubuntu@ec2-xx-xxx-xxx-xxx.eu-central-1.compute.amazonaws.com \
    'chmod 755 ccx'
# copy the file and run
scp -i /home/$USER/.ssh/EUcentralKIM.pem $1 ubuntu@ec2-xx-xxx-xxx-xxx.eu-central-1.compute.amazonaws.com:inpFile.inp
ssh -i /home/$USER/.ssh/EUcentralKIM.pem ubuntu@ec2-xx-xxx-xxx-xxx.eu-central-1.compute.amazonaws.com \
    'bash -s' <<'ENDSSH'
    # OMP_NUM_THREADS=64
    # export OMP_NUM_THREADS
    ./ccx inpFile
ENDSSH
```


# Sammanfattning


- Det viktigaste med FOSS �r anv�ndarna
	- De ger feedback p� anv�ndningen
	- De ger hj�lp vid fr�gor
	- De skapa anv�ndardokumentation - manualer, tutorials, etc.
- Hj�lp vid fr�gor
	- mejllistor, chat  --  b�de gamla och nya
	- K�pt support
- Programmen finns p� n�tet
	- Ofta bin�rer, men n�stan alltid k�llkod
- FOSS passar bra f�r molntj�nster
	- Inga konstiga licensvillkor


