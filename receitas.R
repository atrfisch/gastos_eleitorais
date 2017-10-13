### Gastos 2014 ###

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2014")
require(data.table)
require(dplyr)

###

receitas14 = list.files(pattern = "receitas_candidatos_2014_.*\\.txt") 
receitas14df = lapply(receitas14, read.table, header=TRUE, sep = ";", dec = ",")
save(receitas14df, file ="receitas14.RDATA")

load(file = "receitas14.RDATA")
receitas_2014 <- do.call(rbind, receitas14df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/")
save(receitas_2014, file ="receitas_2014.RDATA")
rm(list = ls())

### Gastos 2010 ###

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2010")
require(data.table)
require(dplyr)

###

receitas10 = list.files(pattern = "ReceitasCandidatos_.*\\.txt") 
receitas10df = lapply(receitas10, read.table, header=TRUE, sep = ";", dec = ",")
save(receitas10df, file ="receitas10.RDATA")

load(file = "receitas10.RDATA")
receitas_2010 <- do.call(rbind, receitas10df)

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/")
save(receitas_2010, file ="receitas_2010.RDATA")
rm(list = ls())

###2006

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2006")

receitas_2006<-read.csv(file="C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2006/ReceitaCandidato.csv", header=TRUE, sep = ";", dec = ",")

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/")
save(receitas_2006, file ="receitas_2006.RDATA")
rm(list = ls())

###2002

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2002")

receitas_2002<-read.csv(file="C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/receitas_2002/ReceitaCandidato.csv", header=TRUE, sep = ";", dec = ",")

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/")
save(receitas_2002, file ="receitas_2002.RDATA")
rm(list = ls())
