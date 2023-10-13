# Cleaning CNPJ data

cls <- c(V1="character", #cnpj basico (1-8)
         V2="character", # cnpj ordem (9-12)
         V3="character", # cnpj dv (13-14)
         V19="character", # cep
         V21="character") # codigo do municipio

cls2 <- c(V1="character") #cnpj basico (1-8)

## loading datasets
est0 <- read.csv2("cnpj-data/est0.csv", colClasses=cls, header=F)
est1 <- read.csv2("cnpj-data/est11.csv", colClasses=cls, header=F)
est2 <- read.csv2("cnpj-data/est22.csv", colClasses=cls, header=F)
est3 <- read.csv2("cnpj-data/est3.csv", colClasses=cls, header=F)
est4 <- read.csv2("cnpj-data/est4.csv", colClasses=cls, header=F)
est5 <- read.csv2("cnpj-data/est5.csv", colClasses=cls, header=F)
est6 <- read.csv2("cnpj-data/est66.csv", colClasses=cls, header=F)
est7 <- read.csv2("cnpj-data/est77.csv", colClasses=cls, header=F)
est8 <- read.csv2("cnpj-data/est8.csv", colClasses=cls, header=F)
est9 <- read.csv2("cnpj-data/est99.csv", colClasses=cls, header=F)

simples <- read.csv2("simpless.csv",colClasses=cls2, header=F)

library(dplyr)
library(tidyr)

# splitting the dates for simples adoption, simples exclusion, mei adoption, mei exclusion
simples <- simples %>% 
  separate(V3, into=c('simpstyr', 'simpstmo', 'simpstday'), sep=c(4,6)) %>%
  separate(V4, into=c('simpexcyr', 'simpexcmo', 'simpexcday'), sep=c(4,6)) %>%
  separate(V6, into=c('meistyr', 'meistmo', 'meistday'), sep=c(4,6)) %>%
  separate(V7, into=c('meiexcyr', 'meiexcmo', 'meiexcday'), sep=c(4,6)) %>%
  rename('simpstatus'='V2') %>% 
  rename('meistatus'='V5')

# Selecting only variables of interest
# V1  is unique identifier (CNPJ)
# V6  is situacao cadastral
# V7  is data do evento da situacao cadastral
# V11 is data de inicio da atividade
# V19 is CEP
# V20 is UF
# V21 is municipality code (IBGE)

est0 <- est0 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est1 <- est1 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est2 <- est2 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est3 <- est3 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est4 <- est4 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est5 <- est5 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est6 <- est6 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est7 <- est7 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est8 <- est8 %>% select(c(V1, V6, V7, V19, V20, V21, V11))
est9 <- est9 %>% select(c(V1, V6, V7, V19, V20, V21, V11))

spallest <- rbind(est0, est1, est2, est3, est4, est5, est6, est7, est8, est9)
spallest <- left_join(spallest, simples, by='V1')

write.csv(spallest, "spallest.csv")

