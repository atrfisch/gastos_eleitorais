### set wd

setwd("C:/Users/Arthur/Dropbox/Tese Doutorado/Parte Quantitativa/Data")
require(data.table)
require(dplyr)

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

cg14 <- filter(cand14, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL" )
cg10 <- filter(cand10, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")
cg06 <- filter(cand06, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")
cg02 <- filter(cand02, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")

## consolidacao dos gastos por deputado
## 2014
gastos_2014 <-cg14 %>% 
  group_by(ID, cpf, uf, cargo, descsitu, resultado, sqncial, partido, nome ) %>% 
  summarise(despesa = sum(despesa_real))

## 2010
gastos_2010 <-cg10 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real))

## 2006
gastos_2006 <-cg06 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real))

## 2002
gastos_2002 <-cg02 %>% 
  group_by(ID, cpf, uf,cargo, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real))



###################################
### desigualdade nas camapanhas ###
###################################

library(ineq)

cg14 <- filter(gastos_2014, cargo == "DEPUTADO FEDERAL" )
cg10 <- filter(gastos_2010, cargo == "DEPUTADO FEDERAL" )
cg06 <- filter(gastos_2006, cargo == "DEPUTADO FEDERAL" )
cg02 <- filter(gastos_2002, cargo == "DEPUTADO FEDERAL" )


## somente candidatos deferidos

#cg14 <- cg14 %>% 
#  filter(!((is.na(despesa))))


#cg10 <- cg10 %>% 
#  filter(!((is.na(despesa))))

#cg06 <- cg06 %>% 
#  filter(!((is.na(despesa))))

#cg02 <- cg02 %>% 
#  filter(!((is.na(despesa))))

#cg10 <- cg10 %>% 
#  filter(descsitu == "DEFERIDO")

# calculo de gini

gini02 <- ineq(cg02$despesa,type="Gini")
gini06 <- ineq(cg06$despesa,type="Gini")
gini10 <- ineq(cg10$despesa,type="Gini")
gini14 <- ineq(cg14$despesa,type="Gini")

#curva de lorenz
plot(Lc(cg02$despesa),col="darkred",lwd=2, main="Lorenz Curve 2002")
plot(Lc(cg06$despesa),col="darkred",lwd=2, main="Lorenz Curve 2006")
plot(Lc(cg10$despesa),col="darkred",lwd=2, main="Lorenz Curve 2010")
plot(Lc(cg14$despesa),col="darkred",lwd=2, main="Lorenz Curve 2014")