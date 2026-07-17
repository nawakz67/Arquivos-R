
# Diretório do trabalho ---------------------------------------------------

getwd()

# Pacotes
library(tidyverse)

install.packages("tidyverse")
install.packages("skimr")

library(tidyverse)
library(skimr)

search()

# Dados do R
data()
data(package = "ggplot2")

# Data frames
c(2 + 2)
c(2, 2) + c(2, 2)

pais <- c("Brasil", "Estados Unidos", "China", "Rússia")
pib <- c(2000, 5000, 4000, 2500)
desenvolvido <- c(FALSE, TRUE, TRUE, TRUE)

df <- data.frame(
  pais = pais, pib = pib, desenvolvido = desenvolvido
)

df

df <- data.frame(
  paises = pais, produto = pib, indust = desenvolvido
)
df

salarios <- data.frame(
  pessoa = c("a", "b", "c", "d"),
  renda = c(2000, 4000, 1500, 7000),
  empregado = c(T, F, T, T)
)

salarios

# Funções básica no R
str(salarios)
attributes(salarios)
names(salarios)
class(salarios)

library(tidyverse)
glimpse(salarios)

# Dados do tipo tidy data
as_tibble(salarios)
salarios <- as_tibble(salarios)
salarios

# Outras funções
summary(salarios)
dim(salarios)

# Data frames com tibble
paises <- tibble(
  pais = pais, pib = pib, desenvolvido = desenvolvido
)
paises

# Acessar posições do data frame
paises
paises$pais
paises$pib

# Acessar 2 primeiras linhas
paises[1:2,]
paises[2,]

# segunda linha da terceira coluna
paises[2 , 3]
paises[1,"pib"]

# Menos a segunda coluna
paises[, -2]

pib <- paises[, 2]
pib

dados <- tibble(
  pessoa = c("Carlos", "Seu zé", "Maria", "Leandro"),
  altura = c(172, 165, 160, 180),
  renda = c(2000, 4000, 9000, 1500)
)

# Acessar elemento por condição
dados$renda[dados$renda < 4000]
dados[dados$renda < 4000, ]
dados[dados$renda < 4000, 1]

dados$renda < 4000

# &, |
dados[dados$renda < 4000 & dados$altura < 180, ]
dados$renda < 4000 & dados$altura < 180

# Passando para uma nova coluna
dados$teste <- dados$renda < 4000 & dados$altura < 180
dados

# Alterar valores via posição
dados[dados$renda == 1500, "renda"] <- 2000
dados

dados[4, 1] <- NA
dados

# Alterações em colunas via operações matemáticas
paises <- tibble(
  pais = c("A", "B", "C", "D"),
  pop = c(200, 500, 1400, 50),
  desemprego = c(3.5, 2, 1.5, 1),
  pib = c(4000, 700, 2000, 100)
)

paises

paises$pib / paises$pop
paises$pib_percapita <- paises$pib / paises$pop
paises

paises$pib_mil <- paises$pib / 1000
paises
paises$pib <- paises$pib / 1000
paises

# Remover componentes
NULL

paises$pib_mil <- NULL
paises$pais <- NA
paises
library(tidyverse)

paises <- tibble(
  pais = c("Brasil", "Argentina", "Chile", "Peru"),
  pop = c(203, 46, 19, 34),
  desemprego = c(7.8, 6.5, 8.7, 7.2),
  pib = c(2174, 633, 335, 268)
)
paises
#Mostre apenas as colunas pais e pib.
paises[, c("pais", "pib")]
paises[, c(1, 4)]
paises[, -c(2, 3)]

#Mostre apenas os países com pib maior que 300.
paises[paises$pib > 300, ]
paises$pib > 300

#Crie uma nova coluna chamada pib_percapita, que 
#representa a divisão do pib pela população
paises$pib_percapita <- paises$pib / paises$pop
paises

#Crie uma nova coluna chamada desemprego_alto, que deve 
# ser: TRUE para desemprego maior que 7 e FALSE 
# caso contrário
paises$desemprego_alto <- paises$desemprego > 7
paises

#Altere o valor do desemprego do Chile para 8 e 
#remova a coluna pop
paises[3, 3] <- 8
paises$pop <- NULL
paises

paises |> 
  mutate(desemprego = replace(x = desemprego, 
                              pais == "Chile", 8)) |> 
  select(-pop)

# Listas
lista <- list(
  a = c(1, 2, 3, 4),
  dados = paises,
  c = c("letra a" = "a","letra b" = "b","letra c" = "c","letra d" = "d"),
  matriz = matrix(data = c(1, 2, 3, "d"), nrow = 2)
)

paises <- tibble(
  pais = c("Brasil", "Argentina", "Chile", "Peru"),
  pop = c(203, 46, 19, 34),
  desemprego = c(7.8, 6.5, 8.7, 7.2),
  pib = c(2174, 633, 335, 268)
)

# Acessar posição da lista
paises
lista 

lista$matriz
lista[[1]]
lista[[1]][1]

# Modificar as posições da lista
lista[[3]][2] <- NA
lista

lista[[1]] <- NULL
lista

lista$dados$desemprego
lista[["c"]][3]
lista[["c"]]["letra c"]

lista_econ <- list(
  paises = paises,
  codigos = c("Brasil" = "BRA", 
              "Argentina" = "ARG", 
              "Chile" = "CHL", 
              "Peru" = "PER"),
  anos = c(2021, 2022, 2023, 2024)
)

# Modifique, dentro da lista, o código do Peru de 
# “PER” para “PRU”
lista_econ[["codigos"]][4]
lista_econ[["codigos"]]["Peru"] <- "PRU"
lista_econ

# Para listas
lapply(lista_econ, summary)

# Para dataframes
apply(paises[, 2:4],2, mean)
apply(paises[, 2:4], 1, mean)
apply(paises[, 2:4], 1, sum)

paises
