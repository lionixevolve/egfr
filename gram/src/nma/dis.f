      IMPLICIT NONE

      integer readstring, str_lth
      integer i,slen,flen,long,j,k,m
      integer icont
      character*1000 card, line(100)
      character*80 outfile, infile
      character*5 str_lthc
      icont=0

      call getarg(1, infile)
      call getarg(2, outfile)

!      open(50,file='pdsulf')!				aca escribe las lineas del pdb q corresponden a las cys
      open(11, file=infile)
!      open(10,file='dim-pdsulf')!			aca escribia el nro de ptes diS, pero ya no lo hace mas
      do while (readstring(11,card,slen).ge.0 )
         long=slen
         if(card(1:4).eq.'ATOM') then
          if(card(18:20).eq.'CYS') then
           if(card(14:14).eq.'S') then
!            write(50,111) card(1:66)
            icont=icont+1
            line(icont)=card
!            write (6,*) card
!            write (6,*) line(icont)
           endif
          endif
         endif
      enddo
c      write(10,*) icont
!      close (50)
      close (11)

      call calculo(icont, outfile, line)

111   FORMAT(A66)
c112   FORMAT(I4)
      stop
      end

c------ SUBROUTINE CALCULO

      subroutine calculo(icont, outfile, line)

      integer ifail,ii
      integer i,j,icont,slen,flen,long,icontmax
      parameter (icontmax=1000)
*      integer icont3
      double precision r1(icontmax,3)
      double precision xx(icontmax),bfactor(icontmax)
      double precision s(icontmax,icontmax),ss(icontmax,icontmax)
      double precision dis
      character*6 BB(icontmax)
      integer NN(icontmax)
      character*5 BBB(icontmax)
      character*3 BBBB(icontmax)
      character*80 outfile
      character*1000 card, line(100)
c      character*2 BBBBB(icontmax)
      integer NNN(icontmax)
      integer a(icontmax),ann,aw

!      OPEN(50, FILE='pdsulf')
     
      do i=1,icont
      read(line(i),112) BB(i),NN(i),BBB(i),BBBB(i),NNN(i),r1(i,1)
     $,r1(i,2),r1(i,3),xx(i),bfactor(i)
c      write(11,*) r1(i,1),r1(i,2),r1(i,3)
      enddo

!      OPEN(54, FILE='primernumero')
!      read(54,115) ann
      ann=1
      aw=-ann+1
      if(NNN(1).ne.1) then
      do i=1,icont
          a(i)=NNN(i)+aw
c          b(i)=b(i)+aw
      enddo
      else
      endif


      OPEN(51,file=outfile)!				aca escribe las cys q estan haciendo ptes
c*      OPEN(58,file='dim3') 

      dis=3.10     
      do i=1,icont
       do j=i+1,icont
         s(i,j)=dsqrt((r1(i,1)-r1(j,1))**2+(r1(i,2)-r1(j,2))**2
     $+(r1(i,3)-r1(j,3))**2)
!         write(57,114) a(i),a(j),NNN(i),NNN(j),s(i,j)
           if(s(i,j).le.dis) then
            if(a(i).ne.a(j)) then
              ss(i,j)=s(i,j)
c*            icont3=icont3+1
!              write(56,114) a(i),a(j),NNN(i),NNN(j),ss(i,j)
              write(51,122) a(i),a(j)
!              write(51,120) a(j),a(i) 
            endif
           endif
c       write(12,113) i,j,NNN(i),NNN(j),s(i,j)
       enddo
      enddo
c*      write(58,121) '      parameter(icont3=',icont3,')'


c      close(50)
      close(51)

c|ATOM   5143  SG  CYS   103       3.660  43.320 -23.624  1.00 13.41
c|ATOM   6925  SG  CYS   291      12.447   9.201 -19.541  1.00 29.91
c|ATOM   7298  SG  CYS   328       7.673  24.415  -4.506  1.00 15.88
c|ATOM   7447  SG  CYS   344      28.259  17.170  -9.445  1.00 21.46
112   FORMAT(A6,I5,1x,A5,A3,2x,I4,4x,3(F8.3),1x,F5.2,F6.2)
113   FORMAT(I3,1x,I3,1x,I4,1x,I4,F8.4)
114   FORMAT(I4,1x,I4,1x,I4,1x,I4,1x,F5.2)
115   FORMAT(I4)
120   FORMAT(2(1x,I4))
122   FORMAT(2i5,2i5)
121   FORMAT(A23,I4,A1)
      return
      end


c------ SUBROUTINES

      integer function readstring(file,card,flen)
      integer       file, flen
      character*1000 card
      if(file.gt.200)STOP'ERROR: file number too large'
      read(file,'(a)',err=100,end=100)card
      flen=1000
      do while(card(flen:flen).eq.' ')
         flen=flen-1
      enddo
      readstring=flen
      return
 100  readstring=-1

      return
      end

