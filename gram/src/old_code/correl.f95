program correller
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
character*20 infile_1, infile_2, outfile
character*3  leftc(100), rightc(100), fasta(100)
integer i, j, k, t, n, m, flag, ierr, left(10), right(10), exc(100), p
double precision bfexp(400), bfteo(400)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo copia los Bfactors de un .pdb a otro, siempre q este otro tenga 0.00
! en donde deberia estar su Bftor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=1
t=0!				nro de aa's totales
n=0!	
m=0!				nro de aa's rellenados
p=0

call getarg (1, infile_1)! este tiene los aa's q fueron rellenados 
call getarg (2, outfile)! aca pongo la correlacion entre bftrs  
open (11, file=infile_1)	
open (21, file=outfile)	
!!!!!!!!!!!!!!!!!!!!!!!!!!! determina los aa's rellenados !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do
	n= n +1
	read (11, 91, iostat= ierr) left(n), right(n)
	if ( ierr/= 0 ) exit
enddo

do j=1, n-1, 1
	do i= left(j), right(j), 1
		write(21,92) i
	enddo
enddo

close(11)
close(21)
91	format(i5,i6)
92	format(1i4)
93	format(i5,1x,F6.2,1x,F7.3)

end program correller
