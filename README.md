# Global-financial-contagion-model
This repository contains code and data for constructing a multilayer network model using CTG and BGGM to explore global contagion dynamics.

## Repository Structure

- **Data**: Contains processed data files.
  - `output_lgr`: Cleaned data after preprocessing.
  - `all_ctg_index_value`: Calculated CTG index values.
  - `BGGM`: Data for BGGM network.

- **DataAnalysis**: Contains analysis results and visualization files.
  - `DataDescription`: Statistical descriptions and ADF test results.
  - `US Role`: Includes Gephi plots and multilayer plots for the US role analysis.

- **Scripts**:
  - `DataDescription.ipynb`: Notebook for statistical description and ADF test.
  - `AnalysisAtCountryLevel.ipynb`: Notebook for country-level analysis.
  - `BGGM.R`: R script for calculating inter-layer connections using the BGGM network.

## Workflow

1. **Data Cleaning and Description**:
   - Raw data is cleaned to produce `Data/output_lgr`.
   - Statistical description and ADF test are performed using `DataDescription.ipynb`.
   - Results are saved in `DataAnalysis/DataDescription`.

2. **CTG Index Calculation**:
   - CTG index values are calculated and saved in `Data/all_ctg_index_value`.

3. **Country-Level Analysis**:
   - Composite index and summed index per market are calculated.
   - General analysis includes composite CTG daily plots, box plots, and summed CTG heatmaps. This is done in the first part of `AnalysisAtCountryLevel.ipynb`.
   - Cross-market risk transmission networks at the country level are analyzed and visualized in the second part of `AnalysisAtCountryLevel.ipynb`.
   - Results are saved in `CTG_Network`, with subfolders for non-unified and unified node sizes.

4. **BGGM Network Calculation**:
   - Inter-layer connections are calculated using the BGGM network with `BGGM.R`.
   - The resulting data is saved in `Data/BGGM`.

5. **Global-Level Analysis**:
   - Network and heatmap visualizations, DD analysis, and measurement analysis are conducted.

6. **Multi-Layer Analysis**:
   - Gephi is used to create network visualizations, saved in `DataAnalysis/US Role/Gephi Plot`.
   - Multi-layer plots for presentations are created and saved in `DataAnalysis/US Role/Multilayer Plot`.

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/WanYuchi/Global-financial-Contagion-Model.git
   cd Global-financial-Contagion-Model

2. **Run the notebooks and scripts**：
   - Use Jupyter Notebook to open and run 'DataDescription.ipynb' and 'AnalysisAtCountryLevel.ipynb'.
   - Use R to run 'BGGM.R'.
