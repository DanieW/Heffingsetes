#!/bin/bash
# ***********************************************************
# * Leêr: heffingsetes10.sh                                 *
# * Datum: 2010-03-19                                       *
# * Outeur: danie.wessels@pbmr.co.za                        *
# * Doel: Beheer program om OpenOffice.org write            *
# *       etekaarjies templaat aan te pas en te druk.       *
# *                                                         *
# ***********************************************************
# ./heffingsetes10.sh Maand_MM Jaartal_JJ Blok_nommer
# bv. :
#  ./heffingsetes10.sh 11 10  21 
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
   echo " Geen maand was gekies nie"
   echo " $0 Maand_MM Jaartal_JJ Stop_Eenheid_nr/10"
   echo " Gebruik blok 1 vir 1-10, blok 2 vir 11-20, ... blok 20 vir 191-200"
   echo " en blok 21 vir 201-209 en blok 22 vir 210-219."
   echo "$0 11 10 21"
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
#
s_Stop10=$3
# s_Stop10 = 202 ?
 if test $# -gt 2
  then if [ $ts_debug -gt 62 ] ; then echo "Die bloknommer wat gekies was = $s_Stop10" ; fi
  else echo "Geen bloknommer was gekies as 4de parameter, (soos 22 vir 210-219) nie" ; exit
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
  #
s_Stop=$(($s_Stop10 * 10))
  #
i_Bladsy=1
  # 
s_Dokument="Eenheid_x1_$s_Stop.odt"
  #
  #
 #- if [ $s_Stop -eq 210 ]
 #- then
 #-  ./heffingsetes.sh $1 $2 201 202
 #- else
   s_Begin=$(($s_Stop - 9))
   #
 cat beginbladsy10 >templaat10xml/content.xml
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
  s_Dokument=bladsy_x_$i_Bladsy
  cat bladsy_$i_Bladsy >$s_Dokument  #  bladsy_x_$i_Bladsy
     #
     # Was eers:     s_Dokument="Eenheid$s_nommer.odt"
     # Skep 'n nuwe dokument vir die eienaar van eenheid nommer $s_nommer
     #           1       2      3       4            5        6          7      8   
     #         $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM  $s_Dokument
    if [ $ts_debug -gt 40 ] 
      then echo ./nuwe_bladsy10.sh  $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM  $i_Bladsy$s_Dokument ; fi
     ./nuwe_bladsy10.sh  $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  $s_Naam  $s_nommer  $s_MM   $s_Dokument
     #
     #  cat bladsy_x_$i_Bladsy.xml >>templaat10xml/content.xml
    cat $s_Dokument.xml >>templaat10xml/content.xml
     #
    i_Bladsy=$(($i_Bladsy + 1))
     #
     #
 done
     #
  cat endbladsy10 >>templaat10xml/content.xml
     #
     #  maak_dokument10.sh   $s_Dokument  
     #
  cd templaat10xml
     #
  s_Dokument="Blok_$s_Stop10.odt"
     #
  zip -r ../druk/$s_Dokument *
     #
  cd ..
     #
     # Druk die lêer uit
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
     # ** sleep 8 
     #
     #  done was eers hiernatoe geskuif
     #   - Sodat die leers hopelik meer in volgorde gedruk word. 2010-01-22 **
     #   done
 #- fi
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
