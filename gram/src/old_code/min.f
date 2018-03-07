           implicit none
      
      integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
      integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
      character*20 infile_1, infile_2, infile_3, infile_4, infile_6
      character*20 infile_5, outfile_1, outfile_2, outfile_3, tresnc, pnumc
      character*20 outfile_4
      integer i, j, k, t, m, flag, flag2, ierr, site(100)
      integer bfx, bfy, bfz, tresn, pnum
      integer, parameter :: ndatmax=3000
      integer, parameter :: max_mod=3000
      
      integer pmod(max_mod), pmod2(max_mod)
      integer nsub(ndatmax), nsub1(ndatmax)
      integer repe(max_mod)
      double precision mods(max_mod, max_mod)
      double precision frequ(max_mod), frequ2(max_mod)
      double precision temp(max_mod), norm(max_mod), norm_pond(max_mod)
      double precision bf(max_mod), adj_pond(max_mod)
      double precision bf_tot(max_mod)
      double precision bf_frac(max_mod, max_mod)
      double precision tempx(max_mod)
      double precision tempy(max_mod)
      double precision tempz(max_mod)
      double precision bf_mode(max_mod), mode_pond(max_mod)
      double precision mods2(max_mod, max_mod)
      double precision bf_mode_tot
      double precision bf_mode_sort(max_mod), mode_pond2(max_mod)

      integer ndat,pnumber, nmod,iflag,ldx,iexp
      double precision getdet, cerdo
      double precision idet, new
      double precision modos(ndatmax,ndatmax)
      double precision WKSPCE(ndatmax)
      double precision modosp(ndatmax,ndatmax)
      double precision modos2(ndatmax,ndatmax)
      double precision modosp2(ndatmax,ndatmax)
      double precision modos3(ndatmax,ndatmax)
      double precision modos3_pond(ndatmax,ndatmax)
      double precision vol,vol2,vol3, vol4
      double precision modostemp(ndatmax,ndatmax)
      double precision scpr(ndatmax,ndatmax),scpr2(ndatmax,ndatmax)
      double precision scpr_pond(ndatmax,ndatmax)
      double precision proy(ndatmax)
      double precision pint
      integer ascpr(ndatmax,ndatmax),z
      integer iorden(ndatmax)
      integer ifail
      double precision diag(ndatmax,ndatmax)
      double precision freq(ndatmax),e(ndatmax)
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      ! este codigo hace solamente el min-cost assignment entre 2 subespacios
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      
      i=0
      j=0
      k=0
      t=0
      m=0
      call getarg (1, infile_1)!        1er subespacio
      call getarg (2, infile_2)!       	2do subspace 
      call getarg (3, tresnc)! 	 	 nro de modos-6
      read(tresnc, *) tresn
      ndat=tresn+6
      call getarg (4, outfile_1)!     	2do subspace, ordenado segun el 1ero 
      call getarg (5, outfile_2)!     	orden del 2do subspace

      open (11, file=infile_1)
      open (12, file=infile_2)
      open (21, file=outfile_1)
      open (22, file=outfile_2)
      !!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      do i=1, tresn+6!                          leo el 1er set de modos
      	read(11,91) (modos(i,j),j=1, tresn)
      enddo
      !!!!
      do i=1, tresn+6!                          leo el 2do set de modos
      	read(12,91) (modosp(i,j),j=1, tresn)
      enddo
      do i=1, tresn+6!  		nsub tiene el orden del 1er subsace. Es decir, de 1 a 3N 
       nsub(i)=i
      enddo

      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      !!!!!!!!!!!!!!!!!!!!!!!!!! determina  el 2do subspace !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      !Lo q viene ahora es preparacion p/ usar la rutina apc
      do i=1,ndat
      	do j=1,ndat
      		scpr(i,j)=0.0d0
      		do k=1,ndat
      			scpr(i,j)=scpr(i,j)+modos(k,i)*modosp(k,j)!        la fila 'n' de scpr tiene el pdto escalar entre el modo 'n'
      		enddo!                                                no perturbado (MN) y todos los modos perturbados (MPs). O sea, en la
      	enddo!                                                   fila 'n', el 1er elemento es el pdto escalar entre el modo 'n' y el 
      enddo!                                                      modo  perturbado 1, el 2do elemento es el pdto escalar
      !                                                      entre el modo 'n' y el modo perturbado 2
      do i=1,ndat
      	do j=1,ndat
      		ascpr(i,j)=int(scpr(i,j)**2*1.d5)
      	enddo
      enddo
      ! window***************
      do i=1,ndat
      	do j=1,ndat
      		if((j.lt.(i-4)).or.(j.gt.(i+4))) then
!      			ascpr(i,j)=-1*ifix(sngl(1.d5))
      			ascpr(i,j)=-100000
      		endif
      	enddo
      enddo
      do i=1,ndat
      	do j=1,ndat
      		ascpr(i,j)=-1*ascpr(i,j)!                   ascpr conserva la diagonal de scpr de un ancho de 9 valores, el resto de los
      	enddo!                                         valores estan puestos a 100,000. En la diagonal, los valores estan elevados
      enddo!                                            a la 2 (para desligarse del signo) y estan multiplicados por -100,000   
      !                                       to.do esto lo hace p q el apc suele cometer errores; p/ limitar la posibilidad de estos, y 
      !                                       sabiendo q posibles intercambios de modos son entre modos cercanos, se preocupa solamente por
      !                                       la diagonal y hace al resto muuy gde (y a la diagonal muuy chica). Entonces, no hay chances
      !                                       de q apc intercambie, por error, modo5 con modo676. Aunque puede hacer algun error entre los
      !                                       modos de la diagonal, aunque eso seria muuuy raro.


      call apc(tresn,ascpr,iorden,z)     
 
      do j=1,ndat
      	do i=1,ndat
      		modostemp(j,i)=modosp(j,iorden(i))!                 
      		if(scpr(i,iorden(i)).lt.0.0d0) then!                
      			modostemp(j,i)=-1.0d0*modostemp(j,i)!           
      		endif!                                              
      	enddo!                                                 
      enddo!                                                    
      !Lo q hace el ultimo ciclo:
      !al ver scpr(i,iorden(i)) esta viendo el pdto entre modos correspondientes (otra forma de verlo: 
      !si modos y modosp estuvieran ordenados de igual manera, seria lo mismo q poner scpr(i,i) 
      !y estaria recorriendo la diagonal de scpr, q tiene los pdtos escalares entre modos 
      !correspondientes (1y1, 2y2, 3y3...) si los pdtos escalares son negativos, significa q el 
      !angulo entre los vts (modos) es > a 90, o sea q tienen componente con sentido opuesto. 
      !Como eso no me importa, lo elimino. 
      !Se fija en la diagonal por q ahi estan los pares de vts correspondientes
      do j=1,ndat
      	do i=1,ndat
      		modosp(j,i)=modostemp(j,i)
      	enddo
      enddo

      do i=1, ndat!                          
          write (22,*) nsub(i),iorden(nsub(i))
      enddo 
      ! Termino de ordenar los modos
      do j=1,ndat
      	do i=1,ndat
      	   modosp2(j,i)=modosp(j,nsub(i))
      	enddo
      enddo
        !!!!!!!!!!!!!!!!!!!!!!!!!!! grabo los subespacios reducidos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!     
      do j=1,ndat
      	write(21,91) (modosp2(j,i),i=1,ndat)
      enddo
      
      close(11)
      close(12)
      close(21)
      close(22)
  
91      format(10000(1x,F9.6))
92      format(1x,E24.15)
93      format(1i3)
94      format(500(i10))
95      format(1i3,1x,1x,1x,1i6)
96      format(1i3,1x,1x,1x,F9.6)
      
      end

      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      
!     ******* SAMPLE CALLING PROGRAM FOR SUBROUTINE APC	   *******
!     ***     (MIN-COST	ASSIGNMENT PROBLEM)		       ***
!     ***						       ***
!     ***     THE PROGRAM IS BASED ON THE PAPER		       ***
!     ***     G. CARPANETO, S. MARTELLO, P. TOTH "ALGORITHMS   ***
!     ***       AND CODES FOR THE ASSIGNMENT PROBLEM",	       ***
!     ***	ANNALS OF OPERATIONS RESEARCH 7, 1988.	       ***
!     ***						       ***
!     ***     ALL THE SUBROUTINES ARE WRITTEN IN AMERICAN      ***
!     ***	STANDARD FORTRAN AND ARE ACCEPTED BY THE       ***
!     ***	PFORT VERIFIER.				       ***
!     ***						       ***
!     ***     QUESTIONS	AND COMMENTS SHOULD BE DIRECTED	TO     ***
!     ***     SILVANO MARTELLO AND PAOLO TOTH		       ***
!     ***     D.E.I.S.,	UNIVERSITA' DI BOLOGNA,                ***
!     ***     VIALE RISORGIMENTO 2,                            ***
!     ***     40136, BOLOGNA, ITALY.                           ***
!     ************************************************************
!
!      INTEGER A(260,260),F(260),Z
!
!      double precision b(260,260)
!
!      READ(5,10) N
!   10 FORMAT(20I4)
!
!!      DO 20 I=1,N
!        READ(5,10) (A(I,J),J=1,N)
!!   20 CONTINUE
!
!      DO 20 I=1,N
!        READ(5,*) (b(I,J),J=1,N)
!   20 CONTINUE
!
!      do i=1,n
!         do j=1,n
!!            a(i,j)=ifix(sngl(b(i,j)**2*1.d4))
!            a(i,j)=int((b(i,j)**2*1.d5))
!         enddo
!      enddo
!
!      DO I=1,N
!!        print*, (a(I,J),J=1,N)
!      enddo
!
!!     ----------------------
!
!      do i=1,n
!         do j=1,n
!            a(i,j)=-1*a(i,j)
!         enddo
!      enddo


!      CALL APC(N,A,F,Z)
!      WRITE(6,30) Z
!   30 FORMAT(26H  COST OF THE ASSIGNMENT =,I10/)
!      WRITE(6,40) (F(I),I=1,N)
!   40 FORMAT(11H ASSIGNMENT,20I4)
!
!      do i=1,n
!         print*,i,b(i,f(i))
!      enddo
!

!
!      STOP
!      END
      SUBROUTINE APC(N,A,F,Z)
!
! SOLUTION OF THE LINEAR MIN-SUM ASSIGNMENT PROBLEM.
!
! HUNGARIAN METHOD. COMPLEXITY O(N**3).
!
!
! MEANING OF THE INPUT PARAMETERS:
! N      = NUMBER OF ROWS AND COLUMNS OF THE COST MATRIX.
! A(I,J) = COST OF THE ASSIGNMENT OF ROW  I  TO COLUMN  J .
! ON RETURN, THE INPUT PARAMETERS ARE UNCHANGED.
!
! MEANING OF THE OUTPUT PARAMETERS:
! F(I) = COLUMN ASSIGNED TO ROW  I .
! Z    = COST OF THE OPTIMAL ASSIGNMENT =
!      = A(1,F(1)) + A(2,F(2)) + ... + A(N,F(N)) .
!
! ALL THE PARAMETERS ARE INTEGERS.
! VECTOR  F  MUST BE DIMENSIONED AT LEAST AT  N , MATRIX  A
! AT LEAST AT  (N,N) . AS CURRENTLY DIMENSIONED, THE SIZE
! LIMITATION IS  N .LE. 260 . IN ALL THE SUBROUTINES, THE
! INTERNAL VARIABLES WHICH ARE PRESENTLY DIMENSIONED AT
! 260 MUST BE DIMENSIONED AT LEAST AT  N .
!
! THE ONLY MACHINE-DEPENDENT CONSTANT USED IS  INF (DEFINED
! BY THE FIRST EXECUTABLE STATEMENT OF THIS SUBROUTINE). INF
! MUST BE SET TO A VERY LARGE INTEGER VALUE.
!
! THE CODE IS BASED ON THE HUNGARIAN METHOD AS DESCRIBED BY
! LAWLER (COMBINATORIAL OPTIMIZATION : NETWORKS AND
! MATROIDS, HOLT, RINEHART AND WINSTON, NEW YORK, 1976).
! THE ALGORITHMIC PASCAL-LIKE DESCRIPTION OF THE CODE IS
! GIVEN IN G.CARPANETO, S.MARTELLO AND P.TOTH, ALGORITHMS AND
! CODES FOR THE ASSIGNMENT PROBLEM, ANNALS OF OPERATIONS
! RESEARCH 7, 1988.
!
! SUBROUTINE APC DETERMINES THE INITIAL DUAL AND PARTIAL
! PRIMAL SOLUTIONS AND THEN SEARCHES FOR AUGMENTING PATHS
! UNTIL ALL ROWS AND COLUMNS ARE ASSIGNED.
!
! MEANING OF THE MAIN INTERNAL VARIABLES:
! FB(J) = ROW ASSIGNED TO COLUMN  J .
! M     = NUMBER OF INITIAL ASSIGNMENTS.
! U(I)  = DUAL VARIABLE ASSOCIATED WITH ROW  I .
! V(J)  = DUAL VARIABLE ASSOCIATED WITH COLUMN  J .
!
! APC NEEDS THE FOLLOWING SUBROUTINES: INCR
!                                      INIT
!                                      PATH
!
! ALL THE SUBROUTINES ARE WRITTEN IN AMERICAN NATIONAL
! STANDARD FORTRAN AND ARE ACCEPTED BY THE PFORT VERIFIER.
!
!
! THIS WORK WAS SUPPORTED BY  C.N.R. , ITALY.
!
      parameter (Nmax=3000) 
      INTEGER A(Nmax,Nmax),F(Nmax),Z
      INTEGER U,V,FB
      COMMON U(Nmax),V(Nmax),FB(Nmax)
      INF = 10**9
! SEARCH FOR THE INITIAL DUAL AND PARTIAL PRIMAL SOLUTIONS.
      CALL INIT(N,A,F,M,INF)
      IF ( M .EQ. N ) GO TO 20
! SOLUTION OF THE REDUCED PROBLEM.
      DO 10 I=1,N
        IF ( F(I) .GT. 0 ) GO TO 10
! DETERMINATION OF AN AUGMENTING PATH STARTING FROM ROW  I .
        CALL PATH(N,A,I,F,INF,J)
! ASSIGNMENT OF ROW  I  AND COLUMN  J .
        CALL INCR(F,J)
   10 CONTINUE
! COMPUTATION OF THE SOLUTION COST  Z .
   20 Z = 0
      DO 30 K=1,N
        Z = Z + U(K) + V(K)
   30 CONTINUE
      RETURN
      END
      SUBROUTINE INCR(F,J)
!
! ASSIGNMENT OF COLUMN  J .
!
      parameter (Nmax=3000)
      INTEGER F(Nmax)
      INTEGER U,V,FB,RC
      COMMON U(Nmax),V(Nmax),FB(Nmax),RC(Nmax)
   10 I = RC(J)
      FB(J) = I
      JJ = F(I)
      F(I) = J
      J = JJ
      IF ( J .GT. 0 ) GO TO 10
      RETURN
      END
      SUBROUTINE INIT(N,A,F,M,INF)
!
! SEARCH FOR THE INITIAL DUAL AND PARTIAL PRIMAL SOLUTIONS.
!
! P(I) = FIRST UNSCANNED COLUMN OF ROW  I .
!
      parameter (Nmax=3000)
      INTEGER A(Nmax,Nmax),F(Nmax)
      INTEGER U,V,FB,P,R
      COMMON U(Nmax),V(Nmax),FB(Nmax),P(Nmax)
! PHASE 1 .
      M = 0
      DO 10 K=1,N
        F(K) = 0
        FB(K) = 0
   10 CONTINUE
! SCANNING OF THE COLUMNS ( INITIALIZATION OF  V(J) ).
      DO 40 J=1,N
        MIN = INF
        DO 30 I=1,N
          IA = A(I,J)
          IF ( IA .GT. MIN ) GO TO 30
          IF ( IA .LT. MIN ) GO TO 20
          IF ( F(I) .NE. 0 ) GO TO 30
   20     MIN = IA
          R = I
   30   CONTINUE
        V(J) = MIN
        IF ( F(R) .NE. 0 ) GO TO 40
! ASSIGNMENT OF COLUMN  J  TO ROW  R .
        M = M + 1
        FB(J) = R
        F(R) = J
        U(R) = 0
        P(R) = J + 1
   40 CONTINUE
! PHASE 2 .
! SCANNING OF THE UNASSIGNED ROWS ( UPDATING OF  U(I) ).
      DO 110 I=1,N
        IF ( F(I) .NE. 0 ) GO TO 110
        MIN = INF
        DO 60 K=1,N
          IA = A(I,K) - V(K)
          IF ( IA .GT. MIN ) GO TO 60
          IF ( IA .LT. MIN ) GO TO 50
          IF ( FB(K) .NE. 0 ) GO TO 60
          IF ( FB(J) .EQ. 0 ) GO TO 60
   50     MIN = IA
          J = K
   60   CONTINUE
        U(I) = MIN
        JMIN = J
        IF ( FB(J) .EQ. 0 ) GO TO 100
        DO 80 J=JMIN,N
          IF ( A(I,J) - V(J) .GT. MIN ) GO TO 80
          R = FB(J)
          KK = P(R)
          IF ( KK .GT. N ) GO TO 80
          DO 70 K=KK,N
            IF ( FB(K) .GT. 0 ) GO TO 70
            IF ( A(R,K) - U(R) - V(K) .EQ. 0 ) GO TO 90
   70     CONTINUE
          P(R) = N + 1
   80   CONTINUE
        GO TO 110
! REASSIGNMENT OF ROW  R  AND COLUMN  K .
   90   F(R) = K
        FB(K) = R
        P(R) = K + 1
! ASSIGNMENT OF COLUMN  J  TO ROW  I .
  100   M = M + 1
        F(I) = J
        FB(J)= I
        P(I) = J + 1
  110 CONTINUE
      RETURN
      END
      SUBROUTINE PATH(N,A,II,F,INF,JJ)
!
! DETERMINATION OF AN AUGMENTING PATH STARTING FROM
! UNASSIGNED ROW  II  AND TERMINATING AT UNASSIGNED COLUMN
! JJ , WITH UPDATING OF DUAL VARIABLES  U(I)  AND  V(J) .
!
! MEANING OF THE MAIN INTERNAL VARIABLES:
! LR(L) = L-TH LABELLED ROW ( L=1,NLR ).
! PI(J) = MIN ( A(I,J) - U(I) - V(J) , SUCH THAT ROW  I  IS
!         LABELLED AND NOT EQUAL TO  FB(J) ).
! RC(J) = ROW PRECEDING COLUMN  J  IN THE CURRENT
!         ALTERNATING PATH.
! UC(L) = L-TH UNLABELLED COLUMN ( L=1,NUC ).
!
      parameter (Nmax=3000)
      INTEGER A(Nmax,Nmax),F(Nmax),Z
      INTEGER PI(Nmax),LR(Nmax),UC(Nmax)
      INTEGER U,V,FB,RC,R
      COMMON U(Nmax),V(Nmax),FB(Nmax),RC(Nmax)
! INITIALIZATION.
      LR(1) = II
      DO 10 K=1,N
        PI(K) = A(II,K) - U(II) - V(K)
        RC(K) = II
        UC(K) = K
   10 CONTINUE
      NUC = N
      NLR = 1
      GO TO 40
! SCANNING OF THE LABELLED ROWS.
   20 R = LR(NLR)
      DO 30 L=1,NUC
        J = UC(L)
        IA = A(R,J) - U(R) - V(J)
        IF ( IA .GE. PI(J) ) GO TO 30
        PI(J) = IA
        RC(J) = R
   30 CONTINUE
! SEARCH FOR A ZERO ELEMENT IN AN UNLABELLED COLUMN.
   40 DO 50 L=1,NUC
        J = UC(L)
        IF ( PI(J) .EQ. 0 ) GO TO 100
   50 CONTINUE
! UPDATING OF THE DUAL VARIABLES  U(I)  AND  V(J) .
      MIN = INF
      DO 60 L=1,NUC
        J = UC(L)
        IF ( MIN .GT. PI(J) ) MIN = PI(J)
   60 CONTINUE
      DO 70 L=1,NLR
        R = LR(L)
        U(R) = U(R) + MIN
   70 CONTINUE
      DO 90 J=1,N
        IF ( PI(J) .EQ. 0 ) GO TO 80
        PI(J) = PI(J) - MIN
        GO TO 90
   80   V(J) = V(J) - MIN
   90 CONTINUE
      GO TO 40
  100 IF ( FB(J) .EQ. 0 ) GO TO 110
! LABELLING OF ROW  FB(J)  AND REMOVAL OF THE LABEL  OF
! COLUMN  J .
      NLR = NLR + 1
      LR(NLR) = FB(J)
      UC(L) = UC(NUC)
      NUC = NUC - 1
      GO TO 20
! DETERMINATION OF THE UNASSIGNED COLUMN  J .
  110 JJ = J
      RETURN
      END
 
