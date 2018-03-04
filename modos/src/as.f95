call getarg (1, infile_1)!        los modos 
call getarg (2, infile_2)!        el archivo con los otros modos a comparar
call getarg (3, infile_3)!        los aportes a bftors de los modos del 1er subspace
call getarg (4, infile_4)!        los aportes a bftors de los modos del 2do subspace
call getarg (5, tresnc)!          Nro de elementos de los modos.
read(tresnc, *) tresn
ndat=tresn+6
call getarg (6, pnumberc)!         Nro de de modos. Si se especifican Bfactors, este valor se sobreescribe 
read(pnumberc, *) pnumber
call getarg (7, pnumber2c)!         Nro de de modos. Si se especifican Bfactors, este valor se sobreescribe
read(pnumber2c, *) pnumber2

call getarg (8, outfile_1)!       rtdo del zeta value 
call getarg (9, outfile_2)!       rtdo del nd value 
call getarg (10, outfile_3)!      eigenvalues del grammiano
call getarg (11, outfile_4)!      eigenvectors del grammiano
