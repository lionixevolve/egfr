program msfer 
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: max_mod=1000
!parameter (cte1 = 1d000001)
character*20 infile_1, infile_2, infile_3, outfile_1, outfile_2, tresnc, outfile(max_mod), sitec
integer i, j, k, t, m, flag, ierr, site(100), bfx, bfy, bfz, indice(max_mod, max_mod), pnumber(max_mod), promi
integer modo(max_mod, max_mod), tresn, larger, larger_idx, flag2, flag3, add
double precision mods(max_mod, max_mod), freq(max_mod), pn2(max_mod), pn1(max_mod), sf(max_mod, max_mod)
double precision sfx(max_mod, max_mod), sfy(max_mod, max_mod), sfz(max_mod, max_mod), temp(max_mod)
double precision msf(max_mod, max_mod), sf_top(max_mod), tempx(max_mod), tempy(max_mod), tempz(max_mod)
double precision bf(max_mod), bf_tot(max_mod), bf_frac(max_mod), bu(max_mod), cte, tempo, suma, prom
double precision subsp(max_mod, max_mod)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo determina subespacios 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=0
t=0
m=0


call getarg (1, infile_1)!	los modos 
call getarg (2, infile_2)! 	las frecuencias
call getarg (3, infile_3)! 	el site p/ el q se va a determinar los subespacios
call getarg (4, tresnc)!	nro de modos-6
read(tresnc, *) tresn
call getarg (5, outfile_1)!	archivo con pnumber y los numeros de los 'pnumbers' modos de c/ aa
call getarg (6, outfile_2)!	archivo con el subespacio relevante total

open (11, file=infile_1)
open (12, file=infile_2)
open (13, file=infile_3)
open (21, file=outfile_1)
!!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

do i=1, tresn+6
	read(11,91) (mods(i,j),j=1, tresn)
enddo

do i=1, 7
        read(12,*) 
enddo
do i=1, tresn
	read(12,92) freq(i)
enddo
do 
	m = m+1
	read(13, 93, iostat= ierr) site(m)
        if ( ierr/= 0 ) exit
enddo
m= m-1

do i=1, m!					aca abro los archivos de salida q van a contener a los 
	if ( site(i) .le. 999 ) then!		pnumber modos esenciales de c/ aa del site
		write(sitec, '(i3)') site(i)
		outfile(i)='subspace'
		outfile(i)(9:11)=sitec
	endif
	if ( site(i) .le. 99 ) then
		write(sitec, '(i2)') site(i)
		outfile(i)='subspace'
		outfile(i)(9:10)=sitec
	endif
	if ( site(i) .le. 9 ) then
		write(sitec, '(i1)') site(i)
		outfile(i)='subspace'
		outfile(i)(9:9)=sitec
	endif

	open(i+21, file=outfile(i))
enddo
open(m+21+1, file=outfile_2)
suma=0
larger=1
!!!!!!!!!!!!!!!!!!!!!!!!!!!! determina subespacios esenciales !!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!! de c/ aa del pocket              !!!!!!!!!!!!!!!!!!!!!!!!!!!!
do i=1, m
	sf_top(i)=0
	pn1(i)=0
	bf_tot(i)=0
	do k=1, tresn
		bfx= 3*site(i)-2
		bfy= 3*site(i)-1
		bfz= 3*site(i)
		tempx(k)=(mods(bfx, k)**2) / freq(k)
		tempy(k)=(mods(bfy, k)**2) / freq(k)
		tempz(k)=(mods(bfz, k)**2) / freq(k)
		temp(k)= tempx(k) + tempy(k) + tempz(k)
		bf_tot(i)= bf_tot(i) + temp(k)!		aca obtengo el bfactor del aa
	enddo

	
	do k=1, tresn
		bf_frac(k)= temp(k) / bf_tot(i)!	aca obtengo el aporte de c/ modo al bfactor del modo
		bu(k)= bf_frac(k)!			backupea la variable, p/ despues poder detectar los nros de los modos
		pn1(i)= pn1(i) + bf_frac(k)**2!		q mas aportan al bfactor
		pn2(i)= 1 / pn1(i)!			con estas 2 √ltimas l√neas obtengo el pnum de modos p/ este aa
	enddo
	call hpsort(tresn, bf_frac)!		ordeno en sentido creciente

	do j=1, tresn! 				uso este ciclo p/ identificar los modos q se corresponden a los mayores
!	aportes al bfactor. Si usara un lenguaje de verdad, no tendria q hacer esta estupidez
		if ( bu(j) < 1d-0) cte=1d-6
		if ( bu(j) < 1d-1) cte=1d-7
		if ( bu(j) < 1d-2) cte=1d-8
		if ( bu(j) < 2d-3) cte=2d-9
		if ( bu(j) < 1.5d-3) cte=1.5d-9
		if ( bu(j) < 1d-3) cte=1d-9
		if ( bu(j) < 5d-4) cte=5d-10
		if ( bu(j) < 1d-4) cte=1d-10
		if ( bu(j) < 5d-4) cte=5d-10
		if ( bu(j) < 1d-5) cte=1d-11
		if ( bu(j) < 3d-5) cte=3d-11
		if ( bu(j) < 1d-6) cte=1d-12
		if ( bu(j) < 1d-7) cte=1d-13
		flag=0
		do k=1, tresn
			tempo= abs(bu(j) - bf_frac(k))!	hago esto pq 'hpsort' cambia un toque los valores
			if ( tempo <= cte ) then
!				write (*,*) bu(j), bf_frac(k), j, k
				indice(i,k)= j!		ej: indice(2,5) tiene el nro de modo q es el 5to q mas aporta al bftor
				flag=1!			del 2do aa del site
				exit
			endif
		enddo
		if ( flag == 0 ) write (77,*) j, bu(j), cte! error!
	enddo
	pnumber(i)=int(pn2(i))
	if ((pn2(i) - pnumber(i)).gt.0.5d0) pnumber(i)= pnumber(i) + 1! con estas 2 ultimas lineas hago entero el pnumber

	if ( pnumber(i) .gt. larger ) then!		aca aprovecho p/ identificar el aa q tiene el subespacio
		larger= pnumber(i)!				mas gde
		larger_idx= i
	endif

	do j=1, tresn!				en este ciclo reordeno los modos p/ q vayan en sentido decreciente
		modo(i,j)= indice(i,tresn + 1 - j)

!		write (*,*) modo(i,j)
!		write (*,*) indice(i,j)

	enddo

	write (21, 94) pnumber(i), (modo(i,j), j=1, pnumber(i))!	aca escribo el nro de pnumber y los pnumber modos
	suma= suma + pn2(i)

	do j=1, pnumber(i)
		do k=1, pnumber(i)
			if ( j == k ) cycle
			if ( modo(i,j) .eq. modo(i,k) ) then
				write(55,*) i, pnumber(i), modo(i,j)!	hay modos repetidos! cte es muy bajo y no pude diferenciar
			endif!						2 bfac distintos
		enddo
	enddo

!	do j=1, tresn
!		write (66, *) bu(j), bf_frac(j)
!	enddo
enddo
prom= suma / 45
promi=int(prom)
!write (21, 94) promi
do i=1, m
	do k=1, tresn+6
		write (i+21, 91)(mods(k, modo(i,j)), j=1, pnumber(i)) 
	enddo
enddo

!!!!!!!!!!!!!!!!!!!!!!!!!!!! determina subespacio esencial !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do k=1, tresn+6!					el subespacio general arranca con el subespacio
	do j=1, pnumber(larger_idx)!			mas gde
	    subsp(k,j)=mods(k, modo(larger_idx,j) )
	enddo
enddo

do j=1, pnumber(larger_idx)!			tambien registro los modos esenciales del nuevo subespacio
	modo(m+1,j)= modo(larger_idx,j)!	q, en principio, seran los del subespacio mas gde
enddo
pnumber(m+1)=pnumber(larger_idx)!		y por ultimo, el tamano del subespacio
add=0

do j=1, m!					compara el subespacio mas grande con el resto de los subespacios
	if ( j .eq. larger_idx ) cycle
	do i=1, pnumber(j)!			va a comparar c/ modo del subespacio en cuestion
		flag2=0
		do k=1, pnumber(m+1)!		con c/ modo del subespacio mas gde
			if ( modo(m+1,k) .eq. modo(j,i) ) then
				flag2=1!	este modo lo tenia		
				exit
			endif
		enddo
		if ( flag2 .eq. 0 ) then!	este modo no lo tenia
			add= add + 1!		este es el contador de modos q el subespacio mas grande no tenia
			do k=1, tresn+6
			    		subsp(k,1+pnumber(m+1))=mods(k, modo(j,i) )! suma el modo q antes no tenia
			enddo	
			pnumber(m+1)=pnumber(m+1) + 1!		registra el aumento del tamano del subespacio
			modo(m+1,pnumber(m+1))= modo(j,i)!			registra q el subespacio total tiene otro modo
		endif
	enddo
enddo

do k=1, tresn+6
		write (m+21+1, 91) (subsp(k,j), j=1, pnumber(m+1))
enddo

close(11)
close(12)
close(13)
close(21)
close(m+21+1)
do i=1, m+1
	close(i+21)
enddo

91	format(10000(1x,F9.6))
92	format(1x,E24.15)
93	format(1i3)
94	format(500(i10))

end program msfer

SUBROUTINE hpsort(n,ra)
INTEGER n
double precision ra(n)
INTEGER i,ir,j,l
REAL rra
!double precision rra
if (n.lt.2) return
l=n/2+1
ir=n
10      continue
if(l.gt.1)then
l=l-1
rra=ra(l)
else
rra=ra(ir)
ra(ir)=ra(1)
ir=ir-1
if(ir.eq.1)then
ra(1)=rra
return
endif
endif
i=l
j=l+l
20      if(j.le.ir)then
if(j.lt.ir)then
if(ra(j).lt.ra(j+1))j=j+1
endif
if(rra.lt.ra(j))then
ra(i)=ra(j)
i=j
j=j+j
else
j=ir+1
endif
goto 20
endif
ra(i)=rra
goto 10
END subroutine hpsort
