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

#cg14 <- filter(cand14, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL" )
#cg10 <- filter(cand10, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")
#cg06 <- filter(cand06, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")
#cg02 <- filter(cand02, cargo == "DEPUTADO FEDERAL" | cargo == "DEPUTADO ESTADUAL" | cargo == "DEPUTADO DISTRITAL")


## mesclando deputado estadual e distrital

cg14 <- mutate(cand14, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg10 <- mutate(cand10, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg06 <- mutate(cand06, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg02 <- mutate(cand02, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))


## consolidacao dos gastos por deputado
## 2014
gastos_2014 <-cg14 %>% 
  group_by(ID, cpf, uf, cargo2, descsitu, resultado, sqncial, partido, nome ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2010
gastos_2010 <-cg10 %>% 
  group_by(ID, cpf, uf,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2006
gastos_2006 <-cg06 %>% 
  group_by(ID, cpf, uf,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2002
gastos_2002 <-cg02 %>% 
  group_by(ID, cpf, uf,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

### eleitos

ele_cand14 <- gastos_2014 %>% 
  filter(resultado == "ELEITO POR QP" | resultado == "ELEITO POR MÉDIA" | resultado == "ELEITO")

ele_cand10 <- gastos_2010 %>% 
  filter(resultado == "ELEITO" | resultado =="MÉDIA")

ele_cand06 <- gastos_2006 %>% 
  filter(resultado == "ELEITO" | resultado == "MÉDIA")

ele_cand02 <- gastos_2002 %>% 
  filter(resultado == "ELEITO" | resultado == "ELEITO POR MÉDIA" )


### calculo das medias por anos e cargos

resultstot14 <- ele_cand14 %>%
  group_by( cargo2) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot10 <- ele_cand10 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot06 <- ele_cand06 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE),  n = n(), total=sum(despesa, na.rm=TRUE))

resultstot02 <- ele_cand02 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

###########

# Verificação para deputados

cg14 <- filter(gastos_2014, cargo2 == "DEPUTADO FEDERAL" )
cg10 <- filter(gastos_2010, cargo2 == "DEPUTADO FEDERAL" )
cg06 <- filter(gastos_2006, cargo2 == "DEPUTADO FEDERAL" )
cg02 <- filter(gastos_2002, cargo2 == "DEPUTADO FEDERAL" )

###
cg14 <-mutate(cg14, resultado2 = ifelse(resultado=="ELEITO POR QP","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
cg10 <-mutate(cg10, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
cg06 <-mutate(cg06, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))
cg02 <-mutate(cg02, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito", ifelse(resultado=="SUPLENTE","Não eleito","Não eleito"))))


### result
resultstot14 <- cg14 %>%
  group_by( resultado2) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot10 <- cg10 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot06 <- cg06 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE),  n = n(), total=sum(despesa, na.rm=TRUE))

resultstot02 <- cg02 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE)  )


###
resultstot14 <- cg14 %>%
  group_by( cargo2) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot10 <- cg10 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE))

resultstot06 <- cg06 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE),  n = n(), total=sum(despesa, na.rm=TRUE))

resultstot02 <- cg02 %>%
  group_by( cargo2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n(), total=sum(despesa, na.rm=TRUE)  )



## histogramas

library(ggplot2)

# tirando os NAs
cg14 <- cg14 %>% 
  filter(resultado == "ELEITO POR QP" | resultado == "ELEITO POR MÉDIA" | resultado == "ELEITO")

cg10 <- cg10 %>% 
  filter(resultado == "ELEITO" | resultado =="MÉDIA")

cg06 <- cg06 %>% 
  filter(resultado == "ELEITO" | resultado == "MÉDIA")

cg02 <- cg02 %>% 
  filter(resultado == "ELEITO" | resultado == "ELEITO POR MÉDIA" )



ggplot(data=cg14, aes(cg14$despesa)) + geom_histogram(aes(y = ..count..)) +
  geom_vline(aes(xintercept=mean(cg14$despesa)),color="red", size=1, linetype="dashed")+
  scale_x_continuous(name = "Campaign Expenditure",labels = scales::comma, limits=c(0, 4000000)) +
  scale_y_continuous(name = "Count") +
  ggtitle("2014 Election")


ggplot(data=cg10, aes(cg10$despesa)) + geom_histogram(aes(y = ..count..)) +
  geom_vline(aes(xintercept=mean(cg10$despesa)),color="red", size=1, linetype="dashed")+
      scale_x_continuous(name = "Campaign Expenditure",labels = scales::comma, limits=c(0, 4000000)) +
  scale_y_continuous(name = "Count") +
  ggtitle("2010 Election")


ggplot(data=cg06, aes(cg06$despesa)) + geom_histogram(aes(y = ..count..)) +
  geom_vline(aes(xintercept=mean(cg06$despesa)),color="red", size=1, linetype="dashed")+
    scale_x_continuous(name = "Campaign Expenditure",labels = scales::comma, limits=c(0, 4000000)) +
  scale_y_continuous(name = "Count") +
  ggtitle("2006 Election")


cgt02 <- cg02 %>% 
  filter(!((is.na(despesa))))

ggplot(data=cgt02, aes(cgt02$despesa)) + geom_histogram(aes(y = ..count..)) +
  geom_vline(aes(xintercept=mean(cgt02$despesa)),color="red", size=1, linetype="dashed")+
      scale_x_continuous(name = "Campaign Expenditure",labels = scales::comma, limits=c(0, 4000000)) +
  scale_y_continuous(name = "Count") +
  ggtitle("2002 Election")



###

r14 <-cg14 %>%
group_by( partido) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r10 <-cg10 %>%
  group_by( partido) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r06 <-cg06 %>%
  group_by( partido) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r02 <-cg02 %>%
  group_by( partido) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

### estado
r14 <-cg14 %>%
  group_by( uf) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r10 <-cg10 %>%
  group_by( uf) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r06 <-cg06 %>%
  group_by( uf) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

r02 <-cg02 %>%
  group_by( uf) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())


# calculo por estado e partido
tabela_uf <- cbind (r02, r06, r10, r14)
colnames(tabela_uf)[1:12]<-c("uf", "2002", "n2002", "uf06", "2006","n2006", "uf10", "2010", "n2010", "uf14","2014" ,"n2014")

tabela_uf$n2002<-NULL
tabela_uf$uf06<-NULL
tabela_uf$n2006<-NULL
tabela_uf$uf10<- NULL
tabela_uf$n2010<- NULL
tabela_uf$uf14<- NULL
tabela_uf$n2014 <- NULL

classific_uf <- read.csv("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/classific_uf.csv", header=T, sep=";")

tabela_uf <- merge(x=tabela_uf, y=classific_uf, by.x="uf", by.y="UF")


lm1 <- lm(tabela_uf$`2002` ~ tabela_uf$M)
summary(lm1)

lm2 <- lm(tabela_uf$`2006` ~ tabela_uf$M)
summary(lm2)

lm3 <- lm(tabela_uf$`2010` ~ tabela_uf$M)
summary(lm3)

lm4 <- lm(tabela_uf$`2014` ~ tabela_uf$M)
summary(lm4)


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