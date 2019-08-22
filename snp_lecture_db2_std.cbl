      *-----------------------------------------------------------------

      * Snippet de lecture Db2 standard                  

      *-----------------------------------------------------------------

       LECTURE.


           EXEC SQL

           ${1:SQL query}

           END-EXEC


           EVALUATE SQLCODE

               WHEN 0

               ${2:Instructions when OK}

               WHEN 100

                MOVE 21                 TO 410-CR

                MOVE 'LIGNE INCONNUE'   TO 410-LIB-CR

               WHEN OTHER

                MOVE 99                 TO 410-CR

                MOVE 'ERR GRAVE SELECT' TO 410-LIB-CR

           END-EVALUATE.

      *-----------------------------------------------------------------

      * [DB2_Select] : Snipet de lecture Db2 standard                  -

      *-----------------------------------------------------------------
