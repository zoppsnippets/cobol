000100 CBL  SOURCE XREF
000200 IDENTIFICATION DIVISION.
000300 PROGRAM-ID. 'mprb05'.
000400************************************************************
000500*
000600*  Read transactions from the message queue
000700*  and display them (when in debugging mode)
000710*  Zero delay during the transaction
000800*
000900*  Program     mprb05
001000*  PSB:        mprb05
001100*  Databases:  none
001200*  Access:     none
001300*
001400************************************************************
001500 ENVIRONMENT DIVISION.
001600 CONFIGURATION SECTION.
001700 SOURCE-COMPUTER.  IBM-370.
001800*SOURCE-COMPUTER.  IBM-370 with debugging mode.
001900 OBJECT-COMPUTER.  IBM-370.
002000 DATA DIVISION.
002100 WORKING-STORAGE SECTION.
002200
002300************************************************************
002400*            IMS DECLARATIONS
002500************************************************************
002600
002700 77  QC                   PIC X(2) VALUE 'QC'.
002800 77  GU-FUNC              PIC X(4) VALUE 'GU  '.
002900 77  ISRT                 PIC X(4) VALUE 'ISRT'.
003000 77  ROLL-FUNC            PIC X(4) VALUE 'ROLL'.
003100 77  dli-gur              pic x(4) value 'GUR'.
003200 77  dli-gn               pic x(4) value 'GN'.
003300 77  dli-inqy             pic x(4) value 'INQY'.
003400
003500 77  end-of-transactions-qq  pic x value 'n'.
003600     88 no-more-transactions       value 'y'.
003700 77  error-on-get-qq         pic x value 'n'.
003800     88 error-on-get               value 'y'.
003900
004000 77  random-value         usage is comp-2.
004010 77  tran-count           usage is comp-2 value 0.
004020 77  all-tran-count       usage is comp-2 value 0.
004030 77  display-all-tran-count
004040                          pic zzz,zzz,zz9.
004100 77  delay-msec           PIC 9(9) binary.
004200 77  display-delay-msec   PIC 9(9).
004300 77  seed                 pic s9(9) binary value 0.
004400
004500*01  delay-feedback       pic x(8).
004600*    copy CEEIGZCT.
004700*
004800*01  random-feedback       pic x(8).
004900*    copy CEEIGZCT.
005000 01 FC1.
005100     02 CONDITION-TOKEN-VALUE.
005200     COPY CEEIGZCT.
005300       03 CASE-1-CONDITION-ID.
005400          04 SEVERITY PIC S9(4) BINARY.
005500          04 MSG-NO PIC S9(4) BINARY.
005600       03 CASE-2-CONDITION-ID
005700          REDEFINES CASE-1-CONDITION-ID.
005800          04 CLASS-CODE PIC S9(4) BINARY.
005900          04 CAUSE-CODE PIC S9(4) BINARY.
006000       03 CASE-SEV-CTL PIC X.
006100       03 FACILITY-ID PIC XXX.
006200      02 I-S-INFO PIC S9(9) BINARY.
006300 01 FC2.
006400      02 CONDITION-TOKEN-VALUE.
006500      COPY CEEIGZCT.
006600       03 CASE-1-CONDITION-ID.
006700          04 SEVERITY PIC S9(4) BINARY.
006800          04 MSG-NO PIC S9(4) BINARY.
006900       03 CASE-2-CONDITION-ID
007000          REDEFINES CASE-1-CONDITION-ID.
007100          04 CLASS-CODE PIC S9(4) BINARY.
007200          04 CAUSE-CODE PIC S9(4) BINARY.
007300       03 CASE-SEV-CTL PIC X.
007400       03 FACILITY-ID PIC XXX.
007500     02 I-S-INFO PIC S9(9) BINARY.
007600
007700
007800
007900 01  AIB.
008000     02 AIBRID             PIC x(8).
008100     02 AIBRLEN            PIC 9(9) USAGE BINARY.
008200     02 AIBRSFUNC          PIC x(8).
008300     02 AIBRSNM1           PIC x(8).
008400     02 AIBRSNM2           PIC x(8).
008500     02 AIBRESV1           PIC x(8).
008600     02 AIBOALEN           PIC 9(9) USAGE BINARY.
008700     02 AIBOAUSE           PIC 9(9) USAGE BINARY.
008800     02 AIBRESV2           PIC x(12).
008900     02 AIBRETRN           PIC 9(9) USAGE BINARY.
009000     02 AIBREASN           PIC 9(9) USAGE BINARY.
009100     02 AIBERRXT           PIC 9(9) USAGE BINARY.
009200     02 AIBRESA1           USAGE POINTER.
009300     02 AIBRESA2           USAGE POINTER.
009400     02 AIBRESA3           USAGE POINTER.
009500     02 AIBRESV4           PIC x(40).
009600     02 AIBRSAVE     OCCURS 18 TIMES USAGE POINTER.
009700     02 AIBRTOKN     OCCURS 6 TIMES  USAGE POINTER.
009800     02 AIBRTOKC           PIC x(16).
009900     02 AIBRTOKV           PIC x(16).
010000     02 AIBRTOKA     OCCURS 2 TIMES PIC 9(9) USAGE BINARY.
010100
010200* DATA AREA FOR TERMINAL INPUT
010300 01  INPUT-MESSAGE.
010400         03  IN-LL        PIC  S9(4) COMP.
010500         03  IN-ZZ        PIC  S9(4) COMP.
010600         03  IN-TRANCODE  PIC  X(8).
010700         03  IN-DATA.
010800             04  IN-LINE1 PIC  X(80).
010900
011000* DATA AREA FOR TERMINAL OUTPUT
011100 01  OUTPUT-AREA.
011200     02  OUT-LL       PICTURE S9(3) COMP.
011300     02  OUT-ZZ       PICTURE S9(3) COMP.
011400     02  OUT-LINE     PICTURE X(96).
011500     02  OUT-DATA REDEFINES OUT-LINE.
011600        04  OUT-TEXT      PIC X(32).
011700        04  OUT-MSG1      PIC X(32).
011800        04  OUT-MSG2      PIC X(32).
011900
012000*****************************************************
012100 LINKAGE SECTION.
012200
012300 copy iopcb.
012400
012500 PROCEDURE DIVISION USING IOPCB.
012600*****************************************************
012700 MAIN-RTN.
012800
013100     perform initialise-program
013200        thru end-initialise-program.
013300
013400     perform
013500        get-transaction
013600        thru end-get-transaction
013700        with test after
013800        until no-more-transactions
013900           or error-on-get.
014000
014100     perform finalise-program
014200        thru end-finalise-program.
014300
014400     perform return-to-caller.
014500
014600 initialise-program.
014610*    DISPLAY "COBOL Program mprb05 execution begins... ".
014620     DISPLAY "COBOL Program mprb05 execution begins... "
014630        upon console.
014640
014700*    display "initialise program, delay is RANDOM" upon console.
014800 end-initialise-program.
014900     exit.
015000
015100 get-transaction.
015200D    display "get transaction".
015300     call 'CBLTDLI' using GU-FUNC IOPCB output-area.
015400     if iopcb-status-code = QC
015500        move 'y' to end-of-transactions-qq
015600D       display "QC status code" upon console
015610     else
015620        if iopcb-status-code not = spaces
015630           display 'error on get iopcb'
015700           display iopcb
015710           move 'y' to error-on-get-qq.
015800     add 1 to tran-count all-tran-count.
015900     if tran-count > 1000
016000        display "1000 transactions processed" upon console
016100        move 1 to tran-count.
016101D    display 'delay starts' upon console.
016102D    display 'delay starts'.
016103D    call 'CEERAN0' using seed, random-value, fc1.
016104D    IF not CEE000 OF FC1 THEN
016200D       DISPLAY "CEERAN0 FAILED WITH MSG " MSG-NO OF FC1
016300D       goback
016400D       END-IF.
016500*    convert 0.0-1.0 to milliseconds
016600D    compute delay-msec = 1000 * random-value.
016700D    move delay-msec to display-delay-msec.
016800D    display "delay is " display-delay-msec " msec".
016900D    call 'CEEDLYM' using delay-msec FC2.
017000D    IF not CEE000 OF FC2 THEN
017100D       DISPLAY "CEEDLYM FAILED WITH MSG " MSG-NO OF FC2
017200D       goback
017300D       END-IF.
017400
017500D    display 'delay ends'.
017600
017700 end-get-transaction.
017800     exit.
017900
018000 finalise-program.
018010     move all-tran-count to display-all-tran-count.
018100     display "COBOL Program mprb05 done now, with "
018200        display-all-tran-count " transactions processed."
018201        upon console.
018202 end-finalise-program.
018300     exit.
018400
018500 RETURN-TO-CALLER.
018600     DISPLAY "Returning ...".
018700     GOBACK.
018800
018900
019000 END PROGRAM "mprb05".