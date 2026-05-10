## Execersise 2 Primary health centre (PHC) clustering in Oyo State, Nigeria 
This repository contains a spatial analysis of primary health centre (PHC) clustering in Oyo State, Nigeria using publicly available geospatial datasets.

The analysis estimates:
- the number of PHCs in Oyo State
- nearest-neighbour distance between PHCs
- the number of clustered and isolated PHCs using 0.5 km, 1 km, and 2 km thresholds

Rendered report: https://emilieyds.github.io/oyo-phc-location/ 

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
install.packages(c("ggplot2", "sf", "dplyr", "tidyverse", "knitr", "see"))
```

2. Import healthcare facility data and Nigeria's administrative data using `script/01-download-clean-data.R`. Nigeria healthcare facility location data are available in `data/raw/nga_health_facilities_v2_0.gpkg`, together with all the Nigeria administrative borders data used for our analysis, merged into one file. Cleaned data (e.g., filter relevant boarders, facility) is in `data/clean`. You can also find metadata for these two main dayasets in `data/metadata`. 

3. Use `script/02-nearst-neightbour-analysis.R` to run analysis on calculting nearst-neightbour distance and to categorize facilities with thresholds. 
5.
6. This corresponds to running the CAR model for both outcomes. We include also scripts for running alternative models, that were considered in the first version of the paper (for different prior distributions on the random effects, using the entire dataset or leave-one-out (LOO) by year). Further details are provided in `scripts/readme.md`. Output files from the analyses will be saved in `results/`. 

7. The scripts `create_figures.R`, `create_maps.R`, `create_tables.R` and `neigh_cluster_analysis.R` are used to reproduce the figures, maps and tables in the paper.
