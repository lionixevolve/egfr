      implicit none
      
      integer, parameter :: ikind=selected_real_kind(p=6)! p= 6, 15 o 18 (nro de figuras)
      integer, parameter :: jkind=selected_real_kind(p=15)! p= 6, 15 o 18 (nro de figuras)
      character*20 infile_1, infile_2, infile_3, infile_4, infile_6
      character*20 infile_5, outfile_1, outfile_2, outfile_3, tresnc, pnumc
      character*20 outfile_4
      integer i, j, k, t, m, flag, flag2, ierr, site(100)
      integer bfx, bfy, bfz, tresn, pnum
      integer, parameter :: ndatmax=3000
      integer, parameter :: max_mod=3000
      
      integer pmod(max_mod), pmod2(max_mod)
      integer nsub(ndatmax), nsub1(ndatmax)
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

      integer ndat,pnumber, nmod,iflag,ldx,iexp
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
      ! este codigo lo uso p/ reordenar las ponderaciones de los bfactors luego de haber
      ! hecho el min cost y haber obtenido el orden en un "nsub" file
      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      
      i=0
      j=0
      k=0
      t=0
      m=0
      call getarg (1, infile_1)!        
      call getarg (2, infile_2)!  
      call getarg (3, outfile_1)!     	
      ndat=825
      open (11, file=infile_1)
      open (12, file=infile_2)
      open (21, file=outfile_1)
      !!!!!!!!!!!!!!!!!!!!!!!!!!!! lee archivos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      do i=1, ndat!                          
          read (11,*) nsub(i),iorden(i)
      enddo 
      do k=1, ndat
        read(12,96) repe(k), bf_mode(k)
      enddo


      do i=1, ndat!                          
          write (21,96) i, bf_mode(iorden(i))
      enddo 

      
      close(11)
      close(12)
      close(21)
      close(22)
  
96      format(1i3,1x,1x,1x,F9.6)
      
      end

