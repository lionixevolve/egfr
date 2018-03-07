program bfer
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
character*20 infile_1, infile_2, outfile
character*6 bf1(3000), bf2(3000)
character*80  file1(3000), file2(3000), fasta(3000)
integer i, j, k, t, n, m, flag, ierr
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo copia los Bfactors de un .pdb a otro, siempre q este otro tenga 0.00
! en donde deberia estar su Bftor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

i=0
j=0
k=0
t=0
n=0
m=0
call getarg (1, infile_1)! este tiene los bftors
call getarg (2, infile_2)! este va a recibir los bftors
call getarg (3, outfile)! esta es el infile_2 luego de agregar los bftors
open (11, file=infile_1)	
open (12, file=infile_2)! 
open (21, file=outfile)	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!! extrae del alineamiento !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do
	n= n +1
	read (11, 91, iostat= ierr) file1(n)
	bf1(n)= file1(n)
	if ( ierr/= 0 ) exit
enddo
do
	m= m +1
	read (12, 91, iostat= ierr) file2(m)
	bf2(m)= file1(m)
	if ( ierr/= 0 ) exit
enddo

do i=1, n, 1
	do j=1, m, 1
		if  ( file1(i)(31:54) == file2(j)(31:54) ) then
			file2(j)(61:66) = file1(i)(61:66)
			exit		
		endif
	enddo
enddo

do i=1, m-1, 1
                write(21,91) file2(i)
enddo

close(11)
close(12)
close(21)
91	format(1a80)
92	format(1a7)
93	format(2a80)

end program bfer 


