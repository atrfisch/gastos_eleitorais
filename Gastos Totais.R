### Gastos 2014 ###

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2014/gastos_2014")
require(data.table)
require(dplyr)

despesas14 = list.files(pattern = "despesas_candidatos_2014_.*\\.txt") 
despesas14df = lapply(despesas14, read.table, header=TRUE, sep = ";", dec = ",")
save(despesas14df, file ="despesas14.RDATA")

load(file = "despesas14.RDATA")
gastos_2014 <- do.call(rbind, despesas14df)

gastos_2014$Cód..Eleição <- NULL
gastos_2014$Desc..Eleição <- NULL
gastos_2014$Descriçao.da.despesa <- NULL
gastos_2014$Data.e.hora <- NULL
gastos_2014$Nome.do.fornecedor <- NULL
gastos_2014$Data.da.despesa <- NULL
gastos_2014$Setor.econômico.do.fornecedor <- NULL
gastos_2014$Cod.setor.econômico.do.doador <- NULL
gastos_2014$Nome.do.fornecedor..Receita.Federal. <- NULL
gastos_2014$Tipo.do.documento <- NULL
gastos_2014$CPF.CNPJ.do.fornecedor <- NULL
gastos_2014$Número.do.documento <- NULL
gastos_2014$Tipo.do.documento <- NULL
gastos_2014$CNPJ.Prestador.Conta <- NULL
gastos_2014$Cod.setor.econômico.do.fornecedor <- NULL


setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2014, file ="gastos_2014.RDATA")
rm(list = ls())

### Gastos 2010

# Gde

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2010_gde/gastos_2010_gde")


despesas10 = list.files(pattern = "DespesasCandidatos_.*\\.txt")
despesas10df = lapply(despesas10, read.table, header=TRUE, sep = ";", dec = ",")
save(despesas10df, file ="despesas10.RDATA")

load(file = "despesas10.RDATA")
gastos_2010_gde <- do.call(rbind, despesas10df)

gastos_2010_gde$Cód..Eleição <- NULL
gastos_2010_gde$Desc..Eleição <- NULL
gastos_2010_gde$Descriçao.da.despesa <- NULL
gastos_2010_gde$Data.e.hora <- NULL
gastos_2010_gde$Nome.do.fornecedor <- NULL
gastos_2010_gde$Data.da.despesa <- NULL
gastos_2010_gde$Setor.econômico.do.fornecedor <- NULL
gastos_2010_gde$Cod.setor.econômico.do.doador <- NULL
gastos_2010_gde$Nome.do.fornecedor..Receita.Federal. <- NULL
gastos_2010_gde$Tipo.do.documento <- NULL
gastos_2010_gde$CPF.CNPJ.do.fornecedor <- NULL
gastos_2010_gde$Número.do.documento <- NULL
gastos_2010_gde$Tipo.do.documento <- NULL
gastos_2010_gde$CNPJ.Prestador.Conta <- NULL
gastos_2010_gde$Entrega.em.conjunto. <- NULL
gastos_2010_gde$Fonte.recurso <- NULL
gastos_2010_gde$Espécie.recurso <- NULL



setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2010_gde, file="gastos_2010_gde.RDATA")
rm(list = ls())

### mgsp

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2010_mgsp/gastos_2010_mgsp")


despesas10 = list.files(pattern = "DespesasCandidatos_.*\\.txt")
despesas10df = lapply(despesas10, read.table, header=TRUE, sep = ";", dec = ",")
save(despesas10df, file ="despesas10.RDATA")

load(file = "despesas10.RDATA")
gastos_2010_mgsp <- do.call(rbind, despesas10df)

gastos_2010_mgsp$Cód..Eleição <- NULL
gastos_2010_mgsp$Desc..Eleição <- NULL
gastos_2010_mgsp$Descriçao.da.despesa <- NULL
gastos_2010_mgsp$Data.e.hora <- NULL
gastos_2010_mgsp$Nome.do.fornecedor <- NULL
gastos_2010_mgsp$Data.da.despesa <- NULL
gastos_2010_mgsp$Setor.econômico.do.fornecedor <- NULL
gastos_2010_mgsp$Cod.setor.econômico.do.doador <- NULL
gastos_2010_mgsp$Nome.do.fornecedor..Receita.Federal. <- NULL
gastos_2010_mgsp$Tipo.do.documento <- NULL
gastos_2010_mgsp$CPF.CNPJ.do.fornecedor <- NULL
gastos_2010_mgsp$Número.do.documento <- NULL
gastos_2010_mgsp$Tipo.do.documento <- NULL
gastos_2010_mgsp$CNPJ.Prestador.Conta <- NULL
gastos_2010_mgsp$Entrega.em.conjunto. <- NULL
gastos_2010_mgsp$Fonte.recurso <- NULL
gastos_2010_mgsp$Espécie.recurso <- NULL



setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2010_mgsp, file="gastos_2010_mgsp.RDATA")
rm(list = ls())

## peq 

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2010_peq/gastos_2010_peq")


despesas10 = list.files(pattern = "DespesasCandidatos_.*\\.txt")
despesas10df = lapply(despesas10, read.table, header=TRUE, sep = ";", dec = ",")
save(despesas10df, file ="despesas10.RDATA")

load(file = "despesas10.RDATA")
gastos_2010_peq <- do.call(rbind, despesas10df)

gastos_2010_peq$Cód..Eleição <- NULL
gastos_2010_peq$Desc..Eleição <- NULL
gastos_2010_peq$Descriçao.da.despesa <- NULL
gastos_2010_peq$Data.e.hora <- NULL
gastos_2010_peq$Nome.do.fornecedor <- NULL
gastos_2010_peq$Data.da.despesa <- NULL
gastos_2010_peq$Setor.econômico.do.fornecedor <- NULL
gastos_2010_peq$Cod.setor.econômico.do.doador <- NULL
gastos_2010_peq$Nome.do.fornecedor..Receita.Federal. <- NULL
gastos_2010_peq$Tipo.do.documento <- NULL
gastos_2010_peq$CPF.CNPJ.do.fornecedor <- NULL
gastos_2010_peq$Número.do.documento <- NULL
gastos_2010_peq$Tipo.do.documento <- NULL
gastos_2010_peq$CNPJ.Prestador.Conta <- NULL
gastos_2010_peq$Entrega.em.conjunto. <- NULL
gastos_2010_peq$Fonte.recurso <- NULL
gastos_2010_peq$Espécie.recurso <- NULL



setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2010_peq, file="gastos_2010_peq.RDATA")
rm(list = ls())

## merge 2010

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")

load(file="gastos_2010_peq.RDATA")
load(file="gastos_2010_gde.RDATA")
load(file="gastos_2010_mgsp.RDATA")

gastos_2010<-rbind(gastos_2010_gde,gastos_2010_peq,gastos_2010_mgsp)

save(gastos_2010, file ="gastos_2010.RDATA")
rm(list = ls())

### 2006

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2006/gastos_2006")

gastos_2006<-read.csv(file="C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2006/gastos_2006/DespesaCandidato.csv", header=TRUE, sep = ";", dec = ",")


gastos_2006$NUMERO_CNPJ_CANDIDATO<-NULL
gastos_2006$DATA_DESPESA<-NULL
gastos_2006$DESCRICAO_FORMA_PAGAMENTO<-NULL
gastos_2006$CODIGO_FORMA_PAGAMENTO<-NULL
gastos_2006$NUMERO_DOCUMENTO<-NULL
gastos_2006$TIPO_DOCUMENTO<-NULL
gastos_2006$NOME_FORNECEDOR<-NULL
gastos_2006$UNIDADE_ELEITORAL_FORNECEDOR<-NULL
gastos_2006$SITUACAO_CADASTRAL<-NULL
gastos_2006$CODIGO_CARGO<-NULL
gastos_2006$NUMERO_PARTIDO<-NULL
gastos_2006$CODIGO_TIPO_DESPESA<-NULL
gastos_2006$CODIGO_TIPO_DOCUMENTO<-NULL
gastos_2006$NUMERO_CPF_CGC_FORNECEDOR<-NULL



colnames(gastos_2006)<-c("Sequencial.Candidato","Nome.candidato","Cargo","Número.candidato","UF","Sigla.Partido","Valor.despesa","Tipo.despesa")
gastos_2006 = gastos_2006 %>% select( Sequencial.Candidato , UF , Sigla.Partido , Número.candidato , Cargo , Nome.candidato , Valor.despesa, Tipo.despesa)

gastos_2006$ID<- paste(gastos_2006$UF,gastos_2006$Sequencial.Candidato, sep=".")

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2006, file ="gastos_2006.RDATA")
rm(list = ls())

## 2002

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2002/gastos_2002")

gastos_2002<-read.csv(file="C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/gastos_2002/gastos_2002/DespesaCandidato.csv", header=TRUE, sep = ";", dec = ",")


gastos_2002$DT_DOC_DESP<-NULL
gastos_2002$CD_CPF_CGC<-NULL
gastos_2002$SG_UF_FORNECEDOR<-NULL
gastos_2002$NO_FOR<-NULL

colnames(gastos_2002)<-c("Sequencial.Candidato","UF","Sigla.Partido","Cargo","Nome.candidato","Número.candidato","Valor.despesa","Tipo.despesa")
gastos_2002 = gastos_2002 %>% select( Sequencial.Candidato , UF , Sigla.Partido , Número.candidato , Cargo , Nome.candidato , Valor.despesa, Tipo.despesa)

gastos_2002$ID<- paste(gastos_2002$UF,gastos_2002$Sequencial.Candidato, sep=".")

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")
save(gastos_2002, file ="gastos_2002.RDATA")
rm(list = ls())

#############

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa")

### Abrindo as planilhas gastos

#2014
load(file="gastos_2014.RDATA")

#2010
load(file="gastos_2010.RDATA")

#2006
load(file="gastos_2006.RDATA")

#2002
load(file="gastos_2002.RDATA")

## considerando voto distrital como estadual

gastos_2014 <- mutate(gastos_2014, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gastos_2010 <- mutate(gastos_2010, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gastos_2006 <- mutate(gastos_2006, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))
gastos_2002 <- mutate(gastos_2002, cargo2 = ifelse(Cargo=="Deputado Distrital", "Deputado Estadual", as.character(Cargo)))


## consolidacao dos gastos por cargo

gastos_2014$valor_despesa<-(gastos_2014$Valor.despesa/0.850091)
gastos_2010$valor_despesa<-(gastos_2010$Valor.despesa/0.669185)
gastos_2006$valor_despesa<-(gastos_2006$Valor.despesa/0.547564)
gastos_2002$valor_despesa<-(gastos_2002$Valor.despesa/0.427108)

gastos_2014$valor_despesa_dolar<-(gastos_2014$valor_despesa/3.351)
gastos_2010$valor_despesa_dolar<-(gastos_2010$valor_despesa/3.351)
gastos_2006$valor_despesa_dolar<-(gastos_2006$valor_despesa/3.351)
gastos_2002$valor_despesa_dolar<-(gastos_2002$valor_despesa/3.351)


#2014
gastos_2014 <-gastos_2014 %>% 
  group_by(cargo2) %>% 
  summarise(valor_despesa = sum(valor_despesa_dolar))

#2010
gastos_2010 <-gastos_2010 %>% 
  group_by(cargo2) %>% 
  summarise(valor_despesa = sum(valor_despesa_dolar))

#gastos_2006$Número.candidato<-NULL

#2006
#colnames(gastos_2006)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2006 <-gastos_2006 %>% 
  group_by(cargo2) %>% 
  summarise(valor_despesa = sum(valor_despesa_dolar))

#2002
#colnames(gastos_2002)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2002 <-gastos_2002 %>% 
  group_by(cargo2) %>% 
  summarise(valor_despesa = sum(valor_despesa_dolar))



