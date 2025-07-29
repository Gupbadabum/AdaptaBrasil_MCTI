# 02_funcoes_auxiliares.R

#' Categoriza dados conforme limites especificados
#' 
#' @param X Objeto sf com os dados
#' @param Y1 Labels para modelos
#' @param Y2 Labels para referência
#' @param W1 Classes para modelos
#' @param W2 Classes para referência
#' @return Objeto sf com dados categorizados
fun_cat <- function(X, Y1, Y2, W1, W2) {
  X1 <- X %>% st_drop_geometry()
  X2 <- X1
  
  # Categorizando colunas de modelos
  for(i in 2:(ncol(X1)-1) {
    X2[,i] <- as.numeric(as.character(
      cut(X1[,i], breaks = W1, include.lowest = TRUE, 
      right = FALSE, labels = Y1)
    )
  }
  
  # Categorizando coluna de referência
  X2[,ncol(X1)] <- as.numeric(as.character(
    cut(X1[,ncol(X1)], breaks = W2, include.lowest = TRUE, 
    right = FALSE, labels = Y2)
  )
  
  # Calculando Índice
  X3 <- X1
  for(i in 2:(ncol(X1)-1)) {
    X3[,i] <- X2[,i] + X2[,ncol(X2)]
  }
  
  X3[,ncol(X1)] <- X2[,ncol(X1)]
  
  # Preparando resultado final
  X5 <- X
  X5$GFDL_ESM4 <- X3[,2]
  X5$INM_CM5 <- X3[,3]
  X5$MPI_ESM1_2_HR <- X3[,4]
  X5$MRI_ESM2_0 <- X3[,5]
  X5$NORESM2_MM <- X3[,6]
  X5$OBS <- X3[,7]
  
  return(X5)
}

#' Calcula a moda de um vetor
#' 
#' @param x Vetor de valores
#' @return Valor modal
Mode <- function(x) {
  x <- x[!is.na(x)]  
  ux <- sort(unique(x))
  ux[which.max(tabulate(match(sort(x), ux)))]
}
