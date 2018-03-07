program ponderer
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)

character*20 infile_1, infile_2, infile_3, outfile_1, tresnc 
integer i, j, k, t, m, flag, flag2, ierr, site(100)
integer bfx, bfy, bfz, tresn, pnum, tresn2
integer, parameter :: ndatmax=3000
integer, parameter :: max_mod=3000

double precision frequ(max_mod), temp(max_mod), norm(max_mod), norm_pond(max_mod)
double precision bf(max_mod), bf_tot(max_mod), bf_frac(max_mod, max_mod)
double precision tempx(max_mod), tempy(max_mod), tempz(max_mod)
double precision bf_mode(max_mod), mode_pond(max_mod)
double precision bf_mode_tot, bf_mode_sort(max_mod), mode_pond2(max_mod)

integer ndat, ndat2, nmod,iflag,ldx,iexp
double precision modos(ndatmax,ndatmax)
integer ifail
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo agarra el 1er set de modos y obtiene el bfactor total de un site 
!sumando los bfactors de los Calphas. Luego define el aporte a ese bftor total q 
!en el input 6 y otro con 2 columnas, la 1era tiene el nro de modo y la 2da, su aporte al 
!bftor total del site. Hace lo mismo con el 2do set de modos. 
!En esta version del codigo, tengo en cuenta todos los modos, no solamente los q tuvieron
!una repe de 1 o mas.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=0
t=0
m=0
call getarg (1, infile_1)!        1er subespacio
call getarg (2, infile_2)!        las frecuencias del 1er subespacio
call getarg (3, infile_3)!        el site prioritario
call getarg (4, tresnc)! 	  nro de modos-6
read(tresnc, *) tresn
ndat=tresn+6
call getarg (5, outfile_1)!      modos+aporte a bf del 1er subespacio reducido

!!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (11, file=infile_1)
do i=1, tresn+6!                          leo el 1er set de modos
	read(11,91) (modos(i,j),j=1, tresn)
enddo
close(11)
!
open (12, file=infile_2)
do i=1, 7!					leo frecuencias del 1er subspace. Las 1eras 7 lineas no impo
        read(12,*) 
enddo
do i=1, tresn
	read(12,92) frequ(i)
enddo
close(12)
!!!!!!!!
open (13, file=infile_3)
do !						leo los nros de los aa's prioritarios
	m = m+1
	read(13, 93, iostat= ierr) site(m)
        if ( ierr/= 0 ) exit
enddo
m= m - 1
close(13)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!! determina ponderacion de cada modo !!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
  !1er set de modos: 
  do i=1, m
         bf_tot(i)=0
         do k=1, tresn
         	bfx= 3*site(i)-2
         	bfy= 3*site(i)-1
         	bfz= 3*site(i)
         	tempx(k)=(modos(bfx, k)**2) / frequ(k)
         	tempy(k)=(modos(bfy, k)**2) / frequ(k)
         	tempz(k)=(modos(bfz, k)**2) / frequ(k)
         	temp(k)= tempx(k) + tempy(k) + tempz(k)
         	bf_tot(i)= bf_tot(i) + temp(k)!		aca obtengo el bfactor del aa
          enddo      
  
          do k=1, tresn
         		bf_frac(i,k)= temp(k) / bf_tot(i)!	aca obtengo el aporte de c/ modo al bfactor del aa
  	enddo
   enddo


  bf_mode_tot=0
  do k=1, tresn!			voy modo por modo
  	bf_mode(k)=0
  	do i=1, m
  		bf_mode(k)=  bf_mode(k) +  bf_frac(i,k)!	y sumo el bfactor q hace en c/ aa (del pocket) "j". bf_mode va a 
  	enddo!									ser usado p/ la ponderacion
  	bf_mode_tot= bf_mode(k) + bf_mode_tot	!			obtengo el total de bfactor q hay en el pocket, debido a los pnum modos
  enddo!									
  do k=1, tresn
  	bf_mode(k)= bf_mode(k) / bf_mode_tot!			obtengo la fraccion de bftor q aporta c/ modo al total de bftor del pocket
  enddo

    
  open (23, file=outfile_1)
  !listo, ahora lo escribe
  do k=1, tresn
  	write(23,96) k, bf_mode(k)
  enddo
  close(23)

 
91      format(10000(1x,F9.6))
92      format(1x,E24.15)
93      format(1i3)
94      format(500(i10))
95      format(1i3,1x,1x,1x,1i6)
96      format(1i3,1x,1x,1x,F9.6)
      
end program ponderer
