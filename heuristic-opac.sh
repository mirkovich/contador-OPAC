#!/bin/bash


# HEURISTICA 1
# IDEA: GENERAR NUMEROS ALEATORIOS medianamente grande (la idea es encontrar una cota superior)
valuerandom=0
echo Buscando cota superior
while [ $? -eq 0 ]; do
  let valuerandom=$((RANDOM% 5000 + 5000))+$valuerandom
  rm foo
  wget --no-check-certificate $1/cgi-bin/koha/opac-detail.pl?biblionumber=$valuerandom -O foo
done

echo  Con pasos aleatorios de 5000 a 10000 la primer posible cota superior obtenida es $valuerandom

# IDEA: ahora con una posible cota superior hay que verificar si realmente es una posible cota superior

# IDEA: para eso vamos a testear si tiene muchas paginas "no disponibles" localmente superior
# osea vamos a preguntar por los vecinos cercanos de arriba si funcionan o no

cantIntentos=$((RANDOM%10 + 10))
fallas=0
correctas=0
for i in `seq 1 $cantIntentos`;
do
  rm foo
  let valuerandom=$((RANDOM% 5))+$valuerandom
  wget --no-check-certificate $1/cgi-bin/koha/opac-detail.pl?biblionumber=$valuerandom -O foo
  if [$? -eq 0]
  then
    let correctas=$correctas+1
    newcotasuperioris=$valuerandom
  else
    let fallas=$fallas+1
  fi
done

echo se hicieron $cantIntentos intentos
echo cantidad de fallas es $fallas
echo cantidad de aciertos es $correctas


