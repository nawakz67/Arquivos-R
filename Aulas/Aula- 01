
# Pacotes -----------------------------------------------------------------
library(tidyverse)

?install.pakcages

install.packages("skimr")

library(skimr)

help(package = "dplyr")


# Vetores -----------------------------------------------------------------
a <- 2
b <- "olá"

nome <- "André"
aprovado <- TRUE

Nome <- "André"
inédito <- 3


# Classe de vetores -------------------------------------------------------
class(a)
class(b)


# Vetores com mais de 1 valor ---------------------------------------------
a <- c(1, 2, 3, 4, 5)
b <- c("a", "b", "c")
c <- c(1.12, 5.5, 6, 8.7)

?seq
seq(from = 1, to = 10, by = 1)

d <- c(TRUE, TRUE, FALSE)

nome <- "Leandro"

print("Olá, meu nome é André")
paste0("Olá, meu nome é ", nome)


# Operações com vetores ---------------------------------------------------
2 + 2
2 / 2
2 * 2
3 %% 2
3 %/% 2

(2 + 2) / (3 * 2)

preco <- c(2, 4, 10, 6, 20)
quantidade <- c(10, 8, 5, 9, 2)

receita <- preco * quantidade

# Reciclagem 
a <- 1:8
b <- c(10, 20)

a + b

c <- 1:4
d <- 1
c + d

salarios <- c(200, 300, 400)
bonificacao <- c(100, 50, 0)

salarios + bonificacao


# Acessando posição de vetores --------------------------------------------
nomes <- c("Refri", "Pizza", "Café")

nomes[1]
nomes[2]
nomes[1:2]
nomes[c(1, 3)]
nomes[-1]

nomes_produto <- c("Refri" = 2, "Pizza" = 5, "Café" = 1)
nomes_produto
nomes_produto[c("Refri", "Pizza")]
nomes_produto["Refri"]

max(nomes_produto)
which.max(nomes_produto)

e <- c(3, 5, 7, 8)
max(e)
which.max(e)

min(e)
which.min(e)


# Acessar posição por condição --------------------------------------------
produto <- c(2, 7, 9, 1, 6, 8, -1, -4)
produto

produto[produto > 5]
produto > 5
produto[produto >= 8]


# Modificar vetores -------------------------------------------------------
lucro <- c(8, -1, -3, 5, 10)

lucro[lucro < 0] <- 0
lucro

lucro[lucro == 0] <- "a"
lucro

lucro + 2


# Coerção de dados --------------------------------------------------------
a <- c(1, 2, 3, 4, TRUE)
class(a)
a

b <- c(1, 3, "a")
class(b)
b[3] <- NA
b
b <- as.numeric(b)
b + 2

# character > numeric > logical > NA


# Conversão dos dados -----------------------------------------------------
logico <- c(T, T, F)
as.numeric(logico)

numero <- c(1, 2, 3, 4)
as.character(numero)


# Vetores com valores ausentes --------------------------------------------
ausente <- c(3, 5, 6, NA)
ausente

preco <- c(10, 20, 15, 30)
quantidade <- c(100, 50, 80, 40)
custo <- c(800, 600, 900, 1250)


# Resolução exercício fixação ---------------------------------------------
preco <- c(10, 20, 15, 30)
quantidade <- c(100, 50, 80, 40)
custo <- c(800, 600, 900, 1250)

#Calcule a receita de cada produto
receita <- preco * quantidade

receita

#Calcule o lucro de cada produto
lucro <- receita - custo
lucro

#Mostre quais produtos tiveram lucro positivo
lucro[lucro > 0]

#Qual produto teve maior lucro?
max(lucro)

which.max(lucro)

paste0("O produto que teve maior lucro encontra-se na posição:",
       which.max(lucro))

#Existe algum produto que deu prejuízo?
min(lucro)

which.min(lucro)

paste0("O produto que deu prejuízo está nas posição:",
       which.min(lucro))

#Substitua os lucros negativos por 0 (como se a empresa ignorasse prejuízo)
lucro[lucro < 0] <- 0
lucro

# Vetores aumentados ------------------------------------------------------
porte <- c("pequeno", "grande", "médio", "pequeno", "grande")
porte

as.factor(porte)

porte_fator <- factor(x = porte, 
                      levels = c("pequeno", "médio", "grande"),
                      ordered = T)
porte_fator

class(porte_fator)
