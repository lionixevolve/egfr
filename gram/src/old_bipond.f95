program ponderer
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

integer pmod(max_mod), pmod2(max_mod)
integer nsub(ndatmax), nsub1(ndatmax), nsub2(ndatmax)
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

integer ndat, ndat2, pnumber, nmod,iflag,ldx,iexp, pnumber2
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
! este codigo agarra el 1er set de modos y obtiene el bfactor total de un site 
!sumando los bfactors de los Calphas. Luego define el aporte a ese bftor total q 
!hace c/ modo especificado. Termina escribiendo 2 archivos. Uno con los modos especificados
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
pnumber=1  ! Si infiles 6 y 7 son "none" entonces pnumber1 y pnumber2 toman los
pnumber2=1  ! valores tresn y tresn2, respectivamente

call getarg (1, infile_1)!        1er subespacio
call getarg (2, infile_2)!        las frecuencias del 1er subespacio
call getarg (3, infile_3)!        2do subespacio
call getarg (4, infile_4)!        las frecuencias del 2do subespacio
call getarg (5, infile_5)!        el site prioritario
call getarg (6, infile_6)!        el archivo con los modos q hay q agarrar del 1er subspace. Puede ser none
call getarg (7, infile_7)!        el archivo con los modos q hay q agarrar del 2do subspace. Puede ser none
call getarg (8, tresnc)! 	  nro de modos-6
read(tresnc, *) tresn
ndat=tresn+6
call getarg (9, tresn2c)! 	  nro de modos-6
read(tresnc, *) tresn2
ndat2=tresn2+6
call getarg (10, outfile_1)!       1er subespacio reducido
call getarg (11, outfile_2)!       2do subespacio reducido
call getarg (12, outfile_3)!      modos+aporte a bf del 1er subespacio reducido
call getarg (13, outfile_4)!      modos+aporte a bf del 2do subespacio reducido


!!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (11, file=infile_1)
do i=1, tresn+6!                          leo el 1er set de modos
	read(11,91) (modos(i,j),j=1, tresn)
enddo
close(11)

open (12, file=infile_2)
do i=1, 7!					leo frecuencias del 1er subspace. Las 1eras 7 lineas no impo
        read(12,*) 
enddo
do i=1, tresn
	read(12,92) frequ(i)
enddo
close(12)
!!!!

open (13, file=infile_3)
do i=1, tresn+6!                          leo el 2do set de modos
	read(13,91) (modosp(i,j),j=1, tresn)
enddo
close(13)

open (14, file=infile_4)
do i=1, 7!					leo el archivo de frecuencias. Las 1eras 7 lineas no impo
        read(14,*) 
enddo
do i=1, tresn2
	read(14,92) frequ2(i)
enddo
close(14)

!!!!!!!!
open (15, file=infile_5)
do !						leo los nros de los aa's prioritarios
	m = m+1
	read(15, 93, iostat= ierr) site(m)
        if ( ierr/= 0 ) exit
enddo
close(15)
m= m - 1
!!!!!!!!
if ( infile_6 /= 'none' ) then
    open (16, file=infile_6)
    do!                                   leo numeros de modos q importan del 1er subspace
    	read(16,95, iostat=ierr) nsub(pnumber), repe(pnumber)
            if ( ierr/= 0 ) exit
    !        if ( repe(pnumber) /= 0) pnumber= pnumber + 1!		de esta manera no tengo en cuenta los q tienen repe=0
    	pnumber= pnumber + 1!					de esta manera tengo en cuenta a todos los modos
    enddo
    close(16)
    pnumber= pnumber - 1
else
    pnumber = tresn
    do i = 1, pnumber
        nsub(i) = i
    enddo
endif
!!!
if ( infile_7 /= 'none' ) then
    open (17, file=infile_7)
    do!                                   leo numeros de modos q importan del 2do subspace
    	read(17,95, iostat=ierr) nsub2(pnumber2), repe(pnumber2)
            if ( ierr/= 0 ) exit
    !        if ( repe(pnumber2) /= 0) pnumber2= pnumber2 + 1!	de esta manera no tengo en cuenta los q tienen repe=0
    	pnumber2 = pnumber2 + 1!				de esta manera tengo en cuenta a todos los modos
    enddo
    close(17)
    pnumber2 = pnumber2 - 1
else
    pnumber2 = tresn2
    do i = 1, pnumber2
        nsub2(i) = i
    enddo
endif

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!! determina subespacios reducidos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! determina el 1er subespacio reducido
do j=1,ndat
	do i=1,pnumber
		modos2(j,i)=modos(j,nsub(i))!                   
	enddo 
enddo!     
! determina el 2do subespacio reducido
do j=1,ndat2
	do i=1,pnumber2
		modosp2(j,i)=modosp(j,nsub2(i))!                   
	enddo 
enddo!     

!!!!!!!!!!!!!!!!!!!!!!!!!!! grabo los subespacios reducidos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!	en esta version del codigo no reduzco espacios, asi q no grabo esto
!
!open(21, FILE=outfile_1)
!do j=1,ndat
!	write(21,91) (modos2(j,i),i=1,pnumber)
!enddo
!close(21)
!open(22, FILE=outfile_2)
!do j=1,ndat2
!	write(22,91) (modosp2(j,i),i=1,pnumber2)
!enddo
!close(22)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!! determina ponderacion de cada modo !!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
  !1er set de modos: 
  do i=1, m
         bf_tot(i)=0
         do k=1, pnumber
         	bfx= 3*site(i)-2
         	bfy= 3*site(i)-1
         	bfz= 3*site(i)
         	tempx(k)=(modos2(bfx, k)**2) / frequ(k)
         	tempy(k)=(modos2(bfy, k)**2) / frequ(k)
         	tempz(k)=(modos2(bfz, k)**2) / frequ(k)
         	temp(k)= tempx(k) + tempy(k) + tempz(k)
         	bf_tot(i)= bf_tot(i) + temp(k)!		aca obtengo el bfactor del aa
          enddo      
  
          do k=1, pnumber
         		bf_frac(i,k)= temp(k) / bf_tot(i)!	aca obtengo el aporte de c/ modo al bfactor del aa
  	enddo
   enddo

  bf_mode_tot=0
  do k=1, pnumber!			voy modo por modo
  	bf_mode(k)=0
  	do i=1, m
  		bf_mode(k)=  bf_mode(k) +  bf_frac(i,k)!	y sumo el bfactor q hace en c/ aa (del pocket) "j". bf_mode va a 
  	enddo!									ser usado p/ la ponderacion
  	bf_mode_tot= bf_mode(k) + bf_mode_tot	!			obtengo el total de bfactor q hay en el pocket, debido a los pnum modos
  enddo!									
  do k=1, pnumber
  	bf_mode(k)= bf_mode(k) / bf_mode_tot!			obtengo la fraccion de bftor q aporta c/ modo al total de bftor del pocket
  !	bf_mode_sort(k)= bf_mode(k)
  enddo

  !listo, ahora lo escribe
open (23, file=outfile_3)
do k=1, pnumber
    write(23,96) k, bf_mode(k)
enddo
close(23)

  !2do set de modos
do i=1, m
	bf_tot(i)=0
	do k=1, pnumber2
		bfx= 3*site(i) - 2
		bfy= 3*site(i) - 1
		bfz= 3*site(i)
		tempx(k)=(modosp2(bfx, k)**2) / frequ2(k)
		tempy(k)=(modosp2(bfy, k)**2) / frequ2(k)
		tempz(k)=(modosp2(bfz, k)**2) / frequ2(k)
		temp(k)= tempx(k) + tempy(k) + tempz(k)
		bf_tot(i)= bf_tot(i) + temp(k)!		aca obtengo el bfactor del aa
	enddo	
	do k=1, pnumber2
		bf_frac(i,k)= temp(k) / bf_tot(i)!	aca obtengo el aporte de c/ modo al bfactor del aa
	enddo
enddo

bf_mode_tot=0
do k=1, pnumber2!			voy modo por modo
		bf_mode(k)=0
		do i=1, m
			bf_mode(k)=  bf_mode(k) +  bf_frac(i,k)!	y sumo el bfactor q hace en c/ aa (del pocket) "j". bf_mode va a 
  	enddo!									ser usado p/ la ponderacion
	bf_mode_tot= bf_mode(k) + bf_mode_tot	!			obtengo el total de bfactor q hay en el pocket, debido a los pnum modos
enddo!									
do k=1, pnumber2
	bf_mode(k)= bf_mode(k) / bf_mode_tot!			obtengo la fraccion de bftor q aporta c/ modo al total de bftor del pocket
enddo

!listo, ahora lo escrbie
open (24, file=outfile_4)
do k=1, pnumber2
    write(24,96) k, bf_mode(k)
enddo
close(24)

  
91      format(10000(1x,F9.6))
92      format(3x,E23.15)
!92      format(1x,E24.15)
93      format(1i3)
94      format(500(i10))
95      format(1i3,1x,1x,1x,1i6)
96      format(1i3,1x,1x,1x,F9.6)
      
end program ponderer
