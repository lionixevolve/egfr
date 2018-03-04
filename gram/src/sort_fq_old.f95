program sorter 
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
character*20 infile_1, infile_2, infile_3, infile_4, infile_6
character*20 infile_5, outfile_1, outfile_2, outfile_3, tresnc, tresn2c, pnumc
character*20 outfile_4, infile_7
integer i, j, k, t, m, flag, flag2, ierr, site(100)
integer bfx, bfy, bfz, tresn, pnum, tresn2
integer, parameter :: ndatmax=3000
integer, parameter :: max_mod=3000

integer nsub(ndatmax), nsub1(ndatmax), nsub2(ndatmax)
double precision frequ(max_mod), frequ2(max_mod)
integer ndat, ndat2, pnumber, nmod,iflag,ldx,iexp, pnumber2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo reordena su input nro 1,
! de largo input nro 2,
! según input nro 3
! y escribe el rtdo en input nro 4
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=0
t=0
m=0
pnumber=1  ! Si infiles 6 y 7 son "none" entonces pnumber1 y pnumber2 toman los
pnumber2=1  ! valores tresn y tresn2, respectivamente

call getarg (1, infile_1)!        frecuencias input
call getarg (2, infile_2)!        nsub file con el orden correcto 
call getarg (3, tresnc)! 	  nro de modos
read(tresnc, *) tresn
call getarg (4, outfile_1)!       frecuencias ordenadas


!!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (11, file=infile_1)
do i=1, 7!					leo frecuencias. Las 1eras 7 lineas no impo
        read(11,*) 
enddo
do i=1, tresn
	read(11, *) frequ(i)
enddo
close(11)
!!!!

open (12, file=infile_2)
do i=1, tresn
        read(12, *) nsub1(i), nsub(i)
enddo
close(12)

!!!!
!listo, ahora lo escrbie
open (21, file=outfile_1)
do i=1, 7!                                     escribo frecuencias. Las 1eras 7 lineas no impo
    write(21, *) i
enddo
do i=1, tresn
    write(21, *) frequ(nsub(i))
enddo
close(21)

  
92      format(3x,E23.15)
93      format(1i3)
94      format(1i3,1x,1x,1x,1i6)
      
end program sorter 
