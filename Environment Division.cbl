       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. ${1:source-computer}.
       OBJECT-COMPUTER. ${2:object-computer}.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT ${3:FILEN} ASSIGN TO ${4:DDNAME}
       ORGANIZATION IS SEQUENTIAL.
