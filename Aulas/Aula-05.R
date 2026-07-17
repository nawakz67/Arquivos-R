
# Pacotes -----------------------------------------------------------------

library(tidyverse)
install.packages("janitor")
library(janitor)

# Importar dados ----------------------------------------------------------

url <- "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/dados_estados.csv"

dados <- read_csv2(url) |> 
  clean_names()

trad_region <- c(
  North = "Norte",
  Northeast = "Nordeste",
  `Center-west` = "Centro-Oeste",
  Southeast = "Sudeste",
  South = "Sul"
)

dados <- dados |> 
  mutate(
    region = trad_region[region]
  )

dados


# Exploração da base ------------------------------------------------------

glimpse(dados)

head(dados, n = 3)

tail(dados, 3)


# Seleção de colunas ------------------------------------------------------

dados |> 
  select(uf, hdi_2017)

dados |> 
  select(uf, starts_with("hdi"))

# renomear colunas
dados |> 
  select(
    uf,
    estado = state,
    regiao = region,
    populacao = population,
    everything()
  )


# Filtragem de dados ------------------------------------------------------

dados |> 
  filter(region == "Nordeste")

dados |> 
  filter(region != "Nordeste")

dados |> 
  filter(poverty > 0.15)

dados |> 
  filter(hdi_2017 > 0.8 & poverty <= 0.15)

dados |> 
  filter(hdi_2017 > 0.8 | poverty <= 0.15)

dados |> 
  filter(uf %in% c("PI", "MA", "TO"))


# Ordenar dados -----------------------------------------------------------

dados |> 
  arrange(desc(hdi_2017))

dados |> 
  arrange(desc(poverty)) |> 
  select(uf, state, region, poverty)


# Criar novas colunas -----------------------------------------------------

dados_indicadores <- dados |> 
  mutate(
    populacao_milhoes = population / 1e6,
    crescimento_idh = hdi_2017 - hdi_1991,
    classe_idh = case_when(
      hdi_2017 < 0.700 ~ "IDH médio",
      hdi_2017 < 0.800 ~ "IDH alto",
      TRUE ~ "IDH muito alto"
    ),
    classe_pobreza = case_when(
      poverty < quantile(poverty, probs = 0.25) ~ "Baixa pobreza",
      poverty < quantile(poverty, probs = 0.5) ~ "Pobreza intermediária",
      TRUE ~ "Pobreza alta"
    )
  )

# Agrupamento de dados ----------------------------------------------------


dados_indicadores |> 
  group_by(region) |> 
  summarise(
    total_estados = n(),
    media_idh = mean(hdi_2017, na.rm = T),
    populacao_total = sum(population, na.rm = T)
  ) |> 
  arrange(desc(media_idh))


# Contagem de dados -------------------------------------------------------

dados_indicadores |> 
  count(region, sort = TRUE)

dados_indicadores |> 
  count(region, classe_idh, sort = T)


# Exercício ---------------------------------------------------------------
# primeira questão
dados |> 
  select(uf, state, region, hdi_2017, gdp, poverty)

# segunda questão 
dados |> 
  filter(poverty > 0.15)

# terceira questão
dados |> 
  arrange(desc(gdp)) |> 
  select(uf, state, region, gdp)

# quarta questão
dados |> 
  mutate(
    nivel_pobreza = case_when(
      poverty < quantile(poverty, 0.33, na.rm = T) ~ "Baixa pobreza",
      poverty < quantile(poverty, 0.66, na.rm = T) ~ "Pobreza intermediária",
      TRUE ~ "Alta pobreza"
    )
  ) |> 
  select(uf, state, region, nivel_pobreza)

# quinta questão
dados |> 
  group_by(region) |> 
  summarise(
    total_estados = n(),
    media_idh = mean(hdi_2017, na.rm = T),
    media_pobreza = mean(poverty, na.rm = T),
    pib_pc_medio = mean(gdp, na.rm = T),
    pib_pc_mediana = median(gdp, na.rm = T)
  ) |> 
  arrange(desc(media_idh))
