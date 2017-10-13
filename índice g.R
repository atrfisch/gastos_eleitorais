### set wd

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)
library(readxl)

rm(list=ls())

options(scipen=999) # supressing scientific notation
par(mar=c(5.1,4.1,4.1,2.1)) 
par(mfrow=c(1,1))

#2014
load(file="scvg14.RDATA")

#2010
load(file="scvg10.RDATA")

#2006
load(file="scvg06.RDATA")

#2002
load(file="scvg02.RDATA")

# abrindo os valores do indice g

g02 <- read_excel("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/indice_g/2002_mun.xlsx", 
                        col_types = c("text", "numeric", "text", 
                                      "numeric", "text", "numeric"))

g06 <- read_excel("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/indice_g/2006_mun.xlsx", 
                      col_types = c("text", "numeric", "text", 
                                    "numeric", "text", "numeric"))

g10 <- read_excel("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/indice_g/2010_mun.xlsx", 
                      col_types = c("text", "numeric", "text", 
                                    "numeric", "text", "numeric"))

g14 <- read_excel("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/indice_g/2014_mun.xlsx", 
                      col_types = c("text", "numeric", "text", 
                                    "numeric", "text", "numeric"))




colnames(g02)[1]<-"uf"
colnames(g06)[1]<-"uf"
colnames(g10)[1]<-"uf"
colnames(g14)[1]<-"uf"

g02$nome<-NULL
g02$resultado_cod <- NULL
g02$resultado_des <- NULL

g06$nome<-NULL
g06$resultado_cod <- NULL
g06$resultado_des <- NULL

g10$nome<-NULL
g10$resultado_cod <- NULL
g10$resultado_des <- NULL

g14$nome<-NULL
g14$resultado_cod <- NULL
g14$resultado_des <- NULL

### merging information

base02 <-merge(x= scvg02, y=g02, by.x=c("uf","NUMERO_CAND"), by.y=c("uf","nr_votavel"), all.x=TRUE)
base06 <-merge(x= scvg06, y=g06, by.x=c("uf","NUMERO_CAND"), by.y=c("uf","nr_votavel"), all.x=TRUE)
base10 <-merge(x= scvg10, y=g10, by.x=c("uf","NUMERO_CAND"), by.y=c("uf","nr_votavel"), all.x=TRUE)
base14 <-merge(x= scvg14, y=g14, by.x=c("uf","NUMERO_CAND"), by.y=c("uf","nr_votavel"), all.x=TRUE)

### correlacoes

#all candidates

corr02 <- base02 %>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

corr06 <- base06 %>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

corr10 <- base10 %>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

corr14 <- base14 %>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

### cand eleitos e n eleitos

base14 <-mutate(base14, resultado3 = ifelse(resultado=="ELEITO POR QP","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
base10 <-mutate(base10, resultado3 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
base06 <-mutate(base06, resultado3 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
base02 <-mutate(base02, resultado3 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito", ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))

ncorr02 <- base02 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

ncorr06 <- base06 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

ncorr10 <- base10 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

ncorr14 <- base14 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

### selected candidates

compet02 <- base02 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet06 <- base06 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet10 <- base10 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet14 <- base14 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

## calculos

scorr02 <- compet02 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

scorr06 <- compet06 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

scorr10 <- compet10 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))

scorr14 <- compet14 %>%
  group_by(resultado3)%>%
  filter(!(is.na(despesa)))%>%
  filter(!(is.na(G)))%>%         
  summarise(corr = cor(despesa, G))


### regressao efeitos fixos
library(plm)

plm02 <-plm(G ~ despesa, data=base02, index=c("uf"), model="within")
summary(plm02)

plm06 <-plm(G ~ despesa, data=base06, index=c("uf"), model="within")
summary(plm06)

plm10 <-plm(G ~ despesa, data=base10, index=c("uf"), model="within")
summary(plm10)

plm14 <-plm(G ~ despesa, data=base14, index=c("uf"), model="within")
summary(plm14)

base02$ldespesa <- log10(base02$despesa)
base06$ldespesa <- log10(base06$despesa)
base10$ldespesa <- log10(base10$despesa)
base14$ldespesa <- log10(base14$despesa)

plm02 <-plm(G ~ ldespesa, data=base02, index=c("uf"), model="within")
summary(plm02)

plm06 <-plm(G ~ ldespesa, data=base06, index=c("uf"), model="within")
summary(plm06)

plm10 <-plm(G ~ ldespesa, data=base10, index=c("uf"), model="within")
summary(plm10)

plm14 <-plm(G ~ ldespesa, data=base14, index=c("uf"), model="within")
summary(plm14)

library(foreign)
write.dta(base02, "base02.dta")


rbase02 <- base02 %>%
  filter(!(is.na(despesa)))

rbase06 <- base06 %>%
  filter(!(is.na(despesa)))

rbase10 <- base10 %>%
  filter(!(is.na(despesa)))

rbase14 <- base14 %>%
  filter(!(is.na(despesa)))