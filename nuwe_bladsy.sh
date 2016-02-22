#!/bin/bash
# ***********************************************************
# * Leêr: nuwe_bladsy.sh                                   *
# * Datum: 2014-07-30                                       *
# * Outeur: danie.wessels@live.co.za                        *
# * Doel: Pas OpenOffice.org write etekaarjies templaat aan *
# *       om vir al die eenhede van Protea Aftree-oord 10   *
# *       kaartjies per A4 bladsy te druk                   *
# ***********************************************************
#
# Stel die veranderlikes op soos die (met "tildes", ~ ipv spasies)
# s_Emm="NOV"
# s_JJ="09"
# s_Amm="NOV"
# s_Kaartjie="~" {As spasie}
# s_Naam='Mev~M~S~Nel'
# s_nommer=202
# s_MM="11"
#
s_Emm=$1
s_JJ=$2
s_Amm=$3
s_Kaartjie=$4
s_Naam=$5
#   s_Naam='Mev M S Nel'   
#   Te-doen: Raak ontslae van die "tildes"!
s_nommer=$6
s_MM=$7
s_Dokument=$8
ts_debug=10
#
if [ $ts_debug -gt 90 ] 
  then echo "$0  $s_Emm  $s_JJ  $s_Amm  $s_Kaartjie  ''$s_Naam''  $s_nommer  $s_MM  $s_Dokument" ; fi
#
# Sny die eesrte en laaste dubbel aanhalingstekens af.
#
let i_lengte=`echo $s_Naam |wc -c`-2
s_Naam=`echo $s_Naam |cut -c2-$i_lengte`
#
# *****************************
# Sit ekstra spasies in.....
#  s_Naam=`echo $s_Naam | sed s/~/~~~/g` 
# echo "lengte=[$i_lengte]"
#
# Skep 'n nuwe dokument vir die eienaar van eenheid $s_nommer
#
gawk  -v var_Emm=$s_Emm  -v var_JJ=$s_JJ  -v var_Amm=$s_Amm  -v var_Kaartjie=$s_Kaartjie  -v var_Naam=$s_Naam  -v var_unit=$s_nommer  -v var_MM=$s_MM '{gsub("Emm",var_Emm); gsub("JJ",var_JJ); gsub("Amm",var_Amm); gsub("Kaartjie",var_Kaartjie); gsub("Naam",var_Naam); gsub("XX",var_unit); gsub("xMM",var_MM)}; {gsub("~"," ")}; {print $0}' content.xml >~/heffingsetes/templaatxml/content.xml
#
cd ~/heffingsetes/templaatxml
#
zip -r ../druk/$s_Dokument *   >>../afvoer.log
#
cd ..
#
# <EOF>
