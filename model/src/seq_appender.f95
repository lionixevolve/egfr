program pirer
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
character*20 infile, outfile, seq1, seq2, test
character*80  string1(100), string2(100), fasta(100), line1, line2, last, line
integer i, j, k, n, m, t, fe, cont, ierr
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo agarra 2 archivos en formato ".pir" y te los junta en 1 solo, formato FASTA
! p/ q te los alinee el clustalw o lo q pinte
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

n=0
m=0
i=0
j=0
k=0
cont=0
call getarg (1, seq1)! nombre del file con la 1era secuencia, sequence
call getarg (2, seq2)! nombre del file con la 2da secuencia, structure
call getarg (3, outfile)
open (11, file=seq1)	
open (12, file=seq2)	
open (21, file=outfile)	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!! extrae del alineamiento !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do
	n= n +1
	read (11, 91, iostat= ierr) string1(n)
	if ( ierr/= 0 ) exit
enddo
do
	m= m +1
	read (12, 91, iostat= ierr) string2(m)
	if ( ierr/= 0 ) exit
enddo
close(11)
close(12)

write(55,91) string2(2)! escribe la 2da linea, del structure, q despues la voy a necesitar
write(21,92) '>sequence'
do i=3, n-1, 1
	if ( i == n-1 ) then
        	do t=1, 80, 1
                	if ( string1(i)(t:t) == '*' ) then
                        	string1(i)(t:t)=' '
                        	exit
	                endif
        	enddo
	endif
	write(21,91) string1(i)
enddo

write(21,93) ' '!pone blank line entre secuencia y secuencia
write(21,93) '>structure'
do i=3, m-1, 1
	if ( i == m-1 ) then
	        do t=1, 80, 1
	                if ( string2(i)(t:t) == '*' ) then
        	                string2(i)(t:t)=' '
	                        exit
	                endif
        	enddo
	endif
	write(21,91) string2(i)
enddo

close(21)
91	format(1a80)
92	format(1a9)
93	format(1a10)

end program pirer 


