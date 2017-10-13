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
load(file="share14.RDATA")

#2010
load(file="share10.RDATA")

#2006
load(file="share06.RDATA")

#2002
load(file="share02.RDATA")

### Calculando os 90%

cvg90_14 <-mutate(cvg14, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg90_10 <-mutate(cvg10, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg90_06 <-mutate(cvg06, threshold = ifelse((flag==1),VOTOS*0.9,0))
cvg90_02 <-mutate(cvg02, threshold = ifelse((flag==1),VOTOS*0.9,0))

###80
cvg80_14 <-mutate(cvg14, threshold = ifelse((flag==1),VOTOS*0.8,0))
cvg80_10 <-mutate(cvg10, threshold = ifelse((flag==1),VOTOS*0.8,0))
cvg80_06 <-mutate(cvg06, threshold = ifelse((flag==1),VOTOS*0.8,0))
cvg80_02 <-mutate(cvg02, threshold = ifelse((flag==1),VOTOS*0.8,0))

###75
cvg75_14 <-mutate(cvg14, threshold = ifelse((flag==1),VOTOS*0.75,0))
cvg75_10 <-mutate(cvg10, threshold = ifelse((flag==1),VOTOS*0.75,0))
cvg75_06 <-mutate(cvg06, threshold = ifelse((flag==1),VOTOS*0.75,0))
cvg75_02 <-mutate(cvg02, threshold = ifelse((flag==1),VOTOS*0.75,0))

## 90 planilha auxilliar idleg threshold

aux90_idleg_02 <- cvg90_02 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux90_idleg_06 <- cvg90_06 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux90_idleg_10 <- cvg90_10 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux90_idleg_14 <- cvg90_14 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))

### merge de volta

ncvg02 <- merge(cvg90_02, aux90_idleg_02, by="idleg", all.x = TRUE)
ncvg06 <- merge(cvg90_06, aux90_idleg_06, by="idleg", all.x = TRUE)
ncvg10 <- merge(cvg90_10, aux90_idleg_10, by="idleg", all.x = TRUE)
ncvg14 <- merge(cvg90_14, aux90_idleg_14, by="idleg", all.x = TRUE)


## 80 planilha auxilliar idleg threshold

aux80_idleg_02 <- cvg80_02 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux80_idleg_06 <- cvg80_06 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux80_idleg_10 <- cvg80_10 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux80_idleg_14 <- cvg80_14 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))

### merge de volta

ocvg02 <- merge(cvg80_02, aux80_idleg_02, by="idleg", all.x = TRUE)
ocvg06 <- merge(cvg80_06, aux80_idleg_06, by="idleg", all.x = TRUE)
ocvg10 <- merge(cvg80_10, aux80_idleg_10, by="idleg", all.x = TRUE)
ocvg14 <- merge(cvg80_14, aux80_idleg_14, by="idleg", all.x = TRUE)


## 75 planilha auxilliar idleg threshold

aux75_idleg_02 <- cvg75_02 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux75_idleg_06 <- cvg75_06 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux75_idleg_10 <- cvg75_10 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))


aux75_idleg_14 <- cvg75_14 %>%
  group_by(idleg)%>%
  summarize(threshold_leg = sum(threshold))

### merge de volta

scvg02 <- merge(cvg75_02, aux75_idleg_02, by="idleg", all.x = TRUE)
scvg06 <- merge(cvg75_06, aux75_idleg_06, by="idleg", all.x = TRUE)
scvg10 <- merge(cvg75_10, aux75_idleg_10, by="idleg", all.x = TRUE)
scvg14 <- merge(cvg75_14, aux75_idleg_14, by="idleg", all.x = TRUE)


###
### gastos por estado

uf_tot02 <- cvg02 %>%
filter(!(is.na(VOTOS)))%>%  
group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


uf_tot06 <- cvg06 %>%
  filter(!(is.na(VOTOS)))%>%
    group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


uf_tot10 <- cvg10 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

uf_tot14 <- cvg14 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


### total por uf nos thresholds

# 90

ncompet02 <- ncvg02 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ncompet06 <- ncvg06 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ncompet10 <- ncvg10 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ncompet14 <- ncvg14 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))



nuf_tot02 <- ncompet02 %>%
  filter(!(is.na(VOTOS)))%>%  
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


nuf_tot06 <- ncompet06 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


nuf_tot10 <- ncompet10 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

nuf_tot14 <- ncompet14 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

#80

# 90

ocompet02 <- ocvg02 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ocompet06 <- ocvg06 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ocompet10 <- ocvg10 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

ocompet14 <- ocvg14 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))



ouf_tot02 <- ocompet02 %>%
  filter(!(is.na(VOTOS)))%>%  
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


ouf_tot06 <- ocompet06 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


ouf_tot10 <- ocompet10 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

ouf_tot14 <- ocompet14 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


#75



scompet02 <- scvg02 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

scompet06 <- scvg06 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

scompet10 <- scvg10 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))

scompet14 <- scvg14 %>%
  filter((VOTOS>threshold_leg) & (resultado!="NÃO ELEITO"))



suf_tot02 <- scompet02 %>%
  filter(!(is.na(VOTOS)))%>%  
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


suf_tot06 <- scompet06 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))


suf_tot10 <- scompet10 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

suf_tot14 <- scompet14 %>%
  filter(!(is.na(VOTOS)))%>%
  group_by(uf)%>%
  summarise(total_votos = sum(VOTOS))

## names

colnames(nuf_tot02)[1:2]<-c("uf","10%")
colnames(nuf_tot06)[1:2]<-c("uf","10%")
colnames(nuf_tot10)[1:2]<-c("uf","10%")
colnames(nuf_tot14)[1:2]<-c("uf","10%")

colnames(ouf_tot02)[1:2]<-c("uf","20%")
colnames(ouf_tot06)[1:2]<-c("uf","20%")
colnames(ouf_tot10)[1:2]<-c("uf","20%")
colnames(ouf_tot14)[1:2]<-c("uf","20%")

colnames(suf_tot02)[1:2]<-c("uf","25%")
colnames(suf_tot06)[1:2]<-c("uf","25%")
colnames(suf_tot10)[1:2]<-c("uf","25%")
colnames(suf_tot14)[1:2]<-c("uf","25%")

### merging

# 2002

tot_uf02 <- merge(x=uf_tot02, y=nuf_tot02, by="uf")
tot_uf02 <- merge(x=tot_uf02, y=ouf_tot02, by="uf")
tot_uf02 <- merge(x=tot_uf02, y=suf_tot02, by="uf")

write.csv2(tot_uf02, file="tot_uf02.csv")

tot_uf06 <- merge(x=uf_tot06, y=nuf_tot06, by="uf")
tot_uf06 <- merge(x=tot_uf06, y=ouf_tot06, by="uf")
tot_uf06 <- merge(x=tot_uf06, y=suf_tot06, by="uf")

write.csv2(tot_uf06, file="tot_uf06.csv")

tot_uf10 <- merge(x=uf_tot10, y=nuf_tot10, by="uf")
tot_uf10 <- merge(x=tot_uf10, y=ouf_tot10, by="uf")
tot_uf10 <- merge(x=tot_uf10, y=suf_tot10, by="uf")

write.csv2(tot_uf10, file="tot_uf10.csv")

tot_uf14 <- merge(x=uf_tot14, y=nuf_tot14, by="uf")
tot_uf14 <- merge(x=tot_uf14, y=ouf_tot14, by="uf")
tot_uf14 <- merge(x=tot_uf14, y=suf_tot14, by="uf")

write.csv2(tot_uf14, file="tot_uf14.csv")