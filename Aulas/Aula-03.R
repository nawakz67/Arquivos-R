
# Pacotes -----------------------------------------------------------------

library(tidyverse)

install.packages("tidyverse")


# Importando dados TXT ----------------------------------------------------

unzip(zipfile = "dados/dados_txt.zip", exdir = "dados/")

dados_txt1 <- read_table(file = "dados/pesoAltura.txt")

glimpse(dados_txt1)

dados_txt1[2, 2]


# importando dados txt com cabeçalho --------------------------------------

dados_txt2 <- read_table("dados/pesoAltura1.txt")

class(dados_txt2)

# Escrita de arquivos txt -------------------------------------------------

write.table(x = dados_txt2, 
            file = "dados/dados_txt2.txt",
            row.names = FALSE)


# Importando arquivos csv -------------------------------------------------

dados_temp <- read_csv(file = "dados/dados_temperatura.csv")

dados_temp2 <- read_csv2("dados/dados_temperatura2.csv")

dados_temp2 <- read_delim("dados/dados_temperatura2.csv",
                          delim = ";")

# Escrita de arquivos csv -------------------------------------------------

write_csv(x = dados_temp, file = "dados/dados_temp.csv")
write_csv2(x = dados_temp2, file = "dados/dados_temperatura22.csv")


# Importando dados excel --------------------------------------------------

library(readxl)

install.packages("readxl")

cafe <- read_excel(path = "dados/CafeTotalSerieHist.xls",
                   skip = 5,
                   n_max = 27,
                   sheet = 2)

notas <- read_excel("dados/notas_alunos.xlsx",
                    skip = 2,
                    sheet = 2,
                    na = "-")
glimpse(notas)


# Escrita em excel --------------------------------------------------------

library(writexl)
install.packages("writexl")

write_xlsx(x = cafe, path = "dados/dados_cafe.xlsx")


# Ler arquivos da web -----------------------------------------------------

url <- "https://raw.githubusercontent.com/datasets/oil-prices/refs/heads/main/data/brent-monthly.csv"

dados1 <- read_csv(url)
glimpse(dados1)
dados1$Date

# Baixando dados
download.file(
  url = "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/dados_temperatura.csv",
  destfile = "dados/dados_baixado.csv")


# Importando arquivos via API ---------------------------------------------

library(jsonlite)
install.packages("jsonlite")

#jsonlite::flatten
#purrr::flatten

cep <- "https://viacep.com.br/ws/64202020/json/"

cep_ufdpar <- fromJSON(cep)
class(cep_ufdpar)
cep_ufdpar

df_ufdpar <- as_tibble(cep_ufdpar)

moedas <- fromJSON(txt = "https://economia.awesomeapi.com.br/json/daily/USD-BRL/15")

ibge <- fromJSON("https://servicodados.ibge.gov.br/api/v1/pesquisas/indicadores/48981%7C62876%7C49645%7C96385%7C29171%7C96386%7C28120%7C28122%7C28123%7C28130%7C28128%7C78187%7C78192%7C5908%7C5913%7C5903%7C5929%7C5934%7C5950%7C5955%7C48986%7C62585%7C62590%7C95345%7C95379%7C143516%7C30255%7C28141%7C29749%7C21910%7C21906%7C21907%7C97964%7C48980%7C95338?localidade=&lang=pt")

ibge <- ibge |> 
  unnest(nota)


# Importando dados diretamente do R ---------------------------------------

library(sidrar)
install.packages("sidrar")

?get_sidra

ipca <- get_sidra(x = 7061,
                  period = "202603",
                  geo = "City",
                  variable = 309,
                  geo.filter = list("State" = 21))

ipca2 <- get_sidra(api = "/t/7061/n1/all/v/306/p/last%201/c315/7169/d/v306%202")

censo_agro <- get_sidra(1116,
                        geo = "State",
                        geo.filter = list("State" = 22),
                        classific = c("c12896"),
                        category = list("c12896" = 119107))

dicionario <- info_sidra(x = 7061)
dicionario
dicionario$variable


# BANCO CENTRAL -----------------------------------------------------------

library(rbcb)
install.packages("rbcb")

ipca_bcb <- get_series(code = c("precos" = 433),
                       start_date = "2025-01-01",
                       end_date = "2026-03-01")

desemprego <- get_series(code = 1620, last = 12)

dplyr::glimpse(ipca_bcb)

credito <- get_series(code = c("atraso_pf" = 21004, 
                               "atraso_pj" = 21005))
credito |> 
  as_tibble(.name_repair = "universal") |> 
  unnest_wider(col = c(atraso_pf, atraso_pj),
               names_sep = "_")
  
class(credito)


# Expectativas de mercado -------------------------------------------------

expectativas <- get_market_expectations(
  type = "monthly",
  indic = "IPCA",
  start_date = "2026-01-01")

notas1 <- c(10, 10, 10, 2)

mean(notas1)

median(notas1)


# Taxas de câmbio ---------------------------------------------------------

cambio <- olinda_get_currency("USD", "2026-01-01",
                              "2026-05-08")

olinda_get_currency("USD", "2017-03-01", "2017-03-10")

cambio_cruzado <- get_currency_cross_rates(date = "2026-05-08")
class(cambio_cruzado)

list_currencies()

cc <- c("BRL", "USD", "EUR", "ARS")

cambio_cruzado[cc, cc]


# IPEADATA ----------------------------------------------------------------
library(ipeadatar)
install.packages("ipeadatar")

divida_externa <- ipeadata(code = "BPAG4_DEXBC4")

desemprego <- ipeadata(code = "WEO_DESEMWEOBRA")

search_series(terms = c("desemprego", "preços"))
