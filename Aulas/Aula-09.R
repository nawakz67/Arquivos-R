
# Pacotes -----------------------------------------------------------------

library(tidyverse)
library(janitor)


# Importação de dados -----------------------------------------------------

url <- "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/endividamento.csv"
url2 <- "https://raw.githubusercontent.com/drewmelo/cursoR/refs/heads/master/dados/salarios.csv"

dados_salarios <- read_csv2(url2)


# Conhecendo a base -------------------------------------------------------

glimpse(dados_salarios)


# Preparar os dados -------------------------------------------------------

dados_salarios <- dados_salarios |> 
  clean_names() |> 
  mutate(
    grau_de_instrucao = factor(
      grau_de_instrucao, levels = c("ensino fundamental",
                                    "ensino médio",
                                    "superior")
    )
  )

glimpse(dados_salarios)


# Visualização de dados ---------------------------------------------------

ggplot(dados_salarios, aes(x = grau_de_instrucao)) +
  geom_bar(fill = "aquamarine4", col = "black") +
  labs(x = "Grau de Instrução",
       y = "Contagem de indivíduos",
       title = "Trabalhadores por grau de instrução") +
  theme_minimal(base_size = 18)

# Barras agrupadas
ggplot(dados_salarios, 
       aes(x = grau_de_instrucao, fill = estado_civil)) +
  geom_bar(position = "dodge") +
  labs(
    fill = "Estado civil"
  ) +
  theme_light(base_size = 16)

# Barras proporcionais
library(scales)

ggplot(dados_salarios, 
       aes(x = grau_de_instrucao,
           fill = estado_civil)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = label_percent()) +
  labs(x = "Grau de Instrução",
       y = "Frequência Relativa",
       subtitle = "Gráfico de barras empilhadas",
       title = "Composição do estado civil por grau de instrução",
       fill = "Estado civil",
       caption = "Fonte: Elaboração própria") +
  theme_minimal(base_size = 16)


# Gráfico de coluna -------------------------------------------------------

percentual_instrucao <- dados_salarios |> 
  group_by(grau_de_instrucao) |> 
  summarise(n = n(), .groups = "drop") |> 
  mutate(percentual = 100 * n / sum(n, na.rm = T))

ggplot(percentual_instrucao,
       aes(x = grau_de_instrucao,
           y = percentual)) +
  geom_col(fill = "lightblue4", color = "black") +
  theme_minimal()


# Gráfico de dispersão ----------------------------------------------------

ggplot(dados_salarios, aes(x = anos, 
                           y = salario_x_sal_min)) +
  geom_point(size = 2, shape = 21, fill = "lightblue2",
             color = "lightblue4") +
  theme_minimal()

ggplot(dados_salarios, aes(anos, salario_x_sal_min)) +
  geom_point(size = 3, color = "lightblue3", alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()


# Gráficos de histograma --------------------------------------------------

ggplot(dados_salarios, 
       aes(x = salario_x_sal_min)) +
  geom_histogram(bins = 8, fill = "#406F99", 
                 col = "white") 

ggplot(dados_salarios, 
       aes(x = salario_x_sal_min, y = after_stat(density))) +
  geom_histogram(bins = 8, fill = "#406F99", 
                 col = "white") 

# Gráfico de boxplot ------------------------------------------------------

ggplot(dados_salarios, aes(x = grau_de_instrucao,
                           y = salario_x_sal_min)) +
  geom_boxplot(fill = "lightblue3", col = "grey20")


# Gráfico de linhas -------------------------------------------------------
library(rbcb)

dados_bcb <- get_series(
  code = c("IPCA" = 13522, "Selic" = 4189)
) |> 
  reduce(inner_join, by = "date")

dados_bcb |> 
  pivot_longer(cols = c(IPCA, Selic)) |> 
  filter(date >= "2000-01-01") |> 
  ggplot(aes(x = date, y = value, color = name)) +
  geom_line()
