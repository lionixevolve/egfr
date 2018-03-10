program displacer
implicit none

integer i, j, k, m, n, flag1, flag2, firstaa, aa, ierr, st, factor
integer, parameter :: length=9000
character*80 string(length), aas
character*30 infile_1, infile_2, outfile, out_cont 
character*8 xs, ys, zs, firstaas, factorc
real x(length), y(length), z(length), vx(length), vy(length), vz(length)

m=0!				pdb line counter
n=0!				Calpha counter
flag1=0
flag2=0
call getarg(1, infile_1)!	pdb a desplazar
call getarg(2, infile_2)!	vtor de desplazamiento
call getarg(3, outfile)
call getarg(4, factorc)
read(factorc,*) factor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (11, file=infile_1)
do
    m = m + 1
    read(11, 91, iostat= ierr) string(m)
    if(string(m)(1:4).eq.'ATOM') then
        if (flag1==0) then
            flag1=1
            firstaas=string(m)(23:26)
            read(firstaas,*) firstaa
            st=m
        endif
    endif
    if ( ierr/= 0 ) exit
enddo
m= m - 1
close(11)
!!!!!!!!!!!
open (12, file=infile_2)
do
    n = n + 1
    read(12, 92, iostat= ierr) vx(n)
    read(12, 92, iostat= ierr) vy(n)
    read(12, 92, iostat= ierr) vz(n)
    vx(n)= vx(n) * factor
    vy(n)= vy(n) * factor
    vz(n)= vz(n) * factor
    if ( ierr/= 0 ) exit
enddo
n= n - 1
close(12)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
open (21, file=outfile)
do i=1, m
    if(string(i)(1:4).eq.'ATOM') then
        aas=string(i)(23:26)
        read(aas,*) aa
        aa= aa - firstaa + 1
        xs=string(i)(31:38)
        ys=string(i)(39:46)
        zs=string(i)(47:54)
        read(xs,*) x(i)
        read(ys,*) y(i)
        read(zs,*) z(i)
        x(i)= x(i) + vx(aa)
        y(i)= y(i) + vy(aa)
        z(i)= z(i) + vz(aa)
        write(xs, 93) x(i)
        write(ys, 93) y(i)
        write(zs, 93) z(i)
        string(i)(31:38)= xs
        string(i)(39:46)= ys
        string(i)(47:54)= zs
!castear xyz a string!		
    endif
    write(21,91) string(i)
enddo
close(21)


91   FORMAT(1a80)
92   FORMAT(1f20.18)
93   FORMAT(1f8.3)
end program displacer
