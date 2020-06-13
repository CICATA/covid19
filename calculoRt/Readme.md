
<!---
# [Instituto Politécnico Nacional](https://www.ipn.mx/)
# [CICATA Querétaro](https://www.cicataqro.ipn.mx/cq/qro/Paginas/index.html) 
![logo](https://github.com/CICATA/covid19/blob/master/ipn.png)
--->
# Cálculo de *R<sub>t</sub>* 


Este programa estima *R<sub>t</sub>*, la constante básica de reproducción para los municipios y estados de México. En nuestra opinión, una vez entendida la magnitud de la epidemia, *R<sub>t</sub>* representa el comportamiento que debe guiarnos sobre si podemos movernos o debemos quedarnos confinados. Valores de *R<sub>t</sub>* significan que el número de infectados está creciendo exponencialmente, mientras que valores de *R<sub>t</sub>*<1 significan que el número de infectados tiende a ser menor en el tiempo. 

El presente programa está basamos en la librería para **R** (el lenguaje) *EpiEstim*, la cual se construye alrededor del trabajo de Cori *et al.*[[1]](#1). 

Cori *et al.* asumieron que la tasa a la que una persona infectada contagia a otras sigue un proceso de Poisson. Enseguida utilizan un proceso de inferencia bayesiano en donde asumen un *prior* en la forma de una distribución Gamma, lo cual resulta en un *posterior* que también sigue una distribución Gamma. Este documento describe la media y desviación estándar resultante como elemento más verosímil del comportamiento y la incertidumbre del estimado.  Siguiendo la recomendación de Cori *et al.* solo calculamos *R<sub>t</sub>* cuando el número de casos es mayor a 12 infectados. Además, siguiendo un estudio de periodicidad propio, calculamos *\tau* como una semana. Finalmente, usando la investigación de Aghaali *et al.* [[2]](#2) asignamos una media de 4.55 y una desviación estándar de 3.30 al *prior* Gamma. Notando que la caracterización del intervalo serial varía ampliamente y posiblemente requiera valores que reflejen la dinámica del país [[3]](#3). 

Para construir los gráficos, para cada entidad bajo análisis, comparamos los registros entre el conjunto de datos más actual y el día anterior. Luego, encontramos la fecha más remota en la que hubo un cambio de un día para otro en el número de casos confirmados. Finalmente, mostramos una línea discontinua vertical en esa fecha y a partir de ahí una línea discontinua para el resto de las fechas. La estimación de *R<sub>t</sub>* que proporcionamos tiene la media y desviación estándar en ese momento.

El mapa puede ser consultado en tinyurl.com/mexico-Rt

Citar: Geospatial Spread of the COVID-19 Pandemic in Mexico; Dagoberto Pulido, Daniela Basurto, Mayra Cándido, Joaquín Salas. Arxiv 3221420, 2020

Para mayor información: 

<!---Instituto Politécnico Nacional</br>
Cerro Blanco 141, Colinas del Cimatario</br> 
Querétaro, 76090, México</br>
jsalasr@ipn.mx o --->
salas@ieee.org</br>
Joaquín Salas



# References
<a id="1">[1]</a> 
Cori, Anne and Ferguson, Neil  and Fraser, Christophe and Cauchemez, Simon (2013). 
A New Framework and Software to Estimate Time-Varying Reproduction Numbers during Epidemics. 
American Journal of Epidemiology</br>
<a id="2">[2]</a> 
Aghaali, Mohammad and Kolifarhood, Goodarz and Nikbakht, Roya and Mozafar Saadati, Hossein and Hashemi Nazari, Seyed Saeed (2020). 
Estimation of the Serial Interval and Basic Reproduction Number of COVID-19 in Qom, Iran, and Three Other Countries: A Data-Driven Analysis in the Early Phase of the Outbreak. 
Transboundary and Emerging Diseases</br>
<a id="3">[3]</a> 
Griffin, John  and Collins, Aine  and Hunt, Kevin and McEvoy, David and Casey, Miriam and Byrne,
  Andrew  and McAloon, Conor  and Barber, Ann and Lane, Elizabeth Ann and More, Simon (2020). 
A Rapid Review of Available Evidence on the Serial Interval and Generation Time of COVID-19. 
medRxiv</br>
