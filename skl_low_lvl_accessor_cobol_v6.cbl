      *-----------------------------------------------------------------

      * ${1:Description du programme}

      *-----------------------------------------------------------------

      *Generated from skeleton program

      * "low-level accessor-Cobol V6.2-V1"

      *-----------------------------------------------------------------

       IDENTIFICATION DIVISION.

       PROGRAM-ID. ${2:Nom du programme}.

       AUTHOR. ${3:Auteur du programme}.

       DATE-WRITTEN.

       DATE-COMPILED.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       SOURCE-COMPUTER. IBM-370.

       OBJECT-COMPUTER. IBM-370.

       SPECIAL-NAMES.

           DECIMAL-POINT IS COMMA.

       DATA DIVISION.

      *-----------------------------------------------------------------

       WORKING-STORAGE SECTION.

      *---



      *---

 

      *---

 

      *-----------------------------------------------------------------

       LINKAGE SECTION.

        01 ${4:Linkage level 1}.

          05 ${5:Input high level}.

            10 410-VILLE                  PIC X(20).

          05 ${6:Output high level}.

            10 410-C-POST                 PIC 9(05).

            10 410-LIB-DEPT               PIC X(40).

          05 410-CR                       PIC 9(02).

          05 410-LIB-CR                   PIC X(20).

      *-----------------------------------------------------------------

 

      *-----------------------------------------------------------------

       PROCEDURE DIVISION USING ${4:Linkage level 1}.

 

      *-----------------------------------------------------------------

       TRAITEMENT.

   

           INITIALIZE ${6:Output high level}.

           INITIALIZE 410-CR.

           INITIALIZE 410-LIB-CR.

 

           MOVE 410-VILLE TO W-VILLE

           PERFORM LECTURE.

 

       TRAITEMENT-FIN.

           EXIT.

 

      *-----------------------------------------------------------------

      * [INSÃ‰RER SNIPPET LECTURE DB2]                  

      *-----------------------------------------------------------------

       FIN-GENERALE.

 

            MOVE SQLCODE TO ZZ-SQL

            DISPLAY 'OAEFT410 ----------------------------------------'

            DISPLAY '410-ENTREE = ' ${5:Input high level}

            DISPLAY '410-SORTIE = ' ${6:Output high level}

            DISPLAY '-------->'

            DISPLAY '410SQLCODE = ' ZZ-SQL

            DISPLAY '410-CR      = ' 410-CR

            DISPLAY '410-LIB-CR  = ' 410-LIB-CR

            DISPLAY '${2:Nom du programme} FIN -------------------------------'

 

            GOBACK.

      *-----------------------------------------------------------------

      * End of skeleton

      *-----------------------------------------------------------------
