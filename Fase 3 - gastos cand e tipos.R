### set wd

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)

### abrindo planilha de tipologia de gastos

tipologia.despesas <- read.csv("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data/tipologia despesas de campanha.csv", sep=";")

#tipologia.despesas$Tipo.despesas2<-toupper(tipologia.despesas$Tipo.despesa)

### Abrindo as planilhas gastos

#2014
load(file="gastos_2014.RDATA")

#2010
load(file="gastos_2010.RDATA")

#2006
load(file="gastos_2006.RDATA")

#2002
load(file="gastos_2002.RDATA")

### merging tipos e gastos

#2014
gastos_2014 <- merge( gastos_2014, tipologia.despesas, by.x = "Tipo.despesa", by.y = "Tipo.despesa")

#2010
gastos_2010 <- merge( gastos_2010, tipologia.despesas, by.x = "Tipo.despesa", by.y = "Tipo.despesa")

#2006
gastos_2006 <- merge( gastos_2006, tipologia.despesas, by.x = "Tipo.despesa", by.y = "Tipo.despesa")

#2002
gastos_2002 <- merge( gastos_2002, tipologia.despesas, by.x = "Tipo.despesa", by.y = "Tipo.despesa")


## consolidacao dos gastos por deputado

#2014
gastos_2014 <-gastos_2014 %>% 
  group_by(CPF.do.candidato, UF, Sequencial.Candidato, Número.candidato, Nome.candidato, Classificação, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))

#2010
gastos_2010 <-gastos_2010 %>% 
  group_by(CPF.do.candidato, UF, Sequencial.Candidato, Número.candidato, Nome.candidato, Classificação, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))


#2006
#colnames(gastos_2006)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2006 <-gastos_2006 %>% 
  group_by(ID, UF, Sequencial.Candidato,  Número.candidato, Nome.candidato, Classificação, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))

#2002
#colnames(gastos_2002)<-c("Tipo.despesa","Sequencial.Candidato","UF","Sigla.Partido","Número.candidato","Cargo","Nome.candidato","Valor.despesa","ID","Classificação")
gastos_2002 <-gastos_2002 %>% 
  group_by(ID, UF, Sequencial.Candidato,  Número.candidato, Nome.candidato, Classificação, Cargo) %>% 
  summarise(valor_despesa = sum(Valor.despesa))


#renomeando base gastos
names(gastos_2014)[1:8]<-c("cpf", "uf", "sqncial", "numero", "nome", "classificacao", "cargo", "despesa")
names(gastos_2010)[1:8]<-c("cpf", "uf", "sqncial", "numero", "nome", "classificacao", "cargo", "despesa")
names(gastos_2006)[1:8]<-c("ID", "uf", "sqncial", "numero", "nome", "classificacao", "cargo","despesa")
names(gastos_2002)[1:8]<-c("ID", "uf", "sqncial", "numero", "nome", "classificacao", "cargo","despesa")

#gerando nova variavel

#2014
gastos_2014$id_string <- as.character(gastos_2014$numero)
gastos_2014$id_string <- substring(gastos_2014$id_string, 1, 2)

#2010
gastos_2010$id_string <- as.character(gastos_2010$numero)
gastos_2010$id_string <- substring(gastos_2010$id_string, 1, 2)

#2006
gastos_2006$id_string <- as.character(gastos_2006$numero)
gastos_2006$id_string <- substring(gastos_2006$id_string, 1, 2)

#2002
gastos_2002$id_string <- as.character(gastos_2002$numero)
gastos_2002$id_string <- substring(gastos_2002$id_string, 1, 2)

## consolidacao dos gastos por deputado
## 2014
dep_gastos_2014 <-gastos_2014 %>% 
  group_by(cpf, uf, sqncial, nome ) %>% 
  summarise(despesa = sum(despesa))

## 2010
dep_gastos_2010 <-gastos_2010 %>% 
  group_by(cpf, uf, sqncial, nome ) %>% 
  summarise(despesa = sum(despesa))

## 2006
dep_gastos_2006 <-gastos_2006 %>% 
  group_by(ID, uf, sqncial, nome ) %>% 
  summarise(despesa = sum(despesa))

## 2002
dep_gastos_2002 <-gastos_2002 %>% 
  group_by(ID, uf, sqncial, nome ) %>% 
  summarise(despesa = sum(despesa))

###### abrindo bases cand

#2014
load(file="cand14.RDATA")

#2010
load(file="cand10.RDATA")

#2006
load(file="cand06.RDATA")

#2002
load(file="cand02.RDATA")

#limpando as bases cand

cand14<-cand14[,c("V3","V4", "V6", "V9", "V10", "V11", "V12", "V13","V14", "V16","V17","V18", "V28", "V44", "V45")]
cand10<-cand10[,c("V3","V4", "V6", "V9", "V10", "V11", "V12", "V13","V14", "V16","V17","V18", "V28", "V42", "V43")]
cand06<-cand06[,c("V3","V4", "V6", "V9", "V10", "V11", "V12", "V13","V14", "V16","V17","V18", "V28", "V42", "V43")]
cand02<-cand02[,c("V3","V4", "V6", "V9", "V10", "V11", "V12", "V13","V14", "V16","V17","V18", "V28", "V42", "V43")]


#renomeando as bases
names(cand14)[1:15]<-c("ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "cpf", "codsitu", "descsitu", "partido", "titulo", "resultado_cod", "resultado")
names(cand10)[1:15]<-c("ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "cpf", "codsitu", "descsitu", "partido", "titulo", "resultado_cod", "resultado")
names(cand06)[1:15]<-c("ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "cpf", "codsitu", "descsitu", "partido", "titulo", "resultado_cod", "resultado")
names(cand02)[1:15]<-c("ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "cpf", "codsitu", "descsitu", "partido", "titulo", "resultado_cod", "resultado")


#criando ids para 2002 e 2006
cand02$ID<- paste(cand02$uf,cand02$sqncial, sep=".")
cand06$ID<- paste(cand06$uf,cand06$sqncial, sep=".")
cand10$ID<- paste(cand10$uf,cand06$sqncial, sep=".")
cand14$ID<- paste(cand14$uf,cand06$sqncial, sep=".")

#merging gastos e resultados
cand14 <- merge( cand14, gastos_2014, by.x = "cpf", by.y = "cpf" , all.x = TRUE)
cand10 <- merge( cand10, gastos_2010, by.x = "cpf", by.y = "cpf" , all.x = TRUE)
cand06 <- merge( cand06, gastos_2006, by.x = "ID", by.y = "ID" , all.x = TRUE)
cand02 <- merge( cand02, gastos_2002, by.x = "ID", by.y = "ID" , all.x = TRUE)

#limpando as bases vg
cand14<-cand14[,c("ID","cpf", "ano","turno", "uf.x", "codcargo", "cargo.x", "nome.x", "sqncial.x", "numero.x", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao"  )]
cand10<-cand10[,c("ID","cpf", "ano","turno", "uf.x", "codcargo", "cargo.x", "nome.x", "sqncial.x", "numero.x", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao"  )]
cand06<-cand06[,c("ID","cpf", "ano","turno", "uf.x", "codcargo", "cargo.x", "nome.x", "sqncial.x", "numero.x", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao"  )]
cand02<-cand02[,c("ID","cpf", "ano","turno", "uf.x", "codcargo", "cargo.x", "nome.x", "sqncial.x", "numero.x", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao"  )]


#renomeando as variaveis
names(cand14)[1:18]<-c("ID","cpf", "ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao")
names(cand10)[1:18]<-c("ID","cpf", "ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao")
names(cand06)[1:18]<-c("ID","cpf", "ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao")
names(cand02)[1:18]<-c("ID","cpf", "ano","turno", "uf", "codcargo", "cargo", "nome", "sqncial", "numero", "codsitu", "descsitu", "partido", "titulo", "despesa", "resultado_cod", "resultado", "classificacao")

#deflacionando a série

cand14$despesa_real<-(cand14$despesa/0.850091)
cand10$despesa_real<-(cand10$despesa/0.669185)
cand06$despesa_real<-(cand06$despesa/0.547564)
cand02$despesa_real<-(cand02$despesa/0.427108)

cand14$despesa_real_dolar<-(cand14$despesa_real/3.351)
cand10$despesa_real_dolar<-(cand10$despesa_real/3.351)
cand06$despesa_real_dolar<-(cand06$despesa_real/3.351)
cand02$despesa_real_dolar<-(cand02$despesa_real/3.351)



## salvando as bases cand

save(cand02, file ="cg02.RDATA")
save(cand06, file ="cg06.RDATA")
save(cand10, file ="cg10.RDATA")
save(cand14, file ="cg14.RDATA")

#somente dep fed
#filtrando deputados federais
cand14 <- filter(cand14, cargo == "DEPUTADO FEDERAL")
cand10 <- filter(cand10, cargo == "DEPUTADO FEDERAL")
cand06 <- filter(cand06, cargo == "DEPUTADO FEDERAL")
cand02 <- filter(cand02, cargo == "DEPUTADO FEDERAL")



### Só candidatos deferidos
def_cand14 <- cand14 %>% 
  filter(descsitu == "DEFERIDO" )

def_cand10 <- cand10 %>% 
  filter(descsitu == "DEFERIDO" )

def_cand06 <- cand06 %>% 
  filter(descsitu == "DEFERIDO" )

def_cand02 <- cand02 %>% 
  filter(descsitu == "DEFERIDO" )



## eleitos

ele_cand14 <- cand14 %>% 
  filter(resultado == "ELEITO POR QP" | resultado == "ELEITO POR MÉDIA")

ele_cand10 <- cand10 %>% 
  filter(resultado == "ELEITO" | resultado =="MÉDIA")

ele_cand06 <- cand06 %>% 
  filter(resultado == "ELEITO" | resultado == "MÉDIA")

ele_cand02 <- cand02 %>% 
  filter(resultado == "ELEITO" | resultado == "ELEITO POR MÉDIA" )



## filtrando para mesmo estado


resultstot14 <- ele_cand14 %>%
  group_by( classificacao) %>% 
  summarize ( total = sum(despesa_real_dolar),media = mean(despesa_real_dolar), sd = sd(despesa_real_dolar))

resultstot10 <- ele_cand10 %>%
  group_by( classificacao) %>% 
  summarize ( total = sum(despesa_real_dolar),media = mean(despesa_real_dolar), sd = sd(despesa_real_dolar))

resultstot06 <- ele_cand06 %>%
  group_by( classificacao) %>% 
  summarize ( total = sum(despesa_real_dolar),media = mean(despesa_real_dolar), sd = sd(despesa_real_dolar))

resultstot02 <- ele_cand02 %>%
  group_by( classificacao) %>% 
  summarize ( total = sum(despesa_real_dolar),media = mean(despesa_real_dolar), sd = sd(despesa_real_dolar))

### analise partido PT

#14
result_part14_pt <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 13) %>%
  summarize ( total = mean(despesa_real_dolar))

result_part14_pt$partido<-NULL
result_part14_pt$classificacao<-NULL
colnames(result_part14_pt)<-c("2014")

#10
result_part10_pt <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 13) %>%
  summarize ( total = mean(despesa_real_dolar))

result_part10_pt$partido<-NULL
result_part10_pt$classificacao<-NULL
colnames(result_part10_pt)<-c( "2010")

#06
result_part06_pt <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 13) %>%
  summarize ( total = mean(despesa_real_dolar))

result_part06_pt$partido<-NULL
result_part06_pt$classificacao<-NULL
colnames(result_part06_pt)<-c( "2006")

#02
result_part02_pt <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 13) %>%
  summarize ( total = mean(despesa_real_dolar))

result_part02_pt$partido<-NULL
colnames(result_part02_pt)<-c("tipo de gasto", "2002")

# 
result_pt<- cbind(result_part02_pt,result_part06_pt,result_part10_pt,result_part14_pt)
rm(result_part02_pt,result_part06_pt,result_part10_pt,result_part14_pt)

### analise partido PMDB

#14
result_part14_pmdb <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 15) %>%
  summarize ( total = sum(despesa))

result_part14_pmdb$partido<-NULL
result_part14_pmdb$classificacao<-NULL
colnames(result_part14_pmdb)<-c("2014")

#10
result_part10_pmdb <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 15) %>%
  summarize ( total = sum(despesa))

result_part10_pmdb$partido<-NULL
result_part10_pmdb$classificacao<-NULL
colnames(result_part10_pmdb)<-c( "2010")

#06
result_part06_pmdb <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 15) %>%
  summarize ( total = sum(despesa))

result_part06_pmdb$partido<-NULL
result_part06_pmdb$classificacao<-NULL
colnames(result_part06_pmdb)<-c( "2006")

#02
result_part02_pmdb <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 15) %>%
  summarize ( total = sum(despesa))

result_part02_pmdb$partido<-NULL
result_part02_pmdb <- result_part02_pmdb[-c( 6), ]
colnames(result_part02_pmdb)<-c("tipo de gasto", "2002")

# 
result_pmdb<- cbind(result_part02_pmdb,result_part06_pmdb,result_part10_pmdb,result_part14_pmdb)
rm(result_part02_pmdb,result_part06_pmdb,result_part10_pmdb,result_part14_pmdb)

### analise partido PSDB

#14
result_part14_psdb <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 45) %>%
  summarize ( total = sum(despesa))

result_part14_psdb$partido<-NULL
result_part14_psdb$classificacao<-NULL
colnames(result_part14_psdb)<-c("2014")

#10
result_part10_psdb <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 45) %>%
  summarize ( total = sum(despesa))

result_part10_psdb$partido<-NULL
result_part10_psdb$classificacao<-NULL
colnames(result_part10_psdb)<-c( "2010")

#06
result_part06_psdb <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 45) %>%
  summarize ( total = sum(despesa))

result_part06_psdb$partido<-NULL
result_part06_psdb$classificacao<-NULL
colnames(result_part06_psdb)<-c( "2006")

#02
result_part02_psdb <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 45) %>%
  summarize ( total = sum(despesa))

result_part02_psdb$partido<-NULL
colnames(result_part02_psdb)<-c("tipo de gasto", "2002")

# 
result_psdb<- cbind(result_part02_psdb,result_part06_psdb,result_part10_psdb,result_part14_psdb)
rm(result_part02_psdb,result_part06_psdb,result_part10_psdb,result_part14_psdb)

### analise partido pp

#14
result_part14_dem <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 25) %>%
  summarize ( total = sum(despesa))

result_part14_dem$partido<-NULL
result_part14_dem$classificacao<-NULL
colnames(result_part14_dem)<-c("2014")

#10
result_part10_dem <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 25) %>%
  summarize ( total = sum(despesa))

result_part10_dem$partido<-NULL
result_part10_dem$classificacao<-NULL
colnames(result_part10_dem)<-c( "2010")

#06
result_part06_dem <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 25) %>%
  summarize ( total = sum(despesa))

result_part06_dem$partido<-NULL
result_part06_dem$classificacao<-NULL
colnames(result_part06_dem)<-c( "2006")

#02
result_part02_dem <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 25) %>%
  summarize ( total = sum(despesa))

result_part02_dem$partido<-NULL
colnames(result_part02_dem)<-c("tipo de gasto", "2002")

# 
result_dem<- cbind(result_part02_dem,result_part06_dem,result_part10_dem,result_part14_dem)
rm(result_part02_dem,result_part06_dem,result_part10_dem,result_part14_dem)

### analise partido PP

#14
result_part14_pp <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 11) %>%
  summarize ( total = sum(despesa))

result_part14_pp$partido<-NULL
result_part14_pp$classificacao<-NULL
colnames(result_part14_pp)<-c("2014")

#10
result_part10_pp <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 11) %>%
  summarize ( total = sum(despesa))

result_part10_pp$partido<-NULL
result_part10_pp$classificacao<-NULL
colnames(result_part10_pp)<-c( "2010")

#06
result_part06_pp <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 11) %>%
  summarize ( total = sum(despesa))

result_part06_pp$partido<-NULL
result_part06_pp$classificacao<-NULL
colnames(result_part06_pp)<-c( "2006")

#02
result_part02_pp <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 11) %>%
  summarize ( total = sum(despesa))

result_part02_pp$partido<-NULL
colnames(result_part02_pp)<-c("tipo de gasto", "2002")

# 
result_pp<- cbind(result_part02_pp,result_part06_pp,result_part10_pp,result_part14_pp)
rm(result_part02_pp,result_part06_pp,result_part10_pp,result_part14_pp)

### analise partido PDT

#14
result_part14_pdt <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 12) %>%
  summarize ( total = sum(despesa))

result_part14_pdt$partido<-NULL
result_part14_pdt$classificacao<-NULL
colnames(result_part14_pdt)<-c("2014")

#10
result_part10_pdt <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 12) %>%
  summarize ( total = sum(despesa))

result_part10_pdt$partido<-NULL
result_part10_pdt$classificacao<-NULL
colnames(result_part10_pdt)<-c( "2010")

#06
result_part06_pdt <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 12) %>%
  summarize ( total = sum(despesa))

result_part06_pdt$partido<-NULL
result_part06_pdt$classificacao<-NULL
colnames(result_part06_pdt)<-c( "2006")

#02
result_part02_pdt <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 12) %>%
  summarize ( total = sum(despesa))

result_part02_pdt$partido<-NULL
colnames(result_part02_pdt)<-c("tipo de gasto", "2002")

# 
result_pdt<- cbind(result_part02_pdt,result_part06_pdt,result_part10_pdt,result_part14_pdt)
rm(result_part02_pdt,result_part06_pdt,result_part10_pdt,result_part14_pdt)

### analise partido PTB

#14
result_part14_ptb <-ele_cand14 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 14) %>%
  summarize ( total = sum(despesa))

result_part14_ptb$partido<-NULL
result_part14_ptb$classificacao<-NULL
colnames(result_part14_ptb)<-c("2014")

#10
result_part10_ptb <-ele_cand10 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 14) %>%
  summarize ( total = sum(despesa))

result_part10_ptb$partido<-NULL
result_part10_ptb$classificacao<-NULL
colnames(result_part10_ptb)<-c( "2010")

#06
result_part06_ptb <-ele_cand06 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 14) %>%
  summarize ( total = sum(despesa))

result_part06_ptb$partido<-NULL
result_part06_ptb$classificacao<-NULL
colnames(result_part06_ptb)<-c( "2006")

#02
result_part02_ptb <-ele_cand02 %>%
  group_by(partido, classificacao) %>% 
  filter(partido == 14) %>%
  summarize ( total = sum(despesa))

result_part02_ptb$partido<-NULL
colnames(result_part02_ptb)<-c("tipo de gasto", "2002")

# 
result_ptb<- cbind(result_part02_ptb,result_part06_ptb,result_part10_ptb,result_part14_ptb)
rm(result_part02_ptb,result_part06_ptb,result_part10_ptb,result_part14_ptb)