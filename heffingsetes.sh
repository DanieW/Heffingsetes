#!/bin/bash
# ***********************************************************
# * Leêr: heffingsetes.sh                                   *
# * Datum: 2011-07-21                                       *
# * Outeur: danie.wessels@live.co.za                        *
# * Doel: Beheer program om OpenOffice.org write            *
# *       etekaarjies templaat aan te pas en te druk.       *
# *                                                         *
# ***********************************************************
# ./heffingsetes.sh Maand_MM Jaartal_JJ Begin_Eenheid_nr Stop_Eenheid_nr
# bv. :
#  ./heffingsetes.sh 11 09 1 202
#
cd ~/heffingsetes
ts_debug=40 # Vir ontfoutings doeleindes > 30
s_MM=$1
 if test $# -ne 0
  then if (test $s_MM -gt 0) && (test $s_MM -lt 13)
    then if [ $ts_debug -gt 30 ] 
         then echo "Die maand wat gekies was = $s_MM"
       fi
    else  
      echo "Die maand was nie reg gekies nie = $s_MM"
      exit
    fi
  else 
   echo "Geen maand was gekies nie"
   echo "$0 Maand_MM Jaartal_JJ Begin_Eenheid_nr Stop_Eenheid_nr"
   echo "$0 11 10 1 219"
   exit
 fi
#
s_JJ=$2
# s_JJ = "09" ?
 if test $# -gt 1 
  then if [ $ts_debug -gt 60 ] ; then echo "Jaar 20JJ wat gekies was = $s_JJ" ; fi
  else echo "Geen twee syfer jaargetal was gekies as 2de parameter, (soos 09) nie" ; exit
 fi
#
s_Begin=$3
# s_Begin = 1 ?
 if test $# -gt 2
  then if [ $ts_debug -gt 61 ] ; then echo "Die eerste Eenheidsnommer wat gekies was = $s_Begin" ; fi
  else echo "Geen begin Eenheidsnommer was gekies as 3de parameter, (soos 1) nie" ; exit
 fi
#
s_Stop=$4
# s_Stop = 202 ?
 if test $# -gt 3
  then if [ $ts_debug -gt 62 ] ; then echo "Die laaste Eenheidsnommer wat gekies was = $s_Stop" ; fi
  else echo "Geen laaste Eenheidsnommer was gekies as 4de parameter, (soos 219) nie" ; exit
 fi
#
# ============================================
#
s_Emm=`gawk -v var_MM=$s_MM '$1==var_MM {print $2 }' Month_list.txt` ; export s_Emm
#
 if [ $ts_debug -gt 63 ] ; then echo "s_Emm = $s_Emm" ; fi
# 
s_Amm=`gawk -v var_MM=$s_MM '$1==var_MM {print $3 }' Month_list.txt` ; export s_Amm
 if [ $ts_debug -gt 64 ] ; then echo "s_Amm = $s_Amm" ; fi
#
s_Kaartjie="""~"""  # Dit moet 'n "" string wees! (Vir Kaartjie1 tot Kaartjie10 word dit 1 tot 10)
#
for s_nommer in `seq $s_Begin $s_Stop`
 do
  #  if [ $ts_debug -gt 58 ] ; then echo "Eenheid = $s_nommer"; fi
  #  s_nommer=$a
  #
   if [ $ts_debug -gt 65 ] ; then echo "s_nommer = $s_nommer" ; fi
  # 
 s_Naam=`gawk -v var_unit=$s_nommer 'BEGIN{FS=","}; $1==var_unit {print $2 }'  Residents.csv` ; export s_Naam
# if [ $ts_debug -gt 66 ]; then echo '# set s_nommer=202; s_Naam="R. Van Deventer"; '; fi
   if [ $ts_debug -gt 67 ] ; then echo "$s_Naam = $s_Naam" ; fi
  #
#
# Te doen: Moet voorsiening maak vir meer as een.
#
  # Indien Naam nie gedefinieer is nie, stel dit na tilde.
  #
 if [ `echo $s_Naam |wc -c` -lt 3 ]
  then s_Naam="""~"""
 fi
  #
 s_Naam=`echo $s_Naam | gawk 'gsub(" ","~") {print}'`
   # s_Naam='Mev~M~S~Nel'
   # s_Naam='Mev M S Nel'
   # Te-doen: Raak ontslae van die "underscores"!
  #
 s_Dokument="Eenheid$s_nommer.odt"
  #
  # Skep 'n nuwe dokument vir die eienaar van eenheid nommer $s_nommer
  #           1       2      3       4            5        6          7      8   
  #         $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM  $s_Dokument
  if [ $ts_debug -gt 40 ] 
  then echo ./nuwe_bladsy.sh  $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM  $s_Dokument ; fi
  ./nuwe_bladsy.sh  $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM  $s_Dokument
  #     echo "                                        blok 20 vir eenhede 191 - 200, "

# ** - done **
#
# Druk al die lêers uit
#
# Vir Windows omgewing:
# "C:\Program Files\OpenOffice.org 2.3\program\soffice.exe" -pt "Lexmark T640 (MS)" "C:\Documents and Settings\Owner\excel_documents\A_TEST_.xls"
#
# Vir Unix omgewing: soffice -pt "\\server\queue" dokument1.doc dokument2.doc
# ** Verwyder hierdie:
# ** /cygdrive/C/Program\ Files/OpenOffice.org\ 3/program/swriter.exe -p `ls ~/heffingsetes/druk/*.odt`
# ** en vervang hiermee:
/cygdrive/C/Program\ Files/LibreOffice\ 3.4/program/swriter.exe -p "c:/cygwin/home/Owner/heffingsetes/druk/$s_Dokument" &
#
# 
sleep 20 
#
# ** done is nou hiernatoe geskuif - Sodat die leers hopelik meer in volgorde gedruk word. 2010-01-22 **
done
# ===================
# Sit 'n Enter in na :
# Vir die rootdrukker: /cygdrive/C/Program\ Files/OpenOffice.org\ 3/program/swriter.exe -p `ls druk/*.odt`
# "C:\Program Files\OpenOffice.org 3\program\swriter.exe" -pt `ls druk/*.odt` "KONICA MINOLTA 350/250/200 PCL"
# -- soffice -p `ls druk/*.odt`
# soffice -pt `ls druk/*.odt` "KONICA MINOLTA 350/250/200 PCL"
#
# Verwyder al die leers.
#
# ** Is dit nodig??
# sleep 30
#
# rm druk/*
#
# <EOF>
