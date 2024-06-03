# Global-financial-contagion-model
This repository contains code and data for constructing a multilayer network model using CTG and BGGM to explore global contagion dynamics.

## Repository Structure

- **Data**: Contains processed data files.
  - `output_lgr`: Log return data (16 countries, 4 markets) after preprocessing.
  - `all_ctg_index_value`: Calculated CTG index values.
  - `BGGM`: Calculated partial correlation for BGGM network.

- **DataAnalysis**: Contains analysis results and visualization files.
  - `DataDescription`: Statistical descriptions and ADF test results of Log return data in `Data/output_lgr` .
  - `CTG Analysis`: Results from the country-level CTG analysis, including composite CTG daily plots, box plots, summed CTG heatmaps, and cross-market risk transmission networks.
  - `BGGM Analysis`: Results from the global-level BGGM analysis, including network and heatmap visualizations, Developed-Emerging country analysis, and measurement analysis.
  - `US Role`: Includes Gephi plots and multilayer plots for the US role analysis.

- **Scripts**:
  - `DataDescription.ipynb`: Notebook for statistical description and ADF test.
  - `AnalysisAtCountryLevel.ipynb`: Notebook for country-level analysis.
  - `AnalysisAtGlobalLevel.ipynb`:Notebook for country-level analysis.
  - `AnalysisUSRole.ipynb`: Notebook for global-level analysis.
  - `BGGM.R`: R script for calculating inter-layer connections using the BGGM.
  - `CTG.R`: R script for calculating CTG index.

## Workflow

1. **Data Cleaning and Description**:
   - Raw data is cleaned to produce `Data/output_lgr`.
   - Statistical description and ADF test are performed using `DataDescription.ipynb`, and results are saved in `DataAnalysis/DataDescription`.

2. **CTG Index Calculation**:
   - CTG index values are calculated by `CTG.R` and the results saved in `Data/all_ctg_index_value`.

3. **Country-Level Analysis**:
   - Composite index and summed index per market are calculated. General analysis includes composite CTG daily plots, box plots, and summed CTG heatmaps. This is done in the first part of `AnalysisAtCountryLevel.ipynb`.
   - Cross-market risk transmission networks at the country level are analyzed and visualized in the second part of `AnalysisAtCountryLevel.ipynb`.
   - Results are saved in `DataAnalysis/CTG Analysis`, with subfolders for non-unified and unified node sizes.

4. **BGGM Network Calculation**:
   - Inter-layer connections are calculated using the BGGM with `BGGM.R`.
   - The resulting data is saved in `Data/BGGM`.

5. **Global-Level Analysis**:
   - Network and heatmap visualizations, Developed-Emerging country analysis, and measurement analysis are conducted.
   - Results are saved in `DataAnalysis/BGGM Analysis`

6. **Multi-Layer Analysis**:
   - We use Gephi to plot the contagion network centering on the U.S. By utilizing the known CTG index and BGGM data, we calculate the nodes and edges for the network recognizable by Gephi in `AnalysisUSRole.ipynb`, with the results saved in `DataAnalysis/US Role/Gephi Data`.
   - Gephi is used to create network visualizations, saved in `DataAnalysis/US Role/Gephi Plot`.
   - Multi-layer plots for presentations are created and saved in `DataAnalysis/US Role/Multilayer Plot`.

