# 04_visualizacao.R

#' Gera gráfico para um modelo específico
#' 
#' @param dados Objeto sf com os dados
#' @param modelo Nome do modelo a plotar
#' @param titulo Título do gráfico
#' @param config Lista de configurações
#' @return Gráfico gerado (invisível)
gerar_grafico_modelo <- function(dados, modelo, titulo, config) {
  dados_df <- st_drop_geometry(dados)
  col_idx <- which(names(dados) == modelo)
  
  png(filename = titulo$arquivo, 
      width = 5*480, height = 5*480, 
      type = 'cairo', res = 400)
  
  par(mar = c(1, 1, 8, 1), 
      mai = c(.01, 0.01, 0.1, 0.01), 
      oma = c(.1, .1, 0.1, .1))
  
  plot(dados[col_idx], 
       col = config$cores[findInterval(dados_df[, col_idx], c(1:6), all.inside = TRUE)], 
       main = titulo$texto)
  
  legend('bottomleft', title = 'Classes', 
         legend = config$classes, 
         border = config$cores, 
         fill = config$cores, 
         bty = "n", cex = 1)
  
  dev.off()
  
  invisible()
}

#' Gera todos os gráficos para um bioma
#' 
#' @param resultados Lista com resultados processados
#' @param bioma Nome do bioma
#' @param config Lista de configurações
gerar_graficos_bioma <- function(resultados, bioma, config) {
  modelos <- config$modelos
  
  for(cenario in names(resultados[[bioma]])) {
    for(periodo in names(resultados[[bioma]][[cenario]])) {
      dados <- resultados[[bioma]][[cenario]][[periodo]]
      
      for(tipo_cat in c("ana", "cat85", "catFUL")) {
        for(modelo in modelos) {
          titulo <- list(
            texto = sprintf("Vazão modelo %s Categorias %s - %s - %s", 
                           modelo, toupper(tipo_cat), periodo, cenario),
            arquivo = file.path(config$dir_saida, "graficos",
                               sprintf("%s_%s_%s_%s.png", 
                                      periodo, cenario, tipo_cat, modelo))
          )
          
          gerar_grafico_modelo(
            dados[[tipo_cat]], 
            modelo, 
            titulo, 
            config
          )
        }
      }
    }
  }
}
