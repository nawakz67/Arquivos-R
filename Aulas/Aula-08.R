
# PACOTES -----------------------------------------------------------------

library(ggplot2)
library(tidyverse)
library(rbcb)


# Importação dos dados ----------------------------------------------------

data()

us_rent_income


# Conhecendo a base -------------------------------------------------------

glimpse(us_rent_income)

summary(us_rent_income)


# Manipulação de dados ----------------------------------------------------

dados_renda <- us_rent_income |> 
  rename(
    geoid = GEOID,
    estado_nome = NAME,
    variavel = variable,
    estimado = estimate,
    margem_erro90 = moe
  ) |> 
  mutate(
    variavel = recode(
      variavel,
      "income" = "renda",
      "rent" = "aluguel",
      .default = variavel
    )
  )

glimpse(dados_renda)

dados_renda <- dados_renda |> 
  pivot_wider(names_from = variavel,
              values_from = c(estimado, margem_erro90))


# Gráfico de dispersão ----------------------------------------------------

dados_renda |> 
  ggplot(aes(x = estimado_renda, y = estimado_aluguel)) +
  geom_point(size = 2.5, shape = 21, col = "lightblue3", fill = "lightblue3") +
  theme_minimal()


# Dados do banco central  -------------------------------------------------
library(rbcb)

dados_bcb <- get_series(
  code = c(
    ipca = 13522,
    selic = 4390
  ),
  start_date = "2020-01-01",
  end_date = "2026-01-01"
) |> 
  reduce(
    left_join, by = "date"
  ) |> 
  mutate(
    ano = year(date)
  )

# Gráfico de linha
ggplot(data = dados_bcb,
       mapping = aes(x = date, y = ipca)) +
  geom_line(linewidth = 1.6, col = "lightblue3") +
  theme_minimal(base_size = 18) +
  labs(x = "Ano",
       y = "Taxa de inflação",
       title = "Evolução da inflação ao longo dos anos",
       subtitle = "de 2020 a 2026")

# Gráfico de coluna
dados_bcb |> 
  group_by(ano) |> 
  summarise(
    ipca_medio = mean(ipca, na.rm = TRUE),
    .groups = "drop"
  ) |> 
  slice_max(
    order_by = ipca_medio,
    n = 7
  ) |> 
  ggplot(aes(x = reorder(as.factor(ano), ipca_medio), 
             y = ipca_medio)) +
  geom_col(fill = "brown") +
  labs(
    x = NULL,
    y = "IPCA médio",
    title = "Anos com o maior IPCA médio"
  ) +
  theme_bw(base_size = 18)
