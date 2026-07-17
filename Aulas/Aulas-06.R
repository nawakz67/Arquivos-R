
# Pacotes -----------------------------------------------------------------

library(tidyverse)
library(janitor)


# Funções básicas ---------------------------------------------------------

sqrt(64)
abs(-10)
round(3.7865, 1)
log(100)
log10(100)
exp(2)


# Importando dados --------------------------------------------------------

urls <- c(
  "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/gastos_transporte.csv",
  "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/gastos_trabalho.csv",
  "https://raw.githubusercontent.com/kelvins/municipios-brasileiros/refs/heads/main/csv/estados.csv"
)

municipios <- read_csv(urls[3]) |> 
  select(-c(latitude, longitude))

transporte_largo <- read_csv2(urls[1], skip = 1) |> 
  clean_names(use_make_names = FALSE) |> 
  left_join(y = municipios, join_by(sigla == uf)) |> 
  relocate(codigo_uf:regiao, .before = sigla) |> 
  filter(regiao == "Nordeste")

trabalho_largo <- read_csv2(urls[2], skip = 1) |> 
  clean_names(use_make_names = FALSE) |> 
  left_join(municipios, by = c("sigla" = "uf")) |> 
  relocate(codigo_uf:regiao, .before = sigla) |> 
  filter(regiao == "Nordeste")

transporte_largo
trabalho_largo
typeof(transporte_largo$`2014`)
class(transporte_largo$`2014`)


# Pivotagem dos dados -----------------------------------------------------

transporte_longo <- transporte_largo |> 
  pivot_longer(
    cols = starts_with("20"),
    names_to = "ano",
    values_to = "gastos_transporte"
  )

trabalho_longo <- trabalho_largo |> 
  pivot_longer(
    cols = starts_with("20"),
    names_to = "ano",
    values_to = "gasto_trabalho"
  )


# União das bases ---------------------------------------------------------
intersect(names(trabalho_largo), names(transporte_largo))

# formato largo
gastos_join <- transporte_largo |> 
  left_join(trabalho_largo,
            by = c("sigla", "codigo", "municipio"),
            suffix = c("_transporte", "_trabalho")) |> 
  pivot_longer(cols = contains("20")) 

# formato longo
gastos_municipais <- transporte_longo |> 
  left_join(trabalho_longo,
            by = c("sigla", "codigo", 
                   "municipio", "ano")) |> 
  select(-ends_with(".y"), -`15.x`) |> 
  rename(
    codigo_uf = codigo_uf.x,
    estado = nome.x,
    regiao = regiao.x
  )

20 + NA  

gastos_municipais <- gastos_municipais |> 
  mutate(
    gasto_total = gasto_trabalho + gastos_transporte,
    transporte_porcent = gastos_transporte / gasto_total
  )


# Outras junções ----------------------------------------------------------

gastos_inner <- transporte_longo |> 
  inner_join(
    trabalho_longo,
    by = c("sigla", "codigo", "municipio", "ano")
  )

band_instruments
band_members

inner_join(x = band_instruments, y = band_members,
           by = "name")

left_join(x = band_instruments, y = band_members,
           by = "name")

right_join(x = band_instruments, y = band_members,
          by = "name")

full_join(x = band_instruments, y = band_members,
           by = "name")


# Exercício de fixação 01 -------------------------------------------------

# A

urls <- c(
  "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/gastos_seguranca_defesa.csv",
  "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/gastos_urbanismo_habitacao.csv"
)

seguranca <- read_csv2(urls[1], skip = 1) |> 
  clean_names()

urbanismo_habitacao <- read_csv2(urls[2], skip = 1) |> 
  clean_names()

# C

dados_join <- seguranca |>
  left_join(urbanismo_habitacao,
             # letra b
             by = c("sigla", "codigo", "municipio"))

dados_join2 <- seguranca |>
  right_join(urbanismo_habitacao,
            # letra b
            by = c("sigla", "codigo", "municipio"),
            # letra d
            suffix = c("_seguranca", "_urbanismo")
            )

# Exercício de fixação 02 -------------------------------------------------

# letra A
urbanismo_habitacao

# letra b
urbanismo_habitacao <- urbanismo_habitacao |> 
  filter(sigla %in% c("PI", "MA", "TO", "BA"))

# letra c
urbanismo_habitacao_longo <- urbanismo_habitacao |> 
  pivot_longer(cols = contains("20"),
               names_to = "ano",
               values_to = "gastos_urbanismo")
# letra d
urbanismo_habitacao_largo <- urbanismo_habitacao_longo |> 
  pivot_wider(names_from = ano,
              values_from = gastos_urbanismo)

# letra e
glimpse(urbanismo_habitacao_longo)
glimpse(urbanismo_habitacao_largo)
