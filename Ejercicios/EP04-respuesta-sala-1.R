# ****************************************** ENUNCIADO PREGUNTA 1 ******************************************

# El art�culo "Automatic Segmentation of Medical Images Using Image Registration: Diagnostic and
# Simulation Applications" (Journal of Medical Engeeniering and Technology 2005) propuso una nueva
# t�cnica para la identificaci�n autom�tica de los bordes de estructuras significativas en una imagen m�dica
# utilizando desplazamiento lineal promedio (ALD, por sus siglas en ingl�s). El art�culo dio las siguientes
# observaciones de ALD con una muestra de 49 ri�ones (en pixeles y usando punto en vez de coma decimal):
# 1.38 1.28 1.09 1.07 0.96 1.28 0.91 1.49 1.11 0.66 1.14 1.13 0.91 0.94 1.30
# 0.87 0.73 0.92 1.00 1.05 1.12 1.10 0.95 1.29 0.86 0.96 0.94 1.45 1.12 1.06
# 0.71 0.88 0.96 1.14 1.03 0.89 0.81 1.04 1.15 0.75 1.12 1.01 1.11 0.64 1.25
# 0.68 1.44 1.28 1.21
# Los autores comentaron que el ALD medio ser�a de al menos 1.0 pixel. �Los datos soportan esta
# afirmaci�n?


# Formulaci�n de las hip�tesis:

# H0: El ALD medio es de 1.0 pixel
# HA: El ALD medio es mayor a 1.0 pixel

# En este caso, el valor nulo es ??0 = 1.0 pixel. Matem�ticamente, 
# las hip�tesis anteriores se pueden formular como:
# H0: ?? = ??0, esto es ?? = 1.0
# HA: ?? > ??0, esto es ?? > 1.0

# Se procede a utilizar la prueba t de Student, dado que la prueba Z no es muy utilizada y asume 
# el supuesto de normalidad. Adem�s, la prueba t es igualmente adecuada para muestras de tama�o grande (n>30).

# Se verifica el cumplimiento de las condiciones para poder usar la 
# prueba t:

# 1.- Si bien, no indica que las muestras fueron escogidas al azar,
# el conjunto de instancias posibles es muy grande, y las 49 seleccionadas
# no superan el 10% de la poblaci�n. Adem�s, las muestras provienen de un art�culo de confianza.

# 2.- Al construir un gr�fico Q-Q, se pueden observar algunos valores 
# at�picos, por lo que no podemos suponer con certeza que la muestra sigue
# una distribuci�n normal. Es por lo anterior, que se realiza una prueba de
# Shapiro-Wilk, de donde se obtiene un valor p = 0.6202, el cual es
# superior a nuestro nivel de significaci�n (0.01), por lo que
# podr�amos decir que provienen de una distribuci�n normal. Sin embargo,
# al construir un histograma y un gr�fico de densidades, se puede apreciar 
# que no se aproxima mucho a una distribuci�n normal. 
# Dado que se tienen dudas respecto a la distribuci�n de la muestra,
# seremos m�s exigentes para llevar a cabo la prueba t, utilizando 
# un nivel de confianza del 99%.

# Observaci�n: dado que es una hip�tesis unilateral, el par�metro "alternative" de t.test toma el valor de "greater", 
# ya que la media de la poblaci�n es mayor que el valor nulo en la hip�tesis alternativa.

# ********************* C�DIGO EN R PREGUNTA 1 *********************
library(ggpubr)

# Se carga el conjunto de datos

texto <- "1.38 1.28 1.09 1.07 0.96 1.28 0.91 1.49 1.11 0.66 1.14 1.13 0.91 0.94 1.30
0.87 0.73 0.92 1.00 1.05 1.12 1.10 0.95 1.29 0.86 0.96 0.94 1.45 1.12 1.06
0.71 0.88 0.96 1.14 1.03 0.89 0.81 1.04 1.15 0.75 1.12 1.01 1.11 0.64 1.25
0.68 1.44 1.28 1.21"
file <- textConnection(texto)
muestra <- scan(file)

# Construir gr�fico Q-Q
datos <- data.frame(muestra)
g <- ggqqplot(datos, x = "muestra", color = "Steelblue", xlab = "Te�rico", ylab = "Muestra",
              title = "Gr�fico Q-Q muestra v/s distr. normal")
print(g)

# Verificar distribuci�n muestral usando
# la prueba de normalidad de Shapiro-Wilk
normalidad <- shapiro.test(muestra)
print(normalidad)


#Para demostrar la forma de la distribuci�n.
#Se grafica un histograma de la muestra
hist(muestra)
#Se construye un gr�fico de densidades
ggdensity(data = muestra, color="black", fill="red", add="mean", title="Gr�fico de densidades para la muestra")

# Fijamos el valor nulo
valor_nulo <- 1.0

# Fijamos el nivel de significaci�n (en 0.01 en vista de que se tienen dudas con la forma de la distribuci�n)
alfa <- 0.01

# Se obtiene la media de la muestra
media <- mean(muestra) 
cat("Media =", media, "pixel")

# Se obtiene la desviaci�n est�ndar de la muestra
desv_est <- sd(muestra)
cat("Desviaci�n est�ndar =", desv_est, "pixel")

# Se aplica la prueba t de Student para una muestra
prueba <- t.test(muestra, alternative = "greater", mu = valor_nulo, conf.level = 1 - alfa)

print(prueba)



# ********************* CONCLUSIONES PREGUNTA 1 *********************

# Los resultados obtenidos al aplicar la prueba t de Student son los siguientes:
# El valor para el estad�stico de prueba T es t = 1.4887
# Se consideran df = 48 grados de libertad para la distribuci�n t.
# El valor p obtenido es p = 0.07155
# El intervalo de confianza obtenido es [0.9726945; Inf)
# La media de la muestra es = 1.044286

# Como se puede notar, el valor medio se encuentra dentro del intervalo de confianza. Adem�s,
# el valor de p es mayor que el nivel de significaci�n (0.07155 > 0.01), por lo que se falla
# al rechazar la hip�tesis nula. Por lo tanto, se puede afirmar con un 99% de confianza
# que el ALD medio es igual a 1.0 pixel.


# ****************************************** ENUNCIADO PREGUNTA 2 ******************************************
# Se sabe que la lactancia estimula una p�rdida de masa �sea para proporcionar cantidades de calcio
# adecuadas para la producci�n de leche. Un estudio intent� determinar si madres adolescentes pod�an
# recuperar niveles m�s normales a pesar de no consumir suplementos (Amer. J. Clinical Nutr., 2004; 1322-
# 1326). El estudio obtuvo las siguientes medidas del contenido total de minerales en los huesos del cuerpo
# (en gramos) para una muestra de madres adolescentes tanto durante la lactancia (6-24 semanas
# postparto) y posterior a ella (12-30 semana postparto):

# Sujeto 1 2 3 4 5 6 7 8 9 10
# Lactancia 1928 2549 2825 1924 1628 2175 2114 2621 1843 2541
# Posdestete 2126 2885 2895 1942 1750 2184 2164 2626 2006 2627

# �Sugieren los datos que el contenido total de minerales en los huesos del cuerpo durante el posdestete
# excede el de la etapa de lactancia por m�s de 60 g?

# Formulaci�n de las hip�tesis:
# H0: la media de las diferencias entre el contenido total de minerales en los huesos del cuerpo durante el posdestete
# y el contenido total de minerales en los huesos del cuerpo durante la lactancia es igual a 60 g.

# HA: la media de las diferencias entre el contenido total de minerales en los huesos del cuerpo durante el posdestete
# y el contenido total de minerales en los huesos del cuerpo durante la lactancia es superior a 60 g.

# En este caso, el valor nulo es ??0 = 60 g. Matem�ticamente:
# Denotando la media de las diferencias del contenido total de minerales en los huesos del cuerpo 
# como �dif:
# H0: �dif = ??0, esto es �dif = 60
# HA: �dif > ??0, esto es �dif > 60 

# Se procede a utilizar una prueba t de Student para dos muestras pareadas, dado que el tama�o de las muestras es muy peque�o, 
# y adem�s, las dos muestras son dependientes, ya que fueron tomadas de las mismas personas. Cada observaci�n de una muestra tiene una 
# correspondencia con una  observaci�n de la otra muestra.

# Verificamos el cumplimiento de las condiciones para utilizar una prueba t para muestras pareadas:
# 1.- El conjunto de instancias posibles es muy grande y las 10 seleccionadas no superan el 10% de la poblaci�n, por 
# lo que se puede suponer que las observaciones son independientes. Adem�s, las muestras provienen de un estudio.

# 2.- Al construir un gr�fico Q-Q para las diferencias, se puede observar que si bien los puntos de la muestra
# no forman una recta, no se observan valores at�picos que se alejen de la regi�n aceptable. Adem�s,
# al aplicar una prueba de normalidad de Shapiro-Wilk se obtiene un valor p = 0.1389, el cual es un valor 
# mayor a nuestro nivel de significaci�n (0.05), por lo que podemos concluir que la diferencia del 
# contenido total de minerales en los huesos del cuerpo se acerca razonablemente a una distribuci�n normal.

# Por lo tanto, se procede a usar una prueba t de Student para muestras pareadas con un nivel de confianza del 95%.

# Observaci�n: dado que es una hip�tesis unilateral, el par�metro "alternative" de t.test toma el valor de "greater", 
# ya que la media de la poblaci�n es mayor que el valor nulo en la hip�tesis alternativa.

# ********************* C�DIGO EN R PREGUNTA 2 *********************
library(ggpubr)

# Se carga el conjunto de datos

texto1 <- "1928 2549 2825 1924 1628 2175 2114 2621 1843 2541"
texto2 <- "2126 2885 2895 1942 1750 2184 2164 2626 2006 2627"


fileLact <- textConnection(texto1)
filePos <- textConnection(texto2)

lactancia <- scan(fileLact)
posdes <- scan(filePos)

# Fijamos el valor nulo
valor_nulo = 60

#Se calcula la diferencia entre las muestras Posdestete y Lactancia
diferencia <- posdes - lactancia

# Construir gr�fico Q-Q
datos <- data.frame(diferencia)
g <- ggqqplot(datos, x = "diferencia", color = "Steelblue", xlab = "Te�rico", ylab = "Muestra",
              title = "Gr�fico Q-Q muestra v/s distr. normal")
print(g)

# Se realiza la prueba de Shapiro-Wilk para ver si la distribuci�n se acerca a una normal
normalidad <- shapiro.test(diferencia)
print(normalidad)


#Asignamos el nivel de significancia a utilizar
alfa <- 0.05

#Se aplica la prueba t de Student para estas muestras pareadas
prueba <- t.test(x = posdes,
                 y = lactancia,
                 paired = TRUE,
                 alternative = "greater",
                 mu = valor_nulo,
                 conf.level = 1- alfa)

print(prueba)         

# ********************* CONCLUSIONES PREGUNTA 2 *********************

# Los resultados obtenidos al aplicar la prueba t de Student son los siguientes:
# El valor para el estad�stico de prueba T es t = 1.3917
# Se consideran df = 9 grados de libertad para la distribuci�n t.
# El valor p obtenido es p = 0.09873
# El intervalo de confianza obtenido es [45.50299; Inf)
# La media de la muestra es = 105.7

# Como se puede notar, la media de las diferencias se encuentra dentro del intervalo de confianza,
# y adem�s el valor p es mayor que el nivel de significaci�n (0.09873 > 0.01), por lo que se falla 
# al rechazar la hip�tesis nula. Por lo tanto, se puede afirmar con 95% de confianza que 
# pareciera que la diferencia entre el contenido total de minerales en los huesos del cuerpo durante el posdestete
# y el contenido total de minerales en los huesos del cuerpo durante la lactancia es igual a 60 g.
# Aunque ser�a necesario conseguir una muestra m�s grande para tener mayor certeza, 
# puesto que la muestra es demasiado peque�a.





# ****************************************** ENUNCIADO PREGUNTA 3 ******************************************
# La avicultura de carne es un negocio muy lucrativo, y cualquier m�todo que ayude al r�pido crecimiento de
# los pollitos es beneficioso, tanto para las av�colas como para los consumidores. En el paquete datasets
# de R est�n los datos (chickwts) de un experimento hecho para medir la efectividad de varios
# suplementos alimenticios en la tasa de crecimiento de las aves. Pollitos reci�n nacidos se separaron
# aleatoriamente en 6 grupos, y a cada grupo se le dio un suplemento distinto. Para productores de la 7ma
# regi�n, es especialmente importante saber si existe diferencia en la efectividad entre el suplemento
# basado en linaza (linseed) y el basado en habas (horsebean).

# Formulaci�n de las hip�tesis:
# H0: no existe diferencia en la efectividad promedio entre el suplemento basado en linaza y el basado en habas.
# HA: existe diferencia en la efectividad promedio entre el suplemento basado en linaza y el basado en habas.

# Matem�ticamente:
# Si �l y �h son las efectividades medias de los suplementes basados en linaza y habas, respectivamente, entonces:
# H0: �l = �h
# HA: �l ??? �h (ul distinto de uh)

# Se procede a utilizar una prueba t de Student para 2 muestras independientes, dado que las observaciones no tienen
# relaci�n con ninguna de las otras observaciones, ni influyen en su selecci�n, ni en la misma muestra ni en
# la otra muestra.

# Verificamos el cumplimiento de las condiciones para utilizar una prueba t de Student
# para 2 muestras independientes:
# Ambas muestras son independientes entre s�, ya que son diferentes pollitos y fueron designados aleatoriamente
# a cada grupo. Adem�s, se puede decir que las observaciones son independientes, dado que cada muestra es mucho menor a la
# poblaci�n total de pollitos. 
# Por otro lado, al construir un gr�fico Q-Q para cada muestra, se puede observar s�lo un valor at�pico para el 
# caso de las habas, Sin embargo,
# al aplicar a cada muestra la prueba de Shapiro-Wilk, se obtiene un p = 0.9035 para la muestra de suplemento basado en linaza
# y un p = 0.5264 para la muestra de suplemento basado en habas. En ambos casos, el valor de p es lo suficientemente mayor 
# al nivel de significaci�n (0.01) para concluir que ambas muestras provienen de poblaciones que se distribuyen
# de forma cercana a la normal.

# Por lo tanto, se procede a usar una prueba t de Student para dos muestras independientes con un nivel de confianza del 99%, 
# ya que para productores de la 7ma regi�n, es especialmente importante saber si existe diferencia en la efectividad 
# entre el suplemento basado en linaza y el basado en habas, por lo que se necesita ser m�s exigentes. 

# Observaci�n: dado que es una hip�tesis bilateral, el par�metro "alternative" de t.test toma el valor de "two.sided"

# ********************* C�DIGO EN R PREGUNTA 3 *********************
library(datasets)
library(dplyr)
library(ggpubr)

#Carga de datos
datos <- chickwts

#Se filtra la efectividad para el suplemento basado en linaza
linaza <- datos %>% filter ( feed == "linseed")

#Se filtra la efectividad para el suplemento basado en habas
habas <- datos %>% filter ( feed == "horsebean")


# Construir gr�fico Q-Q para efectividad basada en linaza
datos1 <- data.frame(linaza[["weight"]])
g1 <- ggqqplot(datos1,x="linaza...weight...",color = "Steelblue", xlab = "Te�rico", ylab = "Muestra",
               title = "Gr�fico Q-Q muestra v/s distr. normal (Linaza)")
print(g1)

# Construir gr�fico Q-Q para efectividad basada en habas
datos2 <- data.frame(habas[["weight"]])
g2 <- ggqqplot(datos2,x="habas...weight...",color = "Steelblue", xlab = "Te�rico", ylab = "Muestra",
               title = "Gr�fico Q-Q muestra v/s distr. normal (Habas)")
print(g2)

#Se verifica si las muestras se distribuyen de manera cercana a la normal 
normalidad_l <- shapiro.test(linaza[["weight"]])
print(normalidad_l)

normalidad_h <- shapiro.test(habas[["weight"]])
print(normalidad_h)

#Se asigna un valor de significaci�n de 0.01 en vista de que es importante la precisi�n
alfa <- 0.01

#Se aplica la prueba t de Student para 2 muestras independientes
prueba3 <- t.test(x = linaza[["weight"]],
                  y = habas[["weight"]],
                  paired = FALSE ,
                  alternative = "two.sided",
                  mu = 0 ,
                  conf.level = 1 - alfa)
print(prueba3)

# Se calcula la diferencia entre las medias
media_l <- mean(linaza[["weight"]])
media_h <- mean(habas[["weight"]])
diferencia <- media_l - media_h
cat("Diferencias de las medias = ", diferencia, "[g]\n")

# ********************* CONCLUSIONES PREGUNTA 3 *********************
# Los resultados obtenidos al aplicar la prueba t de Student son los siguientes:
# El valor para el estad�stico de prueba T es t = 3.0172
# Se consideran df = 19.769 grados de libertad para la distribuci�n t.
# El valor p obtenido es p = 0.006869
# El intervalo de confianza obtenido es [3.267538; 113.832462]
# La media de la muestra para linaza es =  218.75
# La media de la muestra para habas es = 160.20 
# Diferencia de las medias =  58.55

# Como el valor de p es menor al nivel de significaci�n (0.900686 < 0.01), se puede decir que 
# la evidencia en favor de HA es fuerte, por lo que se rechaza la hip�tesis nula.

# Por lo tanto, podemos concluir con un 99% de confianza que s� existe diferencia en la efectividad 
# promedio entre el suplemento basado en linaza y el suplemento basado en habas.