# EGFR de mar

## Modelado
Secuencia de interés: 703-979 (277 aa)


## Notas

### 1
Estas proteínas venían con residuos adicionales al final del .pdb, generalmente de otras cadenas.
Se los borré p/ q no jodan:
    2GS6_A
    4R3P_A
    5CNO_A
    5CZH_A

### 2
*restrain* es la carpeta en la q había modelado las estructuras en el intento
original de 2015.

### 3
Estas proteínas tienen algunos pbmas con la metodología original.
Algunas necesitan un rango extendido p/ modelar sin q se corte el loop, otras
necesitan q modele regiones auxiliares (ej:186-190) p/ q modeller no me haga
un nudo.

                        self.residue_range('186', '190'),)
### 4
La 1erastruct tenía este problema y su modelo de menor energía seguía exhibiendo
un nudo, así q elegí uno alternativo sin nudo, el modelo 50. Y si bien no
era el modelo de menor energía, estaba dentro del top10.
La 2da no conectaba 2 residuos de la región 46-48, así q también tuve q
seleccionarla a mano y resulto ser la 29. Y si bien no
era el modelo de menor energía, estaba dentro del top5.

    3GOP_A
    4RJ4_A

Todos estos cambios fueron incluidos en el archivo best_models, así q este
debería ser una fuente fidedigna de los mejores modelos.

### 5
Las primeras 2structs tenían 1 missing suelto en alguna región. Como mi algoritmo p/
detectar missings en el alineamiento es propio de un fronterizo, esto causó
problemas. Lo arreglé a mano, algún día arreglaré el algoritmo

    2EB2_A
    3VJN_A

### 6 
en *pdbs_finales* hay 3 tipos de .pdbs:
ej: (1XKK_A)
Los mejores modelos del modeller, sin modificar.
    nonrot_1XKK_A
pdbs finales p/ analizar
    1XKK_A

### 7
No hay puentes disulfuro, pero el codigo de NMA espera leer esos archivos y
prefiero darselos vacíos a q modificarlo. Así q c/ pdb va a tener este tipo
de archivo: (ej:1XKK_A)
    1XKK_A

### 8
En las carpetas *model* y *modos* están los 58 .pdbs iniciales. Una vez obtenidos
los modos, calculé las correlaciones entre Bfactors y descarté 7 .pdbs:
    2J5F_A
    3GT8_C
    4I22_A
    4I24_A
    5CNN_B
    5CNO_A
    5EDP_A
    5HIB_A

Por lo tanto, en la carpeta *gram* hay solo 58 .pdbs y los archivos *pdbs.list*
*am.list* e *im.list* son distintos.

### 9
