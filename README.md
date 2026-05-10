## Execersise 2 Primary health centre (PHC) clustering in Oyo State, Nigeria 
This repository contains a spatial analysis of primary health centre (PHC) clustering in Oyo State, Nigeria using publicly available geospatial datasets.

The analysis estimates:
- the number of PHCs in Oyo State
- nearest-neighbour distance between PHCs
- the number of clustered and isolated PHCs using 0.5 km, 1 km, and 2 km thresholds

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

