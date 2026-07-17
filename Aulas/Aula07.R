
# Pacotes a serem utilizados ----------------------------------------------

library(tidyverse)

# manipulação e junção de dados
library(dplyr)

# pivotagem dos dados
library(tidyr)

# visualização dos dados
library(ggplot2)

install.packages("dados")
library(dados)

# Conhecendo a base -------------------------------------------------------

data()

us_rent_income

glimpse(us_rent_income)

summary(us_rent_income)

mtcars

glimpse(mtcars)


# Visualização de dados ---------------------------------------------------

# gráfico de pontos
ggplot(data = mtcars, 
       mapping = aes(x = mpg, y = qsec)) +
  geom_point()

# gráfico de linhas
ggplot(data = mtcars,
       mapping = aes(x = hp, y = mpg)) +
  geom_line()

# gráfico de barras
ggplot(data = mtcars,
       mapping = aes(factor(cyl))) +
  geom_bar()

# gráfico de colunas
ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_col()

starwars

#novamente: gráfico de barras
ggplot(starwars, aes(gender)) +
  geom_bar()

# gráfico de coluna
ggplot(starwars, aes(gender, height)) +
  geom_col()

starwars |> 
  drop_na(gender) |> 
  group_by(gender) |> 
  summarise(
    n = n(),
    .groups = "drop"
  ) |> 
  mutate(
    prop = 100 * n / sum(n)
  ) |> 
  ggplot(aes(gender, prop)) +
  geom_col()

# gráfico de histograma
ggplot(starwars, aes(height)) +
  geom_histogram()

# gráfico de densidade
ggplot(starwars, aes(height)) +
  geom_density()

# gráfico de boxplot
ggplot(starwars, aes(gender, height)) +
  geom_boxplot()

# gráfico de violino
ggplot(starwars, aes(gender, height)) +
  geom_violin()

# violino e boxplot
ggplot(starwars, aes(gender, height)) +
  geom_violin() +
  geom_boxplot()

# com reta de regressão
p <- ggplot(starwars, aes(height, log(mass))) +
  geom_point()

p
