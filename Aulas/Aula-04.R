
# Operações lógicas -------------------------------------------------------

6 > 3
6 < 3
6 >= 3
6 <= 3
6 == 3

# Lógica com NA
NA > 5
10 == NA

# Outros operadores
TRUE | FALSE
TRUE & FALSE
TRUE & TRUE
FALSE & FALSE
!TRUE


# Passando esses operados para dentro da condição -------------------------

x <- 5

if (x > 10) {
  print("x é maior do que 10")
} else {
  print("x é menor ou igual a 10")
}


# Funções aninhadas -------------------------------------------------------

x <- 3

if (x > 5) {
  print("x é maior do que 5")
} else if (x == 5) {
  print("x é igual a 5")
} else {
  print("x é menor do que 5")
}


# Exemplo econômico -------------------------------------------------------

desemprego <- 7.5
desemprego_nat <- 8  

if (desemprego > desemprego_nat) {
  print("Desemprego acima do natural")
} else if (desemprego == desemprego_nat) {
  print("Desemprego igual ao natural")
} else {
  print("Desemprego abaixo do natural")
}

pib <- c(2000, 6000, 8000, 1000)

# Ifelse para mais de um valor
ifelse(test = pib >= 6000, 
       yes = "PIB é alto",
       no = "PIB é baixo")  

desemprego <- c(7, 8, 9)
desemprego_nat <- c(6, 7, 8)

if (desemprego > desemprego_nat) {
  print("Desemprego acima do natural")
} else if (desemprego == desemprego_nat) {
  print("Desemprego igual ao natural")
} else {
  print("Desemprego abaixo do natural")
}


# Através de comparação lógica --------------------------------------------

dados1 <- data.frame(
  municipio = c("Parnaíba", "Teresina", "Picos"),
  pib = pib[1:3],
  desemprego = desemprego 
)

dados1$desemprego_alto <- dados1$desemprego > 8

dados1


# for ---------------------------------------------------------------------

for (i in 1:5) {
  print(i)
}

library(tidyverse)


# Diferença entre ifelse e if_else ----------------------------------------

a <- factor(sample(x = letters[1:5], size = 10, replace = T))

ifelse(a %in% c("a", "c"), a, NA)
a

if_else(a %in% c("a", "c"), a, NA)


# Passando o if e else if para função -------------------------------------
library(readxl)
install.packages("readxl")

dados_salarios <- read_excel(path = "dados/Dados_EB.xls", 
                             sheet = 1, skip = 1)

# demonstração de NA
is.na(c(TRUE, FALSE, NA))
is.na(c("a", NA, "c"))

8 / NA
mean()
median()


# Construindo um índice de vulnerabilidade --------------------------------

indice_vulnerabilidade <- function(salario, 
                                   n_filhos, 
                                   regiao) {
  if (is.na(salario) | is.na(n_filhos) | is.na(regiao))
    return(NA)
  
  score <- salario - 0.7 * n_filhos
  
  score <- if_else(regiao == "interior", score + 2, score)
  
  if (score < 3) {
    return("Alta")
  } else if (score < 7) {
    return("Média")
  } else {
    return("Baixa")
  }
}

dados_salarios$vulnerabilidade <- mapply(indice_vulnerabilidade,
                                     salario = dados_salarios$`Salario (x Sal Min)`,
                                     n_filhos = dados_salarios$`N de Filhos`,
                                     regiao = dados_salarios$`Região de Procedência`)

# Um número é par se for divisível por dois, o que, no R, 
# você pode descobrir com x %% 2 == 0. Use este fato e 
# ifelse() para determinar se cada número entre 0 e 20 é 
# par ou ímpar.

ifelse(test = 0:20 %% 2 == 0, yes = "Par", no = "Ímpar")


# Dado um vetor de dias como x <- c("Segunda-feira", 
# "Sábado", "Quarta-feira"), use uma instrução ifelse() 
# para rotulá-los como fins de semana ou dias de semana.

x <- c("Segunda-feira", "Sábado", "Quarta-feira")

ifelse(x == "Sábado", yes = "Fim de semana", 
       no = "Dia da semana")

# Crie uma função que calcule a carga familiar usando o 
# salário e número de filhos:
# Fórmula: score = salario - 0.7 * n_filho

ind_carga_familiar <- function(salario, 
                               n_filhos) {
  if (is.na(n_filhos))
    return(NA)
  
  score <- salario - 0.7 * n_filhos
  
  if (score < 5) {
    return("Alta")
  } else if (score < 10) {
    return("Média")
  } else {
    return("Baixa")
  }
}

dados_salarios$carga_familiar <- mapply(
  ind_carga_familiar,
  salario = dados_salarios$`Salario (x Sal Min)`,
  n_filhos = dados_salarios$`N de Filhos`
)
