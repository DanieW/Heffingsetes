#!/bin/bash
# ***********************************************************
# * Leêr: invoer.sh                                        *
# * Datum: 2011-07-13                                       *
# * Outeur: dawessels@telkomsa.net                          *
# * Doel: Om die toevoer waardes vir die heffingsetes       *
# *       program op te stel.                               *
# *                                                         *
# ***********************************************************
#
# Stel die veranderlikes op
#
# Vir 'n bietjie kleur kan ons dalk later die gebruik...
#   Dit sal seker ncursor benodig.
# SET_BRIGHT=1
# SET_NORMAL=0
# SETCOLOR_SUCCESS=”echo –en \\033[1;32m”
# SETCOLOR_FAILURE=”echo –en \\033[1;31m”
# SETCOLOR_WARNING="echo –en \\033[1;33m”
# SETCOLOR_NORMAL="echo –en \\033[0;39m”
# COLOR_Black=30 
# COLOR_Red=31
# COLOR_Green=32
# COLOR_Yellow=33
# COLOR_Blue=34
# COLOR_Purple=35
# COLOR_Cyan=36
# COLOR_White=37
# RES_COL=60
# MOVE_TO_COL=echo –en "\\033[${RES_COL}G”
#
# Begin tog net op die regte plek.
cd ~/heffingsetes
#
s_MM=11
s_JJ="10"
s_nommer_begin=1
s_nommer_stop=202
s_tien_aan="J"
#
if [ -f invoer.ini ] ; 
 then
  for i_indeks in 2 3 4 5 6;
   do
   s_toevoer=`gawk -v i_field="$i_indeks" '{print $i_field}' invoer.ini`
   case $i_indeks in
    2) s_MM=$s_toevoer
     ;;
    3) s_JJ=$s_toevoer
     ;;
    4) s_nommer_begin=$s_toevoer
     ;;
    5) s_nommer_stop=$s_toevoer
     ;;
    6) s_tien_aan=$s_toevoer
     ;;
    *) echo "  === Fout: Nie verwagte i_indeks waarde nie."
     ;;
   esac
  done
 fi
#
# Dit sal hom nie laat uitgaan nie....
i_keuse=6
#
# Skryf opstelling uit: 
#
while let "i_keuse < 7" && let "i_keuse > 0"
 do
  if [ "$s_tien_aan" = "J" ] 
    then
	s_eenheid="blok"
	s_eenhede="blokke"
    else   
	s_eenheid="eenheid"
	s_eenhede="eenhede"
  fi
# clear  >afvoer.log
 echo "     |====================================================|"
 echo "     |    Program: invoer.sh vir heffingsetes programme   |"
 echo "     |                  Weergawe: 20110713                |"
 echo "     |    Huidige opstelling vir heffingsetes programme   |"
 echo "     |====================================================|"
 echo ""
 echo "      ./heffingsetes.sh  $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop "
 echo "      of"
 echo "      ./heffingsetes10.sh  $s_MM  $s_JJ  [$s_nommer_begin..$s_nommer_stop] "
 echo ""
 echo "  ======================================================================"
 echo "   Om enige van die volgende vyf toevoer waardes te verander, voer die "
 echo "   ooreenstemmende nommer in, andersins voer \"6\" in om voort te gaan. "
 echo "    [1] Die maand wat gekies is, = $s_MM "
 echo "    [2] Die jaar wat gekies is, = '$s_JJ"
 echo "    [3] Die eerste $s_eenheid wat gekies is, = $s_nommer_begin"
 echo "    [4] Die laaste $s_eenheid wat gekies is, = $s_nommer_stop"
 echo "    [5] Opsie om tien bladsye per dokument te druk [J/N], = $s_tien_aan"
 echo "                                                                        "
 echo "    [6] Aanvaar die toevoer waardes en druk die heffingsetekaartjies.   "
 echo "                                                                        "
 echo "    [7] Verlaat die program sonder om dit verder uit te voer.           "
 echo "  ======================================================================"
 read -p "   Voer keuse [1-7], in [Enter]: " i_keuse
 echo "  ======================================================================"
# 
# ===============================================================
#
case $i_keuse in
  1) # clear
     echo "  |===========================================================|"
     echo "  |  1=Januarie,    2=Februarie,   3=Maart,      4=April,     |"
     echo "  |  5=Mei,         6=Junie,       7=Julie,      8=Augustus,  |"
     echo "  |  9=September,  10=Oktober,    11=November,  12=Desember   |"
     echo "  |===========================================================|"  
     read -p " [1] Kies die maand, [1 tot 12] vir Januarie tot Desember [Enter]: " s_MM
     while [ $s_MM -lt "1" ] || [ $s_MM -gt "12" ]
       do echo " == Foutiewe invoer. Kies  asseblief weer == "
        date -u | gawk '{print "  == Huidige maand = " $2}' -
        read -p " [1] Kies die maand, [1 tot 12] vir Januarie tot Desember [Enter]: " s_MM
       done
   ;;
  2) # clear
     read -p " [2] Kies die jaartal, XX, [10 tot 99] vir die jaar 20XX [Enter]: " s_JJ
     while [ $s_JJ -lt "10" ] || [ $s_JJ -gt "99" ]
       do echo " == Foutiewe invoer. Kies asseblief weer == " 
        date -u | gawk '{print "  == Huidige jaartal = " $6}' -
        read -p " [2] Kies die jaartal, XX, [10 tot 99] vir die jaar 20XX [Enter]: " s_JJ
       done
   ;;
  3) # clear
     echo "   Die eerste $s_eenheid se nommer vir die afvoer moet nie kleiner as 1 "
     echo "   wees nie, maar dit moet steeds ook nie groter as laaste $s_eenheid se "
     echo "   nommer vir die afvoer, nl. $s_nommer_stop, wees nie. "
  if [ "$s_tien_aan" = "J" ] 
    then
     echo "   Die opsie om tien bladsye per dokument te druk is gekies. "
     echo "   Gebruik blok 1 vir 1-10, 2 vir 11-20, ... 21 vir 201-210 en blok 22 vir 211-219"
  fi
     read -p " [3] Kies die eerste $s_eenheid se nommer vir die begin van die afvoer [Enter]: " s_nommer_begin
     while [ $s_nommer_begin -lt "1" ] || [ $s_nommer_begin -gt $s_nommer_stop ]
       do echo " == Foutiewe invoer. Kies asseblief weer == " 
        read -p " [3] Kies die eerste $s_eenheid se nommer vir die begin van die afvoer [Enter]: " s_nommer_begin
       done
    ;;
  4) # clear
     echo "   Die laaste eenheid se nommer vir die afvoer moet groter as die eerste "
     echo "   eenheid se nommer vir die afvoer, nl $s_nommer_begin_stop wees, maar "
     echo "   dit moet steeds ook nie groter as nommer 202 wees nie. "
  if [ "$s_tien_aan" = "J" ] 
    then
     echo "   Die opsie om tien bladsye per dokument te druk is gekies. "
     echo "   Gebruik blok 1 vir 1-10, 2 vir 11-20, ... 21 vir 201-210 "
     echo "    en blok 22 vir 211-219"
  fi
     read -p " [4] Kies die laaste $s_eenheid se nommer vir die einde van die afvoer [Enter]: " s_nommer_stop
     while [ $s_nommer_stop -lt "1" ] || [ $s_nommer_stop -gt "220" ]
       do echo " == Foutiewe invoer. Kies asseblief weer == " 
       read -p " [4] Kies die laaste $s_eenheid se nommer vir die einde van die afvoer [Enter]: " s_nommer_stop
      done
    ;;
  5) # clear
     echo "   Die opsie om tien bladsye per dokument te druk beteken dat blokke van "
     echo "   tien eenhede gekies moet work in plaas daarvan om die eenhede self se "
     echo "   nommers te kies. "
     echo "   Om hierdie opsie te gebruik, gebruik blok  1 vir eenhede   1 -  10, "
     echo "                                        blok  2 vir eenhede  11 -  20, "
     echo "                                         ''   :  ''   ''      : -   :  "
     echo "                                        blok 21 vir eenhede 201 - 210, "
     echo "                                     en blok 22 vir eenhede 211 - 219. "
     read -p "[5] Wil u die opsie kies om tien bladsye per dokument te druk? [J/N]-[Enter]:" s_tien_aan
     while [ "$s_tien_aan" != "J" ] && [ "$s_tien_aan" != "N" ]
       do echo " == Foutiewe invoer. Kies asseblief weer. (Nie 'j' of 'n' nie) == " 
       read -p "[5] Wil u die opsie kies om tien bladsye per dokument te druk? [J/N]-[Enter]:" s_tien_aan  
      done
    ;;
   6) # clear
     echo " [6] Loop heffingsetes: "
#                              1      2      3                4               
#                    export  $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop
# ./heffingsetes.sh            $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop
  if [ "$s_tien_aan" = "J" ]
   then
    for s_nommer in `seq $s_nommer_begin $s_nommer_stop`
      do
       ./heffingsetes10.sh  $s_MM  $s_JJ  $s_nommer 
       echo `date` ./heffingsetes10.sh  $s_MM  $s_JJ  $s_nommer  >>invoer.log
      done
   else
     ./heffingsetes.sh  $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop
     echo `date` ./heffingsetes.sh  $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop  >>invoer.log
  fi
     echo ./invoer.sh  $s_MM  $s_JJ  $s_nommer_begin  $s_nommer_stop $s_tien_aan >invoer.ini
# 
     echo " == [1] Herhaal die program. "
     echo " == [2] Verlaat die program. "
     read -p " == Opsie: " herhaal_opsie
     if [ $herhaal_opsie -eq 2 ]
        then i_keuse=7
     fi
   ;;
  7) # clear >afvoer.log
     echo " [7] Verlaat die program sonder enige verdere afvoer.";
   ;;
  *) clear >afvoer.log
     echo " === Ongeldige keuse: Verlaat die program."
  esac
done
echo " == Maak seker dat alles klaar gedruk is "
echo " == (sien C:\cygwin\home\Owner\heffingsetes\druk\), "
read -p " == maak LibreOffice toe, en druk dan [Enter]! : " herhaal_opsie
rm druk/*
exit
#
# <EOF>
