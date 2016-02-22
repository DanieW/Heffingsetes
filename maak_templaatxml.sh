#!/bin/bash
# ***********************************************************
# * Leêr: maak_templaatxml.sh                               *
# * Datum: 2009-11-16                                       *
# * Outeur: danie.wessels@pbmr.co.za                        *
# * Doel: Maak 'n nuwe templaatxml vouer vir aangepasde     *
# *       OpenOffice.org write etekaarjies dokument.        *
# ***********************************************************
#
# Stel die veranderlikes op
#
s_dokument=$1
s_vouer=$2
#
# Vir ontfouting van die kode:
ts_debug=0
#
 if test $# -gt 1
  then if [ $ts_debug -gt 10 ] ; then echo "Toevoer was = $0 $1 $2" ; fi
  else echo "Voer twee parameters in: $0 Dokument.odt templaatxml" ; exit
 fi
#
# Onthou 'n ander templaatxml gids kan met die program geskep word.
#
# Skep 'n nuwe vouer vanaf die templaat dokument vir die eenhede.
#           
 if test $ts_debug -gt 20 
  then echo "Dokument=$s_dokument vir gids=$s_vouer"
 fi
#
# Kan hier eers toets of dit suksesvol is, andersins verwyder ou data
mkdir $s_vouer
#
# Die eintlike belangrike stap
unzip -d $s_vouer $s_dokument
#
# en dan die opdatering van die basis gedeelte
cp $s_vouer/content.xml .
#
# stel 'n druk gids op vir dokumente vir uitdruk
mkdir druk
#
# <EOF>

