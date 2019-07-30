       CBL  SOURCE XREF
       IDENTIFICATION DIVISION.
       PROGRAM-ID. '${1:programID}'. *> this is the name of the COBOL file 
       ************************************************************
       *
       *  ${2:comments of the program}
       *  
       *  
       *
       *  Program     ${1:programID}
       *  PSB:        ${1:programID}
       *  Databases:  none
       *  Access:     none
       *
       ************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  ${3:IBM-370}.
       OBJECT-COMPUTER.  ${3:IBM-370}.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       END PROGRAM ${1:programID}
