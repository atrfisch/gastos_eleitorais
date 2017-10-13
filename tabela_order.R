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

### merging com magnitude

classific_uf <- read.csv("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/classific_uf.csv", header=T, sep=";")

gastos_2002 <- merge(x=gastos_2002, y=classific_uf, by.x="uf", by.y="UF")
gastos_2006 <- merge(x=gastos_2006, y=classific_uf, by.x="uf", by.y="UF")
gastos_2010 <- merge(x=gastos_2010, y=classific_uf, by.x="uf", by.y="UF")
gastos_2014 <- merge(x=gastos_2014, y=classific_uf, by.x="uf", by.y="UF")

## oredring por numero de votos

order_2002 <- gastos_2002 %>%
  arrange (uf, desc(despesa)) %>%
  group_by(uf) %>% 
  mutate(rank = rank(uf, ties.method = "first"))%>% 
  filter(rank<=M)

order_2006 <- gastos_2006 %>%
  arrange (uf, desc(despesa)) %>%
  group_by(uf) %>% 
  mutate(rank = rank(uf, ties.method = "first"))%>% 
  filter(rank<=M)

order_2010 <- gastos_2010 %>%
  arrange (uf, desc(despesa)) %>%
  group_by(uf) %>% 
  mutate(rank = rank(uf, ties.method = "first"))%>% 
  filter(rank<=M)

order_2014 <- gastos_2014 %>%
  arrange (uf, desc(despesa)) %>%
  group_by(uf) %>% 
  mutate(rank = rank(uf, ties.method = "first"))%>% 
  filter(rank<=M)

# order brasil


brorder_2002 <- gastos_2002 %>%
  arrange (cargo, desc(despesa)) %>%
  group_by(cargo) %>% 
  mutate(rank = rank(cargo, ties.method = "first"))%>% 
  filter(rank<=513)

brorder_2006 <- gastos_2006 %>%
  arrange (cargo, desc(despesa)) %>%
  group_by(cargo) %>% 
  mutate(rank = rank(cargo, ties.method = "first"))%>% 
  filter(rank<=513)

brorder_2010 <- gastos_2010 %>%
  arrange (cargo, desc(despesa)) %>%
  group_by(cargo) %>% 
  mutate(rank = rank(cargo, ties.method = "first"))%>% 
  filter(rank<=513)

brorder_2014 <- gastos_2014 %>%
  arrange (cargo, desc(despesa)) %>%
  group_by(cargo) %>% 
  mutate(rank = rank(cargo, ties.method = "first"))%>% 
  filter(rank<=513)


## contando os eleitos

###
order_2014 <-mutate(order_2014, resultado2 = ifelse(resultado=="ELEITO POR QP",1,ifelse(resultado=="ELEITO POR MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
order_2010 <-mutate(order_2010, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
order_2006 <-mutate(order_2006, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
order_2002 <-mutate(order_2002, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="ELEITO POR MÉDIA",1, ifelse(resultado=="SUPLENTE",0,0))))


brorder_2014 <-mutate(brorder_2014, resultado2 = ifelse(resultado=="ELEITO POR QP",1,ifelse(resultado=="ELEITO POR MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
brorder_2010 <-mutate(brorder_2010, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
brorder_2006 <-mutate(brorder_2006, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="MÉDIA",1,ifelse(resultado=="SUPLENTE",0,0))))
brorder_2002 <-mutate(brorder_2002, resultado2 = ifelse(resultado=="ELEITO",1,ifelse(resultado=="ELEITO POR MÉDIA",1, ifelse(resultado=="SUPLENTE",0,0))))


## contagem por uf

order_2002 <- order_2002 %>% 
    group_by(uf, M, REGIAO)%>%
    summarize(eleitos=sum(resultado2))
order_2002$perc_maisvot <- order_2002$eleitos/order_2002$M

order_2006 <- order_2006 %>% 
  group_by(uf, M, REGIAO)%>%
  summarize(eleitos=sum(resultado2))
order_2006$perc_maisvot <- order_2006$eleitos/order_2006$M

order_2010 <- order_2010 %>% 
  group_by(uf, M, REGIAO)%>%
  summarize(eleitos=sum(resultado2))
order_2010$perc_maisvot <- order_2010$eleitos/order_2010$M

order_2014 <- order_2014 %>% 
  group_by(uf, M, REGIAO)%>%
  summarize(eleitos=sum(resultado2))
order_2014$perc_maisvot <- order_2014$eleitos/order_2014$M


### BR


brorder_2002 <- brorder_2002 %>% 
  group_by(cargo)%>%
  summarize(eleitos=sum(resultado2))
brorder_2002$perc_maisvot <- brorder_2002$eleitos/513

brorder_2006 <- brorder_2006 %>% 
  group_by(cargo)%>%
  summarize(eleitos=sum(resultado2))
brorder_2006$perc_maisvot <- brorder_2006$eleitos/513

brorder_2010 <- brorder_2010 %>% 
  group_by(cargo)%>%
  summarize(eleitos=sum(resultado2))
brorder_2010$perc_maisvot <- brorder_2010$eleitos/513

brorder_2014 <- brorder_2014 %>% 
  group_by(cargo)%>%
  summarize(eleitos=sum(resultado2))
brorder_2014$perc_maisvot <- brorder_2014$eleitos/513


### tabela por uf

order_2002$REGIAO <- NULL
order_2002$eleitos <- NULL
colnames(order_2002) <- c("uf","m","2002")

order_2006$M <- NULL
order_2006$REGIAO <- NULL
order_2006$eleitos <- NULL
colnames(order_2006) <- c("uf2","2006")

order_2010$M <- NULL
order_2010$REGIAO <- NULL
order_2010$eleitos <- NULL
colnames(order_2010) <- c("uf3","2010")

order_2014$M <- NULL
order_2014$REGIAO <- NULL
order_2014$eleitos <- NULL
colnames(order_2014) <- c("uf4","2014")

tabela_order <- cbind(order_2002, order_2006, order_2010, order_2014)
tabela_order$uf2 <- NULL
tabela_order$uf3 <- NULL
tabela_order$uf4 <- NULL


lm1 <- lm(tabela_order$`2002` ~ tabela_order$m)
summary(lm1)

lm2 <- lm(tabela_order$`2006` ~ tabela_order$m)
summary(lm2)

lm3 <- lm(tabela_order$`2010` ~ tabela_order$m)
summary(lm3)

lm4 <- lm(tabela_order$`2014` ~ tabela_order$m)
summary(lm4)


write.csv(tabela_order, "tabela_order.csv")

##
regiao02 <- order_2002 %>% 
  group_by( REGIAO)%>%
  summarize(eleitos=mean(perc_maisvot))

regiao06 <- order_2006 %>% 
  group_by( REGIAO)%>%
  summarize(eleitos=mean(perc_maisvot))

regiao10 <- order_2010 %>% 
  group_by( REGIAO)%>%
  summarize(eleitos=mean(perc_maisvot))

regiao14 <- order_2014 %>% 
  group_by( REGIAO)%>%
  summarize(eleitos=mean(perc_maisvot))

colnames(regiao02) <- c("regiao","2002")
colnames(regiao06) <- c("uf2","2006")
colnames(regiao10) <- c("uf3","2010")
colnames(regiao14) <- c("uf4","2014")

tabela_order_regiao <- cbind(regiao02, regiao06, regiao10, regiao14)
tabela_order_regiao$uf2 <- NULL
tabela_order_regiao$uf3 <- NULL
tabela_order_regiao$uf4 <- NULL

write.csv(tabela_order_regiao, "tabela_order_regiao.csv")