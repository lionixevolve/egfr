#! usr/bin/perl -w
use strict;
use Text::Trim qw(trim);

my @Lista=qx(cat corr.list);
my @PDB=();
my $start="";
my $posicion="";
my @arch_pos=();
my $archi="";

chomp @Lista;
for (my $i=0; $i<@Lista; $i++)
{
@arch_pos=split("\t",$Lista[$i]);
@PDB=qx(cat $arch_pos[0]);
$archi=substr($arch_pos[0],0,-4);
open (OUT, ">",$archi."_.pdb");

	for (my $j=0;$j<@PDB;$j++)
	{
		if (substr($PDB[$j],0,4) =~ /ATOM/ || substr($PDB[$j],0,4) =~/TER/)
		{
		$posicion=substr($PDB[$j],22,4);
		trim($posicion);
		$posicion+=$arch_pos[1]-1; #ajustar de acuerdo a primer residuo en estructura a corregir

			if ($posicion>=1000)
			{
			print OUT substr($PDB[$j],0,22),$posicion,substr($PDB[$j],26);
			}			
			else
			{
			print OUT substr($PDB[$j],0,22)," ",$posicion,substr($PDB[$j],26); #espacio entre chainID y numeración
			}
		}
		else
		{
		print OUT $PDB[$j];
		}	

	}
	
	
}
close OUT;

