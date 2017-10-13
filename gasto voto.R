## Tabelas Gastos por votos

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)

rm(list=ls())

options(scipen=999) # supressing scientific notation
par(mar=c(5.1,4.1,4.1,2.1)) 
par(mfrow=c(1,1))

#2014
load(file="cvg14.RDATA")

#2010
load(file="cvg10.RDATA")

#2006
load(file="cvg06.RDATA")

#2002
load(file="cvg02.RDATA")


#### filtrando eleitos e 1 turno

cvg14 <-mutate(cvg14, resultado2 = ifelse(resultado=="ELEITO POR QP","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito",ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito")))))
cvg10 <-mutate(cvg10, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))
cvg06 <-mutate(cvg06, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))
cvg02 <-mutate(cvg02, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito", ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))

#filtros

ele_14 <- cvg14 %>%
  filter(resultado2=="Eleito" & (CODIGO_CARGO==1 |CODIGO_CARGO==3|CODIGO_CARGO==5|CODIGO_CARGO==6|CODIGO_CARGO==7|CODIGO_CARGO==8))

ele_10 <- cvg10 %>%
  filter(resultado2=="Eleito")

ele_06 <- cvg06 %>%
  filter(resultado2=="Eleito" )

ele_02 <- cvg02 %>%
  filter(resultado2=="Eleito" )

oq_02<-ele_02 %>%
  group_by(cargo2)%>%
  summarise(total=n())


oq_06<-ele_06 %>%
  group_by(cargo2)%>%
  summarise(total=n())


oq_10<-ele_10 %>%
  group_by(cargo2)%>%
  summarise(total=n())

oq_14<-ele_14 %>%
  group_by(cargo2)%>%
  summarise(total=n())

### dividindo gastos por votos

ele_02$gasto_vot <- ele_02$despesa/ele_02$VOTOS
ele_06$gasto_vot <- ele_06$despesa/ele_06$VOTOS
ele_10$gasto_vot <- ele_10$despesa/ele_10$VOTOS
ele_14$gasto_vot <- ele_14$despesa/ele_14$VOTOS

###

resultstot14 <- ele_14 %>%
  group_by( cargo2) %>%
  summarize ( media = mean(gasto_vot, na.rm=TRUE), n = n())

resultstot10 <- ele_10 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(gasto_vot, na.rm=TRUE), n = n())

resultstot06 <- ele_06 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(gasto_vot, na.rm=TRUE),  n = n())

resultstot02 <- ele_02 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(gasto_vot, na.rm=TRUE), n = n())
