# 03_processamento.R

#' Processa dados para um bioma específico
#' 
#' @param bioma Nome do bioma a ser processado
#' @param dados_obs Dados de observação
#' @param input_ref Dados de referência
#' @param config Lista de configurações
#' @return Lista com resultados processados
processar_bioma <- function(bioma, dados_obs, input_ref, config) {
  # Recorta área de interesse
  bioma_sel <- subset(config$mapa_biomas, Bioma %in% bioma)
  rec_obs <- input_ref[bioma_sel, crop = TRUE]
  
  # Calcula breaks para observação
  break_obs <- round(quantile(
    unique(rec_obs$Qmlt_obs), 
    probs = seq(0, 1, by = 0.2), 
    na.rm = TRUE
  ), 5)
  
  # Processa cada cenário e período
  resultados <- list()
  
  for(cenario in config$cenarios) {
    for(periodo in config$periodos) {
      dados_modelo <- carregar_dados_modelo(
        config$dir_dados, cenario, periodo
      )
      
      # Adiciona dados de observação
      dados_modelo$OBS <- rec_obs$Qmlt_obs
      
      # Calcula breaks para modelos
      breaks <- calcular_breaks_modelo(dados_modelo, cenario, config)
      
      # Categoriza dados
      resultados[[bioma]][[cenario]][[periodo]] <- list(
        ana = fun_cat(dados_modelo, config$lab_ana, config$lab_obs, 
                     breaks$ana, break_obs),
        cat85 = fun_cat(dados_modelo, config$lab_mod, config$lab_obs,
                       breaks$cat85, break_obs),
        catFUL = fun_cat(dados_modelo, config$lab_mod, config$lab_obs,
                        breaks$catFUL, break_obs)
      )
    }
  }
  
  return(resultados)
}

#' Função principal que processa todos os biomas
#' 
#' @param biomas Vetor de biomas a processar
#' @param modelos Vetor de modelos a considerar
#' @param cenarios Vetor de cenários a processar
#' @param periodos Vetor de períodos a processar
#' @return Lista com todos os resultados
processar_biomas <- function(biomas, modelos, cenarios, periodos) {
  # Carrega dados iniciais
  dados_obs <- carregar_dados_referencia(config$caminho_dados_obs)
  mapa_biomas <- carregar_biomas(config$caminho_biomas)
  input_ref <- carregar_dados_referencia_espaciais(config$caminho_ref)
  
  # Configura ambiente
  config <- list(
    mapas_biomas = mapa_biomas,
    lab_mod = 6:0,
    lab_ana = 6:1,
    lab_obs = 5:1,
    dir_dados = config$dir_dados,
    cores = c('darkgreen', 'green2', 'khaki1', 'darkorange', 'red'),
    classes = c('Muito Baixo', 'Baixo', 'Moderado', 'Alto', 'Muito Alto')
  )
  
  # Processa cada bioma
  resultados <- lapply(biomas, function(b) {
    processar_bioma(b, dados_obs, input_ref, config)
  })
  names(resultados) <- biomas
  
  return(resultados)
}
