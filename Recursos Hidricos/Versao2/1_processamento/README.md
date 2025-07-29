# Projeto AdaptaBrasil – Processamento e Categorização de Vazão

Este projeto tem como objetivo categorizar os resultados de vazão em ottobacias de nível 7 em todo o território brasileiro, considerando diferentes cenários climáticos (SSP2-4.5 e SSP5-8.5). A análise permite avaliar os impactos das mudanças climáticas nos recursos hídricos por meio de três abordagens de categorização:

- **Categorização SSP2-4.5 (cenário intermediário)**
- **Categorização SSP5-8.5 (cenário mais severo)**
- **Categorização Combinada (análise integrada)**

## 📁 Estrutura do Repositório

```
/projeto_adaptabrasil/
├── /R/                          # Scripts em R
│   ├── 01_carregar_dados.R      # Carrega dados de entrada
│   ├── 02_funcoes_auxiliares.R  # Funções auxiliares (categorização, moda)
│   ├── 03_processamento.R       # Lógica principal
│   ├── 04_visualizacao.R        # Geração de gráficos
│   ├── 05_exportacao.R          # Exportação de resultados
│   └── run_analysis.R           # Script principal
├── /config/
│   └── parametros.yml           # Configurações ajustáveis
├── /data/                       # Dados brutos (shapefiles, CSVs)
└── /output/                     # Resultados (gráficos, tabelas, shapefiles)
```

## 🔄 Fluxo de Processamento

1. **Configuração inicial (`parametros.yml`)**  
   Define os biomas, modelos climáticos, cenários e caminhos dos arquivos.

2. **Carregamento dos dados (`01_carregar_dados.R`)**  
   Importa os dados de vazão e os shapefiles de biomas e ottobacias.

3. **Processamento principal (`03_processamento.R`)**  
   Aplica a função `fun_cat()` para categorizar as vazões conforme três abordagens:
   - `ANA` (SSP2-4.5): categorização moderada
   - `85` (SSP5-8.5): categorização severa
   - `FULL` (combinada): categorização balanceada

4. **Geração de gráficos (`04_visualizacao.R`)**  
   Produz mapas temáticos para cada modelo, bioma e cenário.

5. **Exportação de resultados (`05_exportacao.R`)**  
   Salva os shapefiles, tabelas de limiares e gráficos no diretório `/output/`.

## 🧮 Abordagens de Categorização

| Abordagem | Base            | Severidade | Descrição                              |
|-----------|------------------|------------|----------------------------------------|
| ANA       | SSP2-4.5         | Moderada   | Cenário de emissões intermediárias     |
| 85        | SSP5-8.5         | Alta       | Cenário de alto aquecimento global     |
| FULL      | SSP2-4.5 + 8.5   | Balanceada | Visão integrada dos dois cenários      |

## 🗂️ Dados de Entrada

- **Ottobacias**: dados hidrológicos de nível 7 cobrindo todo o Brasil.
- **Modelos climáticos utilizados**:
  - GFDL-ESM4
  - INM-CM5
  - MPI-ESM1-2-HR
  - MRI-ESM2-0
  - NORESM2-MM

## 📊 Resultados Gerados

- Shapefiles categorizados por bioma, cenário e período
- Gráficos (PNG) de distribuição das categorias
- Planilhas (XLSX) com os limiares de classificação
- Relatórios consolidados no diretório `/output/`

## 📚 Fonte dos Dados

A base utilizada provém de uma avaliação conduzida pela Agência Nacional de Águas e Saneamento Básico (ANA), disponível em:

🔗 [Metadados ANA – Avaliação de Impactos das Mudanças Climáticas no Balanço Hídrico](https://metadados.snirh.gov.br/geonetwork/srv/por/catalog.search#/metadata/5c4ad4e0-1b7c-45b4-9cb3-1893e44c20d6)

Essa avaliação indica aumento da necessidade de irrigação em quase todas as áreas irrigáveis até 2040, e redução da disponibilidade hídrica especialmente nas regiões Norte e Nordeste, enquanto parte do Sul e Sudeste poderá ter aumento de vazão.

## 🧩 Considerações Finais

Este projeto fornece um framework reprodutível para avaliação da vulnerabilidade hídrica em resposta a diferentes trajetórias climáticas. Os resultados auxiliam na identificação de áreas críticas e na formulação de estratégias de adaptação setoriais, especialmente no contexto de agricultura irrigada e gestão de recursos hídricos.
