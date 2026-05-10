## Execersise 2 Primary health centre (PHC) clustering in Oyo State, Nigeria 
This repository contains a spatial analysis of primary health centre (PHC) clustering in Oyo State, Nigeria using publicly available geospatial datasets.

The analysis estimates:
- the number of PHCs in Oyo State
- nearest-neighbour distance between PHCs
- the number of clustered and isolated PHCs using 0.5 km, 1 km, and 2 km thresholds

**Rendered report:** https://emilieyds.github.io/oyo-phc-location/ 

---

## Repository structure

```text
data/
├── raw/              # downloaded raw datasets
├── processed/        # cleaned and processed spatial layers
├── metadata/         # metadata

outputs/              # exported maps, figures, and summary tables

report/
├── oyo_phc_clustering_report.Rmd
├── oyo_phc_clustering_report.html

scripts/
├── 01_download_clean_data.R
├── 02_nearest_neighbor_analysis.R
├── 03_visualization_outputs.R
```

Please follow the following instructions to run the code.
1. Install the following R packages used for the data analysis and replication of figures and tables:
```
install.packages(c("sf", "tidyverse", "knitr", "see"))
```
2. Download and clean data using `script/01-download-clean-data.R`.This script downloads and prepares GRID3 Nigeria Health Facilities v2.0 and Nigeria administrative boundary data. Raw datasets are stored in `data/raw/`. Metadata and source documentation are stored in `data/metadata/`.
3. Run `scripts/02_nearest_neighbor_analysis.R` to calculate nearest-neighbour distance between PHCs and classify facilities using the 0.5 km, 1 km, and 2 km distance thresholds. This script uses the cleaned PHC dataset from `data/processed`, projects the facility locations to UTM Zone 31N for distance calculation, and saves the analysis-ready spatial layer back to `data/processed`.
4. The script `03-visualization-outputs.R` is used to reproduce the figures, maps and tables in the report. Outputs are saved in `outputs`.
5. The report outlining the overall analytical flow can be found in the `report` folder in both `.Rmd` and `.html` formats. To view the rendered version online, visit: https://emilieyds.github.io/oyo-phc-location/
