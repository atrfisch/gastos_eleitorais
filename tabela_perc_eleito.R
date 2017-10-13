### set wd

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)
library(ineq)

## loading databases

#2014
load(file="cg14.RDATA")

#2010
load(file="cg10.RDATA")

#2006
load(file="cg06.RDATA")

#2002
load(file="cg02.RDATA")

##filter

cg14 <- filter(cand14, cargo == "DEPUTADO FEDERAL" )
cg10 <- filter(cand10, cargo == "DEPUTADO FEDERAL" )
cg06 <- filter(cand06, cargo == "DEPUTADO FEDERAL" )
cg02 <- filter(cand02, cargo == "DEPUTADO FEDERAL" )


## consolidacao dos gastos por deputado
## 2014
gastos_2014 <-cg14 %>% 
  group_by(ID, cpf, uf, cargo, descsitu, resultado, sqncial, partido, nome ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2010
gastos_2010 <-cg10 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2006
gastos_2006 <-cg06 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2002
gastos_2002 <-cg02 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

##Total UF

uf_2014 <- gastos_2014 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_2010 <- gastos_2010 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_2006 <- gastos_2006 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_2002 <- gastos_2002 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))


#BR

bruf_2014 <- gastos_2014 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_2010 <- gastos_2010 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_2006 <- gastos_2006 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_2002 <- gastos_2002 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))


## eleitos 

ele_cand14 <- gastos_2014 %>% 
  filter(resultado == "ELEITO POR QP" | resultado == "ELEITO POR MÉDIA" | resultado == "ELEITO")

ele_cand10 <- gastos_2010 %>% 
  filter(resultado == "ELEITO" | resultado =="MÉDIA")

ele_cand06 <- gastos_2006 %>% 
  filter(resultado == "ELEITO" | resultado == "MÉDIA")

ele_cand02 <- gastos_2002 %>% 
  filter(resultado == "ELEITO" | resultado == "ELEITO POR MÉDIA" )

## uf ele

uf_ele2014 <- ele_cand14 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_ele2010 <- ele_cand10 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_ele2006 <- ele_cand06 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

uf_ele2002 <- ele_cand02 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( uf) %>% 
  summarise(despesa = sum(despesa))

#br

bruf_ele2014 <- ele_cand14 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_ele2010 <- ele_cand10 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_ele2006 <- ele_cand06 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

bruf_ele2002 <- ele_cand02 %>% 
  filter(!(is.na(despesa)))%>% 
  group_by( cargo) %>% 
  summarise(despesa = sum(despesa))

#
valor_br02 <- (bruf_ele2002$despesa/bruf_2002$despesa)
valor_br06 <- (bruf_ele2006$despesa/bruf_2006$despesa)
valor_br10 <- (bruf_ele2010$despesa/bruf_2010$despesa)
valor_br14 <- (bruf_ele2014$despesa/bruf_2014$despesa)

# perc_ele

perc_ele14 <- merge( x= uf_2014, y=uf_ele2014, by="uf")
perc_ele14$perc <- perc_ele14$despesa.y/perc_ele14$despesa.x
perc_ele14$despesa.x<-NULL
perc_ele14$despesa.y<-NULL
colnames(perc_ele14) <- c("uf4","2014")

perc_ele10 <- merge( x= uf_2010, y=uf_ele2010, by="uf")
perc_ele10$perc <- perc_ele10$despesa.y/perc_ele10$despesa.x
perc_ele10$despesa.x<-NULL
perc_ele10$despesa.y<-NULL
colnames(perc_ele10) <- c("uf2","2010")

perc_ele06 <- merge( x= uf_2006, y=uf_ele2006, by="uf")
perc_ele06$perc <- perc_ele06$despesa.y/perc_ele06$despesa.x
perc_ele06$despesa.x<-NULL
perc_ele06$despesa.y<-NULL
colnames(perc_ele06) <- c("uf3","2006")

perc_ele02 <- merge( x= uf_2002, y=uf_ele2002, by="uf")
perc_ele02$perc <- perc_ele02$despesa.y/perc_ele02$despesa.x
perc_ele02$despesa.x<-NULL
perc_ele02$despesa.y<-NULL
colnames(perc_ele02) <- c("uf","2002")

tabela_perc <- cbind(perc_ele02, perc_ele06, perc_ele10, perc_ele14)
tabela_perc$uf2 <- NULL
tabela_perc$uf3 <- NULL
tabela_perc$uf4 <- NULL

classific_uf <- read.csv("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/classific_uf.csv", header=T, sep=";")

tabela_perc <- merge(x=tabela_perc, y=classific_uf, by.x="uf", by.y="UF")



lm1 <- lm(tabela_perc$`2002` ~ tabela_perc$M)
summary(lm1)

lm2 <- lm(tabela_perc$`2006` ~ tabela_perc$M)
summary(lm2)

lm3 <- lm(tabela_perc$`2010` ~ tabela_perc$M)
summary(lm3)

lm4 <- lm(tabela_perc$`2014` ~ tabela_perc$M)
summary(lm4)

write.csv(tabela_perc, "tabela_perc.csv")

## regiao

classific_uf <- read.csv("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/classific_uf.csv", header=T, sep=";")

perc_ele02 <- merge(x=perc_ele02, y=classific_uf, by.x="uf", by.y="UF")
perc_ele06 <- merge(x=perc_ele06, y=classific_uf, by.x="uf", by.y="UF")
perc_ele10 <- merge(x=perc_ele10, y=classific_uf, by.x="uf", by.y="UF")
perc_ele14 <- merge(x=perc_ele14, y=classific_uf, by.x="uf", by.y="UF")

regiao02 <- perc_ele02 %>% 
  group_by( REGIAO)%>%
  summarize(perc=mean(perc))

regiao06 <- perc_ele06 %>% 
  group_by( REGIAO)%>%
  summarize(perc= mean(perc))

regiao10 <- perc_ele10 %>% 
  group_by( REGIAO)%>%
  summarize(perc=mean(perc))

regiao14 <- perc_ele14 %>% 
  group_by( REGIAO)%>%
  summarize(perc=mean(perc))

colnames(regiao02) <- c("regiao","2002")
colnames(regiao06) <- c("uf2","2006")
colnames(regiao10) <- c("uf3","2010")
colnames(regiao14) <- c("uf4","2014")

tabela_perc_regiao <- cbind(regiao02, regiao06, regiao10, regiao14)
tabela_perc_regiao$uf2 <- NULL
tabela_perc_regiao$uf3 <- NULL
tabela_perc_regiao$uf4 <- NULL

write.csv(tabela_perc_regiao, "tabela_perc_regiao.csv")