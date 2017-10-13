### set wd

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)

### abrindo planilha de tipologia de gastos

### Abrindo as planilhas gastos

#2014
load(file="receitas_2014.RDATA")

#2010
load(file="receitas_2010.RDATA")

#2006
load(file="receitas_2006.RDATA")

#2002
load(file="receitas_2002.RDATA")

## limpando as bases

rec02 <- receitas_2002 %>%
  group_by(SEQUENCIAL_CANDIDATO, SG_UF, SG_PART, NR_CAND )%>%
  summarise(receita = sum(VR_RECEITA))


rec06 <- receitas_2006 %>%
  group_by(SEQUENCIAL_CANDIDATO, UNIDADE_ELEITORAL_CANDIDATO, SIGLA_PARTIDO, NUMERO_CANDIDATO )%>%
  summarise(receita = sum(VALOR_RECEITA))

rec10 <- receitas_2010 %>%
  group_by(Sequencial.Candidato, UF, Sigla.Partido, Número.candidato )%>%
  summarise(receita = sum(Valor.receita))


rec14 <- receitas_2014 %>%
  group_by(Sequencial.Candidato, UF, Sigla..Partido, Numero.candidato )%>%
  summarise(receita = sum(Valor.receita))


## mudando nomes 
names(rec02)[1:5]<-c("sqncial","uf","sigla_partido","numero_cand","receita")
names(rec06)[1:5]<-c("sqncial","uf","sigla_partido","numero_cand","receita")
names(rec10)[1:5]<-c("sqncial","uf","sigla_partido","numero_cand","receita")
names(rec14)[1:5]<-c("sqncial","uf","sigla_partido","numero_cand","receita")


### gastos

#2014
load(file="gastos_2014.RDATA")

#2010
load(file="gastos_2010.RDATA")

#2006
load(file="gastos_2006.RDATA")

#2002
load(file="gastos_2002.RDATA")

## consolidacao dos gastos por deputado

#2014
gastos_2014 <-gastos_2014 %>% 
  group_by(CPF.do.candidato, UF, Sequencial.Candidato, Número.candidato, Nome.candidato,  Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))

#2010
gastos_2010 <-gastos_2010 %>% 
  group_by(CPF.do.candidato, UF, Sequencial.Candidato, Número.candidato, Nome.candidato,  Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))


#2006
#colnames(gastos_2006)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2006 <-gastos_2006 %>% 
  group_by(ID, UF, Sequencial.Candidato,  Número.candidato, Nome.candidato, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))

#2002
#colnames(gastos_2002)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2002 <-gastos_2002 %>% 
  group_by(ID, UF, Sequencial.Candidato,  Número.candidato, Nome.candidato, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))


# gastos e receitas

gast_rec02 <- merge(x=gastos_2002, y=rec02, by.x=c("UF","Sequencial.Candidato","Número.candidato"), by.y=c("uf","sqncial","numero_cand"), all=TRUE)
gast_rec06 <- merge(x=gastos_2006, y=rec06, by.x=c("UF","Sequencial.Candidato","Número.candidato"), by.y=c("uf","sqncial","numero_cand"), all=TRUE)
gast_rec10 <- merge(x=gastos_2010, y=rec10, by.x=c("UF","Sequencial.Candidato","Número.candidato"), by.y=c("uf","sqncial","numero_cand"), all=TRUE)
gast_rec14 <- merge(x=gastos_2014, y=rec14, by.x=c("UF","Sequencial.Candidato","Número.candidato"), by.y=c("uf","sqncial","numero_cand"), all=TRUE)


gast_rec14$despesa_real<-(gast_rec14$valor_despesa/0.850091)
gast_rec10$despesa_real<-(gast_rec10$valor_despesa/0.669185)
gast_rec06$despesa_real<-(gast_rec06$valor_despesa/0.547564)
gast_rec02$despesa_real<-(gast_rec02$valor_despesa/0.427108)

gast_rec14$despesa_real_dolar<-(gast_rec14$despesa_real/3.351)
gast_rec10$despesa_real_dolar<-(gast_rec10$despesa_real/3.351)
gast_rec06$despesa_real_dolar<-(gast_rec06$despesa_real/3.351)
gast_rec02$despesa_real_dolar<-(gast_rec02$despesa_real/3.351)



gast_rec14$receita_real<-(gast_rec14$receita/0.850091)
gast_rec10$receita_real<-(gast_rec10$receita/0.669185)
gast_rec06$receita_real<-(gast_rec06$receita/0.547564)
gast_rec02$receita_real<-(gast_rec02$receita/0.427108)

gast_rec14$receita_real_dolar<-(gast_rec14$receita_real/3.351)
gast_rec10$receita_real_dolar<-(gast_rec10$receita_real/3.351)
gast_rec06$receita_real_dolar<-(gast_rec06$receita_real/3.351)
gast_rec02$receita_real_dolar<-(gast_rec02$receita_real/3.351)

# trocando dep fed e dep est

gast_rec14 <- mutate(gast_rec14, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gast_rec10 <- mutate(gast_rec10, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gast_rec06 <- mutate(gast_rec06, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gast_rec02 <- mutate(gast_rec02, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))

## calculos da correlacoes

corr14 <- gast_rec14 %>%
  group_by(cargo2)%>%
  filter(!(is.na(receita_real_dolar)))%>%
  filter(!(is.na(despesa_real_dolar)))%>%         
  summarise(corr = cor(receita_real_dolar, despesa_real_dolar))


corr10 <- gast_rec10 %>%
  group_by(cargo2)%>%
  filter(!(is.na(receita_real_dolar)))%>%
  filter(!(is.na(despesa_real_dolar)))%>%         
  summarise(corr = cor(receita_real_dolar, despesa_real_dolar))

corr06 <- gast_rec06 %>%
  group_by(cargo2)%>%
  filter(!(is.na(receita_real_dolar)))%>%
  filter(!(is.na(despesa_real_dolar)))%>%         
  summarise(corr = cor(receita_real_dolar, despesa_real_dolar))

corr02 <- gast_rec02%>%
  group_by(cargo2)%>%
  filter(!(is.na(receita_real_dolar)))%>%
  filter(!(is.na(despesa_real_dolar)))%>%         
  summarise(corr = cor(receita_real_dolar, despesa_real_dolar))


### significancia

lm1 <- lm( formula = receita_real_dolar ~ despesa_real_dolar, data=gast_rec02)
summary(lm1)


lm2 <- lm( formula = receita_real_dolar ~ despesa_real_dolar, data=gast_rec06)
summary(lm2)

lm3 <- lm( formula = receita_real_dolar ~ despesa_real_dolar, data=gast_rec10)
summary(lm3)

lm4 <- lm( formula = receita_real_dolar ~ despesa_real_dolar, data=gast_rec14)
summary(lm4)