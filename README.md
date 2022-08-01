# Descripción del modelo

## ¿Qué es?:

Este modelo simula un sistema bioinspirado genético de comportamiento y reproducción entre tres especies de tortugas que interactúan en un espacio con la finalidad de recolectar comida desde puntos de alimentación.

## ¿Cómo funciona?: 

El modelo posee un selector de cantidad tortugas por tipo (blanca, roja y azul) y un selector de cantidad de puntos de alimentación. Todas las tortugas poseen dos características básicas, que son la velocidad y la capacidad de recolección. La diferencia entre las tortugas es que, las azules recorren con mayor velocidad el mapa (recorren 2 casillas por cada escala de tiempo) y las rojas recolectan 1.5 veces más comida, las tortugas blancas por su parte tienen velocidad 1 y consumo 1.

Las tortugas tienen periodos exclusivos de recolección (500 ciclos), en los cuales se mueven por el mapa recolectando comida al pasar por el punto de comida. Luego de completar el periodo de recolección, las tortugas entran a un periodo exclusivo de reproducción, en el cual se reproducen en parejas con el fin de dar paso a la siguiente generación. La reproducción de dos tortugas siempre mantiene la misma cantidad de descendientes, es decir dos tortugas dan paso a otras dos. Las características de las tortugas de la nueva generación están determinadas por la tortuga predominante o con mayor Fitness en la reproducción.

Cada generación está determinada por un ciclo de recolección y uno de reproducción. Al cabo de un periodo de reproducción, la comida recolectada por las tortugas se restablece a cero.

## ¿Cómo usarlo?: 

Los controles deslizantes de las TORTUGAS indican el tamaño de la población de tortugas de un determinado color. De manera similar, el deslizante de COMIDA indica la cantidad de focos de comida dispuestos en el mapa. 

El interruptor "solo-cruce-entre-especies" activa o desactiva la opción de que las tortugas se aparean únicamente con tortugas de otra especie.

El botón de SETUP activa las poblaciones para que se rellene el número adecuado de tortugas por especie y el número adecuado de puntos de comida.

El botón GO da inicio a la simulación, gráficos y contadores de monitoreo.

El monitor de POBLACIÓN DE TORTUGAS muestra el recuento progresivo de la cantidad de tortugas por especie a medida que se generan periodos de recolección y reproducción.

El monitor de CONSUMO COMIDA POR GENERACIÓN muestra el recuento de la cantidad acumulada de comida recolectada por las tortugas en cada una de las generaciones. Además, refleja de color celeste una línea que indica la cantidad de comida recolectada en la primera generación.

Los contadores de monitoreo, se encuentran a la derecha del mapa de simulación. Dentro de estos contadores, se observa la cantidad de tortugas en cada una de las generaciones y el consumo total de comida de una generación. Además, se aprecia la cantidad de comida recolectada en las primeras tres generaciones y la cantidad de generaciones que ocurren antes de la predominancia de una especie.

## Cosas a tener en cuenta:

La reproducción de una tortuga, sólo considera una búsqueda a la derecha de esta dentro de la grilla del mapa. 

El apareamiento de dos tortugas, considera una probabilidad de predominancia de características, basada en la cantidad de comida recolectada en el periodo anterior. Esto implica que, al momento de reproducirse, la tortuga que predomine, mantendrá sus características mientras que la otra heredará las características de la tortuga predominante cambiando asi de tipo. Estas dos tortugas pasan a ser de la nueva generación, sin tener posibilidades de reproducirse nuevamente hasta que termine el periodo de reproducción.
