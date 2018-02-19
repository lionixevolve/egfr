program gapper
implicit none

integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
character*20 infile, outfile, seq1, seq2, test, seq1pir
character*80  string1(100), string2(100), fasta(100), line1, line2, last, line
integer i, j, k, n, m, t, fe, cont, ierr, gap_cont, flag1, flag2
integer left(20), right(20)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! este codigo agarra la salida del clustal con el alinamiento entre 2 seq.s 'seq' (template, seq1) 
! y 'struct' (target, seq2) y lo pone en formato pir. Las identificaciones, "seq1" y "seq2", tienen
! q ser de 6 caracteres max (ej 1NH4_A). Sino, sale feo.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

n=0
m=1
i=0
j=0
k=0
gap_cont=0
cont=0
flag1=1
flag2=1
call getarg (1, infile)! nombre del archivo de alineamiento salido del needle
call getarg (2, outfile)! nombre del archivo de salida con los margenes de gaps 
call getarg (3, seq1)! nombre de la 1era secuencia, ej: 1XKK_A
call getarg (4, seq2)! nombre de la 2da secuencia, canonical
open (11, file=infile)	
open (21, file=outfile)	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!! extrae del alineamiento !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do
	n= n +1
	read (11, 91, iostat= ierr) fasta(n)
	if ( ierr/= 0 ) exit
enddo

do i=30, n, 1
		test= fasta(i)(1:10)
		if  ( test == seq1 ) then
			k= k + 1
			string2(k)= fasta(i)(22:71)
		endif
enddo
! ya tengo las lineas de la secuencia gapeada. Ahora voy a determinar los rangos de esos gaps.
do i=1, k, 1
		do t=1, 50, 1
			if  (string2(i)(t:t) == '-' ) then
				if (flag1 .eq. 1) then
					flag1=0
					left(m)= gap_cont + 1
					gap_cont= gap_cont + 1! aca cuento los gaps
				else if  (flag1 .eq. 0) then
					gap_cont= gap_cont + 1! aca cuento los gaps
				endif
			endif

			if (string2(i)(t:t) /= '-' ) then
				if (flag1 .eq. 0) then
					flag1=1
					right(m)= gap_cont
					m= m + 1
				endif
				gap_cont= gap_cont + 1! aca cuento los gaps
			endif	
			
		enddo

enddo

do i=1, m-1, 1
	write(21,92) left(i), right(i)
enddo

close(11)
close(21)
91      format(1a80)
92      format(2i4)

end program gapper


