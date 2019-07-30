000100 CBL  SOURCE XREF
000200 IDENTIFICATION DIVISION.
000300 PROGRAM-ID. '${1:mprb05}'. *> this is the name of the COBOL file 
000400************************************************************
000500*
000600*  ${2:comments of the program}
000700*  
000710*  
000800*
000900*  Program     ${1:mprb05}
001000*  PSB:        ${1:mprb05}
001100*  Databases:  none
001200*  Access:     none
001300*
001400************************************************************
001500 ENVIRONMENT DIVISION.
001600 CONFIGURATION SECTION.
001700 SOURCE-COMPUTER.  ${3:IBM-370}.
001800*SOURCE-COMPUTER.  ${3:IBM-370} with debugging mode.
001900 OBJECT-COMPUTER.  ${3:IBM-370}.
002000 DATA DIVISION.
002100 WORKING-STORAGE SECTION.
002200
