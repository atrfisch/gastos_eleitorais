### Cands
require(data.table)
require(dplyr)

### 2014
setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data/Cand 2014")


cand14 = list.files(pattern = "consulta_cand_2014_.*\\.txt") 
cand14df = lapply (cand14,  function(x) {
  tryCatch(read.table(x, header = FALSE, sep = ";", dec = ",", fill = TRUE), error=function(e) NULL)
})


cand14 <- do.call(rbind, cand14df)

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data")
save(cand14, file ="cand14.RDATA")
rm(list = ls())

### 2010

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data/Cand 2010")

cand10 = list.files(pattern = "consulta_cand_2010_.*\\.txt") 
cand10df = lapply (cand10, read.table, header=FALSE, sep = ";", dec = ",", fill = TRUE)

cand10 <- do.call(rbind, cand10df)

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data")
save(cand10, file ="cand10.RDATA")
rm(list = ls())

### 2006

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data/Cand 2006")

cand06 = list.files(pattern = "consulta_cand_2006_.*\\.txt") 
cand06df = lapply (cand06, read.table, header=FALSE, sep = ";", dec = ",", fill = TRUE)

cand06 <- do.call(rbind, cand06df)

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data")
save(cand06, file ="cand06.RDATA")
rm(list = ls())

### 2002

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data/Cand 2002")

cand02 = list.files(pattern = "consulta_cand_2002_.*\\.txt") 
cand02df = lapply (cand02, read.table, header=FALSE, sep = ";", dec = ",", fill = TRUE)

cand02 <- do.call(rbind, cand02df)

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data")
save(cand02, file ="cand02.RDATA")
rm(list = ls())