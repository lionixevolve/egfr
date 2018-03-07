program checker
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: ndatmax=3000
integer, parameter :: max_mod=3000
character*30 infile_1, infile_2, outfile_1, tresnc
integer i, j, k, t, m, flag, ierr, tresn, modo(max_mod)

integer repe(max_mod), nsub(max_mod), archivo(max_mod)
double precision mods(max_mod, max_mod)
double precision bf_frac(max_mod), bf_add(max_mod), frequ(max_mod), bf_sub(max_mod)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=0
t=0
m=0
call getarg (1, infile_1)!       lista de archivos con bfactors 
call getarg (2, infile_2)!
call getarg (3, tresnc)! 	  numero de bfactors
read(tresnc, *) tresn
call getarg (4, outfile_1)!       salida con promedio de ponderacion

open (11, file=infile_1)
open (12, file=infile_2)
!!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do i=1, 7!                                      leo frecuencias del 1er subspace. Las 1eras 7 lineas no impo
	read(11,*)
enddo
do i=1, tresn
	read(11, 93) bf_frac(i)
enddo 
do i=1, tresn
        read(12, 91, iostat= ierr) archivo(i), nsub(i)
        if ( ierr/= 0 ) exit
enddo
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (21, file=outfile_1)
do i=1, 7!                                      leo frecuencias del 1er subspace. Las 1eras 7 lineas no impo
       write(21,*) i
enddo

do i=1, tresn
  	write(21,93) bf_frac(nsub(i))
enddo


close(11)
close(12)
close(21)

  
91      format(1i12,1i12)
92      format(1i3,1x,1x,1x,F9.6)
93      format(1x,E24.15)
94      format(1x,f9.6)
      
end program checker
