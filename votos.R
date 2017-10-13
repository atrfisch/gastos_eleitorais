### Cands
require(data.table)
require(dplyr)

### 2014
setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/votos_2014")


votos14 = list.files(pattern = "votacao_candidato_munzona_2014_.*\\.txt") 
votos14df = lapply (votos14,  function(x) {
  tryCatch(read.table(x, header = FALSE, sep = ";", dec = ",", fill = TRUE), error=function(e) NULL)
})


votos14 <- do.call(rbind, votos14df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
save(votos14, file ="votos14.RDATA")
rm(list = ls())


### 2010
setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/votos_2010")


votos10 = list.files(pattern = "votacao_candidato_munzona_2010_.*\\.txt") 
votos10df = lapply (votos10,  function(x) {
  tryCatch(read.table(x, header = FALSE, sep = ";", dec = ",", fill = TRUE), error=function(e) NULL)
})


votos10 <- do.call(rbind, votos10df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
save(votos10, file ="votos10.RDATA")
rm(list = ls())


### 2006
setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/votos_2006")


votos06 = list.files(pattern = "votacao_candidato_munzona_2006_.*\\.txt") 
votos06df = lapply (votos06,  function(x) {
  tryCatch(read.table(x, header = FALSE, sep = ";", dec = ",", fill = TRUE), error=function(e) NULL)
})


votos06 <- do.call(rbind, votos06df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
save(votos06, file ="votos06.RDATA")
rm(list = ls())

### 2002
setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/votos_2002/votos_2002/")


votos02 = list.files(pattern = "votacao_candidato_munzona_2002_.*\\.txt") 
votos02df = lapply (votos02,  function(x) {
  tryCatch(read.table(x, header = FALSE, sep = ";", dec = ",", fill = TRUE), error=function(e) NULL)
})


votos02 <- do.call(rbind, votos02df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
save(votos02, file ="votos02.RDATA")
rm(list = ls())
