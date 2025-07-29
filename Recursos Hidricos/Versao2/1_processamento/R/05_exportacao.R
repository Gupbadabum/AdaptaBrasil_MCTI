# 05_exportacao.R

#' Exporta resultados para arquivos
#' 
#' @param resultados Lista com todos os resultados
#' @param dir_saida Diretório de saída
exportar_resultados <- function(resultados, dir_saida) {
  # Cria diretórios se não existirem
  dirs <- c(
    file.path(dir_saida, "rec_bioma2"),
    file.path(dir_saida, "Limiares"),
    file.path(dir_saida, "graficos", c("ANA", "85", "FUL"))
  )
  
  lapply(dirs, function(d) if(!dir.exists(d)) dir.create(d, recursive = TRUE))
  
  # Exporta dados por bioma
  for(bioma in names(resultados)) {
    # Exporta limiares
    write.xlsx(
      lim_bioma_obs, 
      file = file.path(dir_saida, "Limiares", sprintf("Limiares_Bioma_%s.xlsx", bioma))
    )
    
    # Exporta shapefiles categorizados
    for(cenario in names(resultados[[bioma]])) {
      for(periodo in names(resultados[[bioma]][[cenario]])) {
        dados <- resultados[[bioma]][[cenario]][[periodo]]
        
        for(tipo_cat in c("ana", "cat85", "catFUL")) {
          st_write(
            dados[[tipo_cat]], 
            file.path(dir_saida, "rec_bioma2", 
                     sprintf("Vazao2_cat_%s_%s_%s_bioma_%s_.gpkg", 
                            periodo, cenario, tipo_cat, bioma))
          )
        }
      }
    }
    
    # Gera gráficos
    gerar_graficos_bioma(resultados, bioma, list(
      modelos = c("GFDL_ESM4", "INM_CM5", "MPI_ESM1_2_HR", "MRI_ESM2_0", "NORESM2_MM"),
      dir_saida = dir_saida,
      cores = c('darkgreen', 'green2', 'khaki1', 'darkorange', 'red'),
      classes = c('Muito Baixo', 'Baixo', 'Moderado', 'Alto', 'Muito Alto')
    ))
  }
  
  # Exporta limiares de observação consolidados
  write.xlsx(
    lim_bioma_obs,
    file = file.path(dir_saida, "Limiares", "Limiares_Bioma_observacao.xlsx")
  )
}
