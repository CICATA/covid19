
# [Instituto Politécnico Nacional](https://www.ipn.mx/)
# [CICATA Querétaro](https://www.cicataqro.ipn.mx/cq/qro/Paginas/index.html) 
![logo](https://github.com/CICATA/covid19/blob/master/ipn.png)
# Cálculo de *R*<sub>t</sub> 


Este programa estima $R_t$, la constante básica de reproducción para los municipios y estados de México. En nuestra opinión, una vez entendida la magnitud de la epidemia, $R_t$ representa el comportamiento que debe guiarnos sobre si podemos movernos o debemos quedarnos confinados. Valores de $R_t>1$ significan que el número de infectados está creciendo exponencialmente, mientras que valores de $R_t<1$ significan que el número de infectados tiende a ser menor en el tiempo. 

El presente programa está basamos en la librería para **R** (el lenguaje) *EpiEstim*, la cual se construye alrededor del trabajo de Cori *et al.*[-@cori2013new]. 

Cori *et al.* asumieron que la tasa a la que una persona infectada contagia a otras sigue un proceso de Poisson. Enseguida utilizan un proceso de inferencia bayesiano en donde asumen un *prior* en la forma de una distribución Gamma, lo cual resulta en un *posterior* que también sigue una distribución Gamma. Este documento describe la media y desviación estándar resultante como elemento más verosímil del comportamiento y la incertidumbre del estimado.  Siguiendo la recomendación de Cori *et al.* solo calculamos $R_t$ cuando el número de casos es mayor a 12 infectados. Además, siguiendo un estudio de periodicidad propio, calculamos $\tau$ como una semana. Finalmente, usando la investigación de Aghaali *et al.* [-@aghaali2020estimation] asignamos una media de 4.55 y una desviación estándar de 3.30 al *prior* Gamma. Notando que la caracterización del intervalo serial varía ampliamente y posiblemente requiera valores que reflejen la dinámica del país [@griffin2020rapid]. 

Para construir los gráficos, para cada entidad bajo análisis, comparamos los registros entre el conjunto de datos más actual y el día anterior. Luego, encontramos la fecha más remota en la que hubo un cambio de un día para otro en el número de casos confirmados. Finalmente, mostramos una línea discontinua vertical en esa fecha y a partir de ahí una línea discontinua para el resto de las fechas. La estimación de $R_t$ que proporcionamos tiene la media y desviación estándar en ese momento.



# References
