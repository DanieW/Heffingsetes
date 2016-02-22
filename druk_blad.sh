#!/bin/bash
# ***********************************************************
# * Leêr: druk_blad.sh                                      *
# * Datum: 2010-01-22                                       *
# * Outeur: danie.wessels@live.co.za                        *
# * Doel: Om die afvoer dokumente vir die heffingsetes      *
# *       uit te druk en te verwyder.                       *
# *                                                         *
# ***********************************************************
#
s_Dokument=$1
#
/cygdrive/C/Program\ Files/OpenOffice.org\ 3/program/swriter.exe -p "c:/cygwin/home/Gretchen/heffingsetes/druk/$s_Dokument"
#
rm "/home/Gretchen/heffingsetes/druk/$s_Dokument"
#
# <EOF>
