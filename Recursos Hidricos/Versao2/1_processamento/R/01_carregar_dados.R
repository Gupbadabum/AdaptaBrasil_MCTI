# 01_carregar_dados.R

#' Carrega dados de referência
#' 
#' @param caminho Caminho para o arquivo CSV
#' @return DataFrame com dados de referência
carregar_dados_referencia <- function(caminho) {
  dado_obs <- read.csv(caminho, header = TRUE, sep = ',', dec = '.')
  
  dado_obs$Qmlt_calc <- dado_obs$dispq95 / dado_obs$relq95qmlt
  dado_obs$Qmlt_calc <- ifelse(
    dado_obs$relq95qmlt == 0 & !is.na(dado_obs$relq95qmlt),
    0,
    dado_obs$Qmlt_calc
  )
  
  return(dado_obs)
}

#' Carrega shapefiles de biomas
#' 
#' @param caminho Caminho para o shapefile
#' @return Objeto sf com os biomas
carregar_biomas <- function(caminho) {
  biomas <- st_read(caminho)
  sf_use_s2(FALSE) # Desativa o uso de geometria esférica
  return(biomas)
}

#' Carrega dados de modelo para um cenário e período
#' 
#' @param caminho_base Caminho base para os arquivos
#' @param cenario Cenário (ex: "ssp245", "ssp585")
#' @param periodo Período (ex: "periodo1", "periodo2", "periodo3")
#' @return Objeto sf com os dados do modelo
carregar_dados_modelo <- function(caminho_base, cenario, periodo) {
  caminho <- sprintf("%s/bho_budyko_mc_%s_deltaqrel_%s.gpkg", 
                    caminho_base, periodo, cenario)
  
  dados <- st_read(caminho) %>% 
    select(
      COBACIA = cobacia,
      GFDL_ESM4 = gfdl_esm4,
      INM_CM5 = inm_cm5_0,
      MPI_ESM1_2_HR = mpi_esm1_2_hr,
      MRI_ESM2_0 = mri_esm2_0,
      NORESM2_MM = noresm2_mm
    )
  
  return(dados)
}
