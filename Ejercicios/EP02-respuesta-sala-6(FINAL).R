
#Se asume que el archivo a leer y este documento est�n en el escritorio

#Se setea el directorio donde se encuentra el script
library(dplyr)
library(ggpubr)
dir <- "E:/IME"
base <- "Casen 2017 (4).csv"
arch <- file.path(dir, base)

# Se realiza la lectura de los datos, se escpecifica el formato de codificaci�n UTF-8
datos <- read.csv(arch, fileEncoding = "UTF-8")

#Se realiza el filtro de mujeres en los datos

cuartiles <- quantile(datos[["ytot"]], na.rm = TRUE)
cuartiles

datos2 <- datos %>% filter(sexo == "Mujer",region == "Regi�n Metropolitana de Santiago", ytot>cuartiles[2] & ytot < cuartiles[4])

#Se grafican los datos, edad vs ingresos
g <- ggscatter(datos2,
               x = "edad",
               y = "ytot"
               )

print(g)
#Para responder la pregunta se escogen como medidas la covarianza, pues permite calcular la relaci�n lineal entre dos variables (Fuente: https://www.cienciadedatos.net/documentos/pystats05-correlacion-lineal-python.html); y por otro lado los rangos intercuartiles,
#con los cuales es posible separar los datos en grupos m�s peque�os.
medidas_respuestas <-datos2 %>% summarise(Covarianza = cov(edad, ytot))

#En cuanto al gr�fico, se decide usar un gr�fico de dispersi�n, pero dada la existencia de datos at�pico (ingresos muy grandes o muy peque�os; fuera del com�n)
#que dificultan el an�lisis del conjunto de datos y cayendo en imprecisi�n, se usan los datos que se encuentran en el rango intercuart�lico. 
#Si se analiza este grafico, no se logra apreciar una relacion clara entre las variables edad e ingreso, por lo cual se concluye que son variables independientes.


