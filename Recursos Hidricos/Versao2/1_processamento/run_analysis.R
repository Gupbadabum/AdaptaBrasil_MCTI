# run_analysis.R
source("R/01_carregar_dados.R")
source("R/02_funcoes_auxiliares.R")
source("R/03_processamento.R")
source("R/04_visualizacao.R")
source("R/05_exportacao.R")

# Carrega configurações
config <- yaml::read_yaml("config/parametros.yml")

# Executa o processamento principal
resultados <- processar_biomas(
  biomas = config$biomas,
  modelos = config$modelos,
  cenarios = config$cenarios,
  periodos = config$periodos
)

# Exporta resultados
exportar_resultados(resultados, config$dir_saida)
