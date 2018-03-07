program capurifier
implicit none

integer i, j, k, m, n, flag1, flag2, firstaa, aa, ierr, st
integer, parameter :: length=20000
character*80 string
character*30 infile_1, outfile
character*8 xs, ys, zs, firstaas, factorc
real x(length), y(length), z(length), vx(length), vy(length), vz(length), factor

call getarg(1, infile_1)!	pdb a purificar 
call getarg(2, outfile)!	pdb de salida con Calphas
open (11, file=infile_1)
open (21, file=outfile)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do
        read(11, 91, iostat= ierr) string	
        if ( ierr/= 0 ) exit
	if(string(1:4).eq.'ATOM' .and. string(14:15).eq.'CA') then	
		write(21,91) string
	endif		
enddo
close(11)
close(21)
91   FORMAT(1a80)
92   FORMAT(1f20.18)
93   FORMAT(1f8.3)
end program capurifier
