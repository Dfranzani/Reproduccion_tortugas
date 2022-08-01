; Variables goblales:
; iteraciones: cantidad de iteraciones.
; generacioes: indica la cantidad de generaciones.
; consumo-comida-primera-generacion: Consumo total de comida de la primera generación.
; consumo-comida-segunda-generacion: Consumo total de comida de la segunda generación.
; consumo-comida-tercera-generacion: Consumo total de comida de la tercera generación.
; consumo-comida: Consumo total de comida de todas las generaciones.
globals [
  iteraciones
  generaciones
  consumo-comida-primera-generacion
  consumo-comida
  consumo-comida-segunda-generacion
  consumo-comida-tercera-generacion
]

; Creación de elmentos:
; person: corresponden a los agentes tortuga.
; targets: corresponden a los puntos de comida.
breed [people person]
breed [targets target]

; Características de las tortugas:
; velocidad: corresponde a la cantidad de casillas que son recorridas en un "tick", su valor es un entero mayor a 0.
; cantidad-comida: corresponde a la comida acumulada por la tortuga.
; alimentacion: corresponde a la cantidad de comida que recolecta una tortuga al momento de pasar por un foco de alimentación.
; can-reproduce? valor booleano que indica si la tortuga tiene la capacidad de reproducirse.
; can-eat:? valor booleano que indica si la tortuga puede consumir comida al pasar por un foco de alimentación.
people-own [
  velocidad
  cantidad-comida
  alimentacion
  can-reproduce?
  can-eat?
]

;; Configuración de los procedimientos.
to setup
  clear-all ; limpia el espacio de trabajo.
  setup-globals ; Limpia el mapa
  setup-people ; crea las tortugas.
  setup-targets ; crea los espacios de comida.
  reset-ticks ; reinicia los pasos de la simulación.
end

; Restablece todas las casillas a color negro
to setup-globals
 ask patches [set pcolor black]
end

; Creación de torgugas
to setup-people
  ; Creación de la tortuga blanca.
  create-people Tortuga_Blanca
  [
    setxy random-xcor random-ycor ; Se posición en coordenadas aleatorias en el mapa
    set shape "turtle" ; Tipo tortuga.
    set can-reproduce? False ; Inicialmente no se puede reproducir.
    set color white ; Tortuga de color blanco en el mapa.
    set can-eat? True ; Inicialmente tiene la capacidad de comer en los puntos de comida.
    assign-speed ; Asiganción de la velocidad de movimiento.
    set alimentacion 1 ; La capacidad de recolección de comida es 1, es decir recolecta una unidad.
    set cantidad-comida 0 ; Se incicia con una cantidad acumulada de comida de cero.
  ]
  ; Creación de la tortuga roja.
  create-people Tortuga_Roja
  [
    setxy random-xcor random-ycor ; Se posición en coordenadas aleatorias en el mapa
    set shape "turtle" ; Tipo tortuga.
    set can-reproduce? False ; Inicialmente no se puede reproducir.
    set can-eat? True ; Inicialmente tiene la capacidad de comer en los puntos de comida.
    set color red ; Tortuga de color rojo en el mapa.
    assign-speed ; Asiganción de la velocidad de movimiento.
    set alimentacion 1.5 ; La capacidad de recolección de comida es 1.5, es decir recolecta dos unidad unidades.
    set cantidad-comida 0 ; Se incicia con una cantidad acumulada de comida de cero.
  ]
  ; Creación de la tortuga azul.
  create-people Tortuga_Azul
  [
    setxy random-xcor random-ycor ; Se posición en coordenadas aleatorias en el mapa
    set shape "turtle" ; Tipo tortuga.
    set can-reproduce? False ; Inicialmente no se puede reproducir.
    set can-eat? True ; Inicialmente tiene la capacidad de comer en los puntos de comida.
    set color blue ; Tortuga de azul rojo en el mapa.
    assign-speed ; Asiganción de la velocidad de movimiento.
    set alimentacion 1 ; La capacidad de recolección de comida es 1, es decir recolecta una unidad.
    set cantidad-comida 0 ; Se incicia con una cantidad acumulada de comida de cero.
  ]
end

; Creación de puntos de comida.
to setup-targets
  create-targets comida ; Se crea un punto de comida.
  [
    setxy random-xcor random-ycor ; Se posición en coordenadas aleatorias en el mapa
    set shape "target" ; Tipo objetivo.
    set pcolor red ; Objetivo de color de fondo rojo.
    set color white ; Objetivo de color blanco (icono de diana).
    move-to patch-here ; Hace calzar el fondo con el icono.
  ]
end

; Asginación de velocidad de movimiento a las tortugas.
to assign-speed
  ifelse color = blue ; La tortuga azul.
  [ set velocidad 2] ; tendrá una velocidad de movimiento de 2.
  [set velocidad 1 ] ; mientras que el resto de tortugas tendrá una velocidad de 1.
end

;; Función de incialización de los procedimientos
to go ; incialización
  ask people[ ; se le solicita a las tortugas que ejecuten las siguientes acciones
    reproduce ; reproducir (el detalle de esta función se encuentra abajo)
    move ; mover (el detalle de esta función se encuentra abajo)
  ]

  update ; Función que actualiza el consumo total de comida recolectado por las tortugas.

  to-iterate ; Función de iteración en la que se consulta la iteración actual
  ; Las generaciones se consideran cada 1000 iteraciones a partir de la iteración 500.
  ; Añadimos la cláusula de máximo 500 generaciones, las cuales estąn definidas cada 1000 iteraciones a partir de la iteración 500.
  ifelse iteraciones <= 500000
  [
  if iteraciones = 500; Primera generación.
  [
    set consumo-comida-primera-generacion consumo-comida ; Actualización del consumo total de comida recolectado por las tortugas de la primera generación.
    ask people [ ; Se consulta a las tortugas
    set can-reproduce? True ; Se les dota de capacidad de reproducción a todas las rtortugas.
    set can-eat? False] ; Se les quita de capacidad de recolección de comida a todas las tortugas.
    to-generaciones ; Conteo de la primera generación.
  ]
  ; Las tortugas se reproducen hasta la iteración 999, en la cual:
  if (iteraciones = 999 )
  [
    ask people
    [ set cantidad-comida 0 ; Se restablece su comida recoletada a cero.
      set can-reproduce? False ; Se les quita su capacidad de reproducción.
      set can-eat? True ; Se les dota de capacidad de recolección.
      ]
  ]
  ; Las sentencias anteriores, se repiten en las iteraciones en las iteraciones con módulo 500 igual a 499 respectivamente.

  ; Segunda generación
  if iteraciones = 1500
  [
    set consumo-comida-segunda-generacion consumo-comida
    ask people [
    set can-reproduce? True
    set can-eat? False]
    to-generaciones ; Conteo de la seguinda generación
  ]
  if (iteraciones = 1999 )
  [
    ask people
    [ set cantidad-comida 0
      set can-reproduce? False
      set can-eat? True
      ]
  ]

  ; Tercera generación
  if iteraciones = 2500
  [
    set consumo-comida-tercera-generacion consumo-comida
    ask people [
    set can-reproduce? True
    set can-eat? False
    ]
      to-generaciones
    ]

  if iteraciones > 2999
  [
    ; Generacione sposteriores
    if  iteraciones mod 500 = 0 and iteraciones mod 1000 = 0
    [
    ask people
    [
      set cantidad-comida 0
      set can-reproduce? False
      set can-eat? True
    ]
    to-generaciones
  ]
  if  iteraciones mod 500 = 499
    [
    ask people [
    set can-reproduce? True
    set can-eat? False]
    ]
  ]
  ; El proceso se detiene cuando una tortuga predomina sobre las demás, es decir el conteo de solo una tortuga es mayor a cero.
  if count people with [color = red] = count people or count people with [color = white] = count people or count people with [color = blue] = count people
  [stop]
  ]
  [
    stop
  ]
  tick
end

; Función descubrir: permite a la rotuga verificar si está en una un foco de comida
to discover
  if (pcolor = red)
  [
     feed ; Si se encuentra con un foco de comida ejecuta la función alimento.
  ]
end

; Función alimento: permite a la tortuga recolectar comida del foco de comida.
to feed
  if (can-eat? = True) [ ; Si la tortuga tiene activa la capacidad de alimentación
    set cantidad-comida cantidad-comida + 1 * alimentacion ; Se actualiza el conteo de comida total de la tortuga, sumando una vez su capacidad de recolección.
    ]
end

; Función de iteración
to to-iterate
  set iteraciones iteraciones + 1 ; Se cuentan la cantidad de iteraciones.
end

; Función cantidad de generaciones
to to-generaciones
  set generaciones generaciones + 1 ; Se cuentan la cantidad de generaciones.
end


; Función reproducir: enfocada en la reproducción de las tortugas.
to reproduce
  if (can-reproduce? = True) ; Se consulta si la toruga tiene la capacidad de reproducirse.
  [
    let fellow one-of (people-at -1 0) ; Se observa si el vecino ubicado a la derecha de la tortuga.
    if (fellow != nobody) and ([can-reproduce?] of fellow) ; Se establece que debe existir un elemento en la casilla del vecino y debe tener una determinada capacidad de reproducción.
    [
      ifelse (solo-cruce-entre-especies = True) ; Se verifica el caso en que el apareamiento sea solo entre tortugas de distinto color.
      [
        ; Se genera una probabilidad de predominancia en el apareamiento.
        let comidavecina [cantidad-comida] of fellow ; Se consulta la cantidad de comida recolectada por la tortuga vecina.
        let total comidavecina + cantidad-comida; Se calcula la suma de comida entre las tortugas que se aparean.
        let prop ifelse-value (total > 0) [comidavecina / total] [0.5] ; Si el total de la comida es mayor a cero, se asigna una probabilidad igual a la proporción en que se aporta a la suma total. En caso de que sea cero, se establece un caso equiprobable.

        if (color != [color] of fellow) ; Se verifica que las tortugas sea de distinto color.
        [
          ifelse (prop > random-float 1) ; Se evalua un valor aletorio entre 0 y 1 que determine que tortuga predomina en el apreamiento. En este caso, predomina tortuga de la derecha (el vecino).
          [
            set can-reproduce? False ; Se anula la capacidad de reducción de la tortuga.
            set velocidad [velocidad] of fellow ; Se restablece la velocidad de la tortuga igual a la de su vecino.
            set alimentacion [alimentacion] of fellow ; Se restablece la alimentación de la tortuga igual a la de su vecino.
            set color [color] of fellow ; Se restablece el color de la tortuga igual a la de su vecino.
            ask fellow [set can-reproduce? False] ; El vecino pierde su capacidad de reproducción.
          ]
          [
            ; En este caso, predomina tortuga de la izquierda.
            set can-reproduce? False ; Se anula la capacidad de reducción de la tortuga.
            ask fellow [set velocidad velocidad] ; Se restablece la velocidad del vecino igual a la de la tortuga
            ask fellow [set alimentacion alimentacion] ; Se restablece la alimentación del vecino igual a la de la tortuga.
            ask fellow [set color color] ; Se restablece el color del vecino igual a la de la tortuga.
            ask fellow [set can-reproduce? False] ; El vecino pierde su capacidad de reproducción.
          ]
        ]
      ]
      [ ; Este corresponde al caso en el que se incluye el apareamiento entre tortugas de la misma especie.
        ; El efecto y definición de las variables es el mismo que definido en las sentencias anteriores.
        let comidavecina [cantidad-comida] of fellow
        let total comidavecina + cantidad-comida
        let prop ifelse-value (total > 0) [comidavecina / total] [0.5]

        ifelse (prop > random-float 1)
        [
          set can-reproduce? False
          set velocidad  [velocidad] of fellow
          set alimentacion  [alimentacion] of fellow
          set color [color] of fellow
          ask fellow [set can-reproduce? False]
        ]
        [
          set can-reproduce? False
          ask fellow [set velocidad velocidad]
          ask fellow [set alimentacion alimentacion]
          ask fellow [set color color]
          ask fellow [set can-reproduce? False]
        ]
      ]
    ]
  ]
end

; Función de movimiento de las tortugas
to move
  rt random-float 360 ; Número aleatorio entre 0 y 360 que indica la dirección del movimiento.
  fd 1 ; el avance de la tortuga es de 1 "casilla".
  discover ; Se ejecuta la función descubrir.
  if color = blue ; En el caso de las tortugas azules, durante el mismo "tick":
  [
    rt random-float 360 ; Número aleatorio entre 0 y 360 que indica la dirección del movimiento.
    fd 1 ; avanzan una segunda casilla.
    discover  ; Se ejecuta la función descubrir.
    reproduce  ; Se ejecuta la función reproducir.
   ]
end

; Función de actualización del consumo de comida.
to update
  set consumo-comida sum [cantidad-comida] of people ; Suma acumulada de la comida recolectada por todas las tortugas.
end
@#$#@#$#@
GRAPHICS-WINDOW
495
10
932
318
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-11
11
1
1
1
ticks
30.0

SLIDER
2
64
174
97
Tortuga_Blanca
Tortuga_Blanca
0
100
70.0
1
1
NIL
HORIZONTAL

SLIDER
3
102
175
135
Tortuga_Roja
Tortuga_Roja
0
100
15.0
1
1
NIL
HORIZONTAL

SLIDER
3
140
175
173
Tortuga_Azul
Tortuga_Azul
0
100
15.0
1
1
NIL
HORIZONTAL

SLIDER
2
179
174
212
comida
comida
0
50
4.0
1
1
NIL
HORIZONTAL

PLOT
0
331
1407
555
Población de Tortugas
Ciclos
Cantidad
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Tortuga Rojas" 1.0 0 -2674135 true "" "plot count people with [color = red]"
"Tortuga Blancas" 1.0 0 -13840069 true "" "plot count people with [color = white]"
"Tortuga Azules" 1.0 0 -13345367 true "" "plot count people with [color = blue]"

TEXTBOX
9
7
358
71
MODELO DE SISTEMA BIOINSPIRADO DE REPRODUCCIÓN DE TORTUGAS
13
73.0
1

BUTTON
12
226
78
259
Setup
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
102
228
165
261
Go
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
952
204
1150
249
NIL
consumo-comida
17
1
11

MONITOR
952
33
1148
78
Cantidad Tortugas Blancas
count people with [color = white]
17
1
11

MONITOR
953
85
1149
130
Cantidad Tortugas Rojas
count people with [color = red]
17
1
11

MONITOR
952
143
1149
188
Cantidad Tortugas Azules
count people with [color = blue]
17
1
11

MONITOR
1170
32
1408
77
consumo-comida-primera-iteracion
consumo-comida-primera-generacion
17
1
11

MONITOR
1172
85
1410
130
NIL
consumo-comida-segunda-generacion
17
1
11

MONITOR
1172
142
1409
187
NIL
consumo-comida-tercera-generacion
17
1
11

PLOT
0
574
1288
807
Consumo Comida por Generación
Ciclos
Cantidad
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot consumo-comida"
"pen-1" 1.0 0 -11221820 true "" "plot consumo-comida-primera-generacion"

SWITCH
180
66
387
99
solo-cruce-entre-especies
solo-cruce-entre-especies
1
1
-1000

MONITOR
1172
202
1407
247
Generaciones
generaciones
1
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
