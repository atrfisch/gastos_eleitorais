### set wd

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")
require(data.table)
require(dplyr)

rm(list=ls())

options(scipen=999) # supressing scientific notation
par(mar=c(5.1,4.1,4.1,2.1)) 
par(mfrow=c(1,1))

#2014
load(file="votos14.RDATA")

#2010
load(file="votos10.RDATA")

#2006
load(file="votos06.RDATA")

#2002
load(file="votos02.RDATA")

### colocandod nome nas variaveis

labels_pre2012 <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                    "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                    "CODIGO_CARGO", "NUMERO_CAND", "SQ_CANDIDATO", "NOME_CANDIDATO", "NOME_URNA_CANDIDATO",
                    "DESCRICAO_CARGO", "COD_SIT_CAND_SUPERIOR", "DESC_SIT_CAND_SUPERIOR", "CODIGO_SIT_CANDIDATO",
                    "DESC_SIT_CANDIDATO", "CODIGO_SIT_CAND_TOT", "DESC_SIT_CAND_TOT", "NUMERO_PARTIDO",
                    "SIGLA_PARTIDO", "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                    "TOTAL_VOTOS")

labels_2016 <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                 "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                 "CODIGO_CARGO", "NUMERO_CAND", "SQ_CANDIDATO", "NOME_CANDIDATO", "NOME_URNA_CANDIDATO",
                 "DESCRICAO_CARGO", "COD_SIT_CAND_SUPERIOR", "DESC_SIT_CAND_SUPERIOR", "CODIGO_SIT_CANDIDATO",
                 "DESC_SIT_CANDIDATO", "CODIGO_SIT_CAND_TOT", "DESC_SIT_CAND_TOT", "NUMERO_PARTIDO",
                 "SIGLA_PARTIDO", "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                 "TOTAL_VOTOS", "TRANSITO")

names(votos02) <- labels_pre2012
names(votos06) <- labels_pre2012
names(votos10) <- labels_pre2012
names(votos14) <- labels_2016

### consolidado

#consertando presidente

votos14 <- mutate(votos14, SIGLA_UF2 =ifelse(CODIGO_CARGO==1,"BR",as.character(SIGLA_UF)))
votos14$SIGLA_UF<-NULL
colnames(votos14)[30]<-"SIGLA_UF"

votos10 <- mutate(votos10, SIGLA_UF2 =ifelse(CODIGO_CARGO==1,"BR",as.character(SIGLA_UF)))
votos10$SIGLA_UF<-NULL
colnames(votos10)[29]<-"SIGLA_UF"

votos06 <- mutate(votos06, SIGLA_UF2 =ifelse(CODIGO_CARGO==1,"BR",as.character(SIGLA_UF)))
votos06$SIGLA_UF<-NULL
colnames(votos06)[29]<-"SIGLA_UF"

votos02 <- mutate(votos02, SIGLA_UF2 =ifelse(CODIGO_CARGO==1,"BR",as.character(SIGLA_UF)))
votos02$SIGLA_UF<-NULL
colnames(votos02)[29]<-"SIGLA_UF"


votos02 <- votos02 %>%
  filter(!(is.na(CODIGO_SIT_CANDIDATO)))

cand_voto_02 <- votos02 %>%
  group_by(ANO_ELEICAO, NUM_TURNO, DESCRICAO_CARGO,CODIGO_CARGO, SQ_CANDIDATO,DESCRICAO_ELEICAO, SIGLA_UF,NUMERO_CAND,NOME_CANDIDATO,NOME_URNA_CANDIDATO, SEQUENCIAL_LEGENDA, SIGLA_PARTIDO)%>%
  summarise(VOTOS = sum(TOTAL_VOTOS))


cand_voto_06 <- votos06 %>%
  group_by(ANO_ELEICAO, NUM_TURNO, DESCRICAO_CARGO,CODIGO_CARGO,  SQ_CANDIDATO, DESCRICAO_ELEICAO, SIGLA_UF,NUMERO_CAND,NOME_CANDIDATO,NOME_URNA_CANDIDATO, SEQUENCIAL_LEGENDA, SIGLA_PARTIDO)%>%
  summarise(VOTOS = sum(TOTAL_VOTOS))


cand_voto_10 <- votos10 %>%
  group_by(ANO_ELEICAO, NUM_TURNO, DESCRICAO_CARGO,CODIGO_CARGO, SQ_CANDIDATO,DESCRICAO_ELEICAO, SIGLA_UF,NUMERO_CAND,NOME_CANDIDATO,NOME_URNA_CANDIDATO, SEQUENCIAL_LEGENDA, SIGLA_PARTIDO)%>%
  summarise(VOTOS = sum(TOTAL_VOTOS))


cand_voto_14 <- votos14 %>%
  group_by(ANO_ELEICAO, NUM_TURNO, DESCRICAO_CARGO,CODIGO_CARGO, SQ_CANDIDATO,DESCRICAO_ELEICAO, SIGLA_UF,NUMERO_CAND,NOME_CANDIDATO,NOME_URNA_CANDIDATO, SEQUENCIAL_LEGENDA, SIGLA_PARTIDO)%>%
  summarise(VOTOS = sum(TOTAL_VOTOS))


### juntando com dados de gastos e candidaturas

setwd("C:/Users/fisch/Desktop/Arthur/Parte Quantitativa/Data")

#2014
load(file="cg14.RDATA")

#2010
load(file="cg10.RDATA")

#2006
load(file="cg06.RDATA")

#2002
load(file="cg02.RDATA")



## mesclando deputado estadual e distrital

cg14 <- mutate(cand14, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg10 <- mutate(cand10, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg06 <- mutate(cand06, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))
cg02 <- mutate(cand02, cargo2 = ifelse(cargo=="DEPUTADO DISTRITAL", "DEPUTADO ESTADUAL", as.character(cargo)))


## consolidacao dos gastos por deputado
## 2014
gastos_2014 <-cg14 %>% 
  group_by(ID, cpf, codcargo,uf,turno, cargo2, descsitu, resultado, sqncial, partido, nome ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2010
gastos_2010 <-cg10 %>% 
  group_by(ID, cpf, codcargo,uf,turno,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2006
gastos_2006 <-cg06 %>% 
  group_by(ID, cpf, codcargo,uf,turno,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))

## 2002
gastos_2002 <-cg02 %>% 
  group_by(ID, cpf, codcargo,uf,turno,cargo2, descsitu, resultado, sqncial, partido, nome  ) %>% 
  summarise(despesa = sum(despesa_real_dolar))



# tabela consolidada

cvg02 <- merge (gastos_2002, cand_voto_02, by.x=c("uf", "sqncial","turno"), by.y=c("SIGLA_UF", "SQ_CANDIDATO","NUM_TURNO"), all.x = TRUE)
cvg06 <- merge (gastos_2006, cand_voto_06, by.x=c("uf", "sqncial","turno"), by.y=c("SIGLA_UF", "SQ_CANDIDATO","NUM_TURNO"), all.x = TRUE)
cvg10 <- merge (gastos_2010, cand_voto_10, by.x=c("uf", "sqncial","turno"), by.y=c("SIGLA_UF", "SQ_CANDIDATO","NUM_TURNO"), all.x = TRUE)
cvg14 <- merge (gastos_2014, cand_voto_14, by.x=c("uf", "sqncial","turno"), by.y=c("SIGLA_UF", "SQ_CANDIDATO","NUM_TURNO"), all.x = TRUE)


# salvando a base

save(cvg02, file ="cvg02.RDATA")
save(cvg06, file ="cvg06.RDATA")
save(cvg10, file ="cvg10.RDATA")
save(cvg14, file ="cvg14.RDATA")


# Verificação para deputados


cvg14 <- filter(cvg14, cargo2 == "DEPUTADO FEDERAL" )
cvg10 <- filter(cvg10, cargo2 == "DEPUTADO FEDERAL" )
cvg06 <- filter(cvg06, cargo2 == "DEPUTADO FEDERAL" )
cvg02 <- filter(cvg02, cargo2 == "DEPUTADO FEDERAL" )



# colocando os partidos isolados como nao isolados

cvg02 <- mutate(cvg02, sq_legenda2 = ifelse(SEQUENCIAL_LEGENDA==-1, as.character(SIGLA_PARTIDO), as.numeric(SEQUENCIAL_LEGENDA)))
cvg06 <- mutate(cvg06, sq_legenda2 = ifelse(SEQUENCIAL_LEGENDA==-1, as.character(SIGLA_PARTIDO), as.numeric(SEQUENCIAL_LEGENDA)))
cvg10 <- mutate(cvg10, sq_legenda2 = ifelse(SEQUENCIAL_LEGENDA==-1, as.character(SIGLA_PARTIDO), as.numeric(SEQUENCIAL_LEGENDA)))
cvg14 <- mutate(cvg14, sq_legenda2 = ifelse(SEQUENCIAL_LEGENDA==-1, as.character(SIGLA_PARTIDO), as.numeric(SEQUENCIAL_LEGENDA)))

# criando id

cvg02$idleg <-paste0(cvg02$uf, cvg02$sq_legenda2)
cvg06$idleg <-paste0(cvg06$uf, cvg06$sq_legenda2)
cvg10$idleg <-paste0(cvg10$uf, cvg10$sq_legenda2)
cvg14$idleg <-paste0(cvg14$uf, cvg14$sq_legenda2)


# ordenar os candidatos

cvg02 <- cvg02 %>%
  arrange (idleg, desc(VOTOS)) %>%
  group_by(idleg) %>% 
  mutate(rank = rank(idleg, ties.method = "first"))


cvg06 <- cvg06 %>%
  arrange (idleg, desc(VOTOS)) %>%
  group_by(idleg) %>% 
  mutate(rank = rank(idleg, ties.method = "first"))


cvg10 <- cvg10 %>%
  arrange (idleg, desc(VOTOS)) %>%
  group_by(idleg) %>% 
  mutate(rank = rank(idleg, ties.method = "first"))


cvg14 <- cvg14 %>%
  arrange (idleg, desc(VOTOS)) %>%
  group_by(idleg) %>% 
  mutate(rank = rank(idleg, ties.method = "first"))

### identificando ultimo eleito e primeiro suplente


cvg14 <-mutate(cvg14, resultado2 = ifelse(resultado=="ELEITO POR QP","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))
cvg10 <-mutate(cvg10, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))
cvg06 <-mutate(cvg06, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="MÉDIA","Eleito",ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))
cvg02 <-mutate(cvg02, resultado2 = ifelse(resultado=="ELEITO","Eleito",ifelse(resultado=="ELEITO POR MÉDIA","Eleito", ifelse(resultado=="SUPLENTE","Suplente","Não eleito"))))


cvg02$idleg2 <-paste0(cvg02$idleg, cvg02$resultado2)
cvg06$idleg2 <-paste0(cvg06$idleg, cvg06$resultado2)
cvg10$idleg2 <-paste0(cvg10$idleg, cvg10$resultado2)
cvg14$idleg2 <-paste0(cvg14$idleg, cvg14$resultado2)

cvg02 <- cvg02 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(rank2 = rank(c(idleg2), ties.method = "first"))


cvg06 <- cvg06 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(rank2 = rank(c(idleg2), ties.method = "first"))

cvg10 <- cvg10 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(rank2 = rank(c(idleg2), ties.method = "first"))

cvg14 <- cvg14 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(rank2 = rank(c(idleg2), ties.method = "first"))

###
cvg14 <-mutate(cvg14, prim_supl = ifelse((rank2==1 & resultado2=="Suplente"),1,0))
cvg10 <-mutate(cvg10, prim_supl = ifelse((rank2==1 & resultado2=="Suplente"),1,0))
cvg06 <-mutate(cvg06, prim_supl = ifelse((rank2==1 & resultado2=="Suplente"),1,0))
cvg02 <-mutate(cvg02, prim_supl = ifelse((rank2==1 & resultado2=="Suplente"),1,0))

### identificando os ultimos eleitos

cvg02 <- cvg02 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(flag = ifelse( (rank(c(idleg2), ties.method = "last")==1 & resultado2=="Eleito"),1,0))


cvg06 <- cvg06 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(flag = ifelse( (rank(c(idleg2), ties.method = "last")==1 & resultado2=="Eleito"),1,0))


cvg10 <- cvg10 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(flag = ifelse( (rank(c(idleg2), ties.method = "last")==1 & resultado2=="Eleito"),1,0))


cvg14 <- cvg14 %>%
  arrange (idleg2, desc(VOTOS)) %>%
  group_by(idleg2) %>% 
  mutate(flag = ifelse( (rank(c(idleg2), ties.method = "last")==1 & resultado2=="Eleito"),1,0))

#### share

save(cvg14, file="share14.RDATA")
save(cvg10, file="share10.RDATA")
save(cvg06, file="share06.RDATA")
save(cvg02, file="share02.RDATA")


### Calculando os 90%

cvg14 <-mutate(cvg14, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg10 <-mutate(cvg10, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg06 <-mutate(cvg06, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg02 <-mutate(cvg02, threshold = ifelse((flag==1),VOTOS*0.9,0))

## planilha auxilliar idleg threshold

aux_idleg_02 <- cvg02 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux_idleg_06 <- cvg06 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux_idleg_10 <- cvg10 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux_idleg_14 <- cvg14 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))

### merge de volta

scvg02 <- merge(cvg02, aux_idleg_02, by="idleg", all.x = TRUE)
scvg06 <- merge(cvg06, aux_idleg_06, by="idleg", all.x = TRUE)
scvg10 <- merge(cvg10, aux_idleg_10, by="idleg", all.x = TRUE)
scvg14 <- merge(cvg14, aux_idleg_14, by="idleg", all.x = TRUE)

#

save(scvg02, file="scvg02.RDATA")
save(scvg06, file="scvg06.RDATA")
save(scvg10, file="scvg10.RDATA")
save(scvg14, file="scvg14.RDATA")

### somente candidatos competitivos

compet02 <- scvg02 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet06 <- scvg06 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet10 <- scvg10 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

compet14 <- scvg14 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

### MÉDIA DOS ELEITOS E SUPLENTES

resultstot14 <- compet14 %>%
  group_by( resultado2) %>%
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

resultstot10 <- compet10 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

resultstot06 <- compet06 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE),  n = n())

resultstot02 <- compet02 %>%
  group_by( resultado2) %>% 
  summarize ( media = mean(despesa, na.rm=TRUE), n = n())

### diferenças de média

compet02_ele <- compet02 %>%
  filter(resultado2 =="Eleito")

compet02_nele <- compet02 %>%
  filter(resultado2 !="Eleito")

compet06_ele <- compet06 %>%
  filter(resultado2 =="Eleito")

compet06_nele <- compet06 %>%
  filter(resultado2 !="Eleito")


compet10_ele <- compet10 %>%
  filter(resultado2 =="Eleito")

compet10_nele <- compet10 %>%
  filter(resultado2 !="Eleito")


compet14_ele <- compet14 %>%
  filter(resultado2 =="Eleito")

compet14_nele <- compet14 %>%
  filter(resultado2 !="Eleito")

## teste de media

t.test(x=compet02_ele$despesa, y=compet02_nele$despesa)
t.test(x=compet06_ele$despesa, y=compet06_nele$despesa)
t.test(x=compet10_ele$despesa, y=compet10_nele$despesa)
t.test(x=compet14_ele$despesa, y=compet14_nele$despesa)


# salvando os compets

save(compet02, file="compet02.RDATA")
save(compet06, file="compet06.RDATA")
save(compet10, file="compet10.RDATA")
save(compet14, file="compet14.RDATA")