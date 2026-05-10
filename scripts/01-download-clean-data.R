# Install necessary packages
install.packages(c("sf", "tidyverse", "see"))

library(sf)
library(tidyverse)
library(see)

# Create project folders 
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("data/metadata", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs", recursive = TRUE, showWarnings = FALSE)
dir.create("scripts", recursive = TRUE, showWarnings = FALSE)
dir.create("report", recursive = TRUE, showWarnings = FALSE)

# Download and load GRID3 Nigeria health facility data
phc_url <- "https://data.humdata.org/dataset/a3b971e7-2f6e-4d1c-b4b2-87698545e5ca/resource/d471169a-7785-4c18-ad9e-0fef07a40dc5/download/nga_health_facilities_v2_0.gpkg"
phc_path <- "data/raw/nga_health_facilities_v2_0.gpkg"

download.file(url = phc_url, destfile = phc_path, mode = "wb")

facility <- st_read(phc_path)

# Filter Oyo State Primary Health Centers
phc <- facility %>%
  filter(state == "Oyo", facility_level_option == "Primary Health Center")

# Save Oyo PHC data to 'data/processed' folder
st_write(phc, "data/processed/oyo_phc_clean.gpkg", delete_dsn = TRUE)

# Download and save metadata 
metadata_phc_url <- "https://www.arcgis.com/sharing/rest/content/items/a0ed9627a8b240ff8b315a84575754a4/info/metadata/metadata.xml?format=default&output=html"
metadata_phc <- "data/metadata/nga_health_facilities_v2_0.html"
download.file(url = metadata_phc_url, destfile = metadata_phc)

# Download Nigeria administrative boundaries
nga_url <- "https://data.humdata.org/dataset/81ac1d38-f603-4a98-804d-325c658599a3/resource/7e30ec96-7f29-4ee8-9f4c-77633b353cbb/download/nga_admin_boundaries.geojson.zip"
admin_zip <- "data/raw/nga_admin_boundaries.geojson.zip"

download.file(url = nga_url, destfile = admin_zip, mode = "wb")

# Extract only admin0, admin1, admin2
unzip(zipfile = admin_zip, files = c("nga_admin0.geojson",
                                     "nga_admin1.geojson",
                                     "nga_admin2.geojson"), exdir = "data/raw")

# Download datasets
admin0 <- st_read("data/raw/nga_admin0.geojson") # Nigeria boundary
admin1 <- st_read("data/raw/nga_admin1.geojson") # State boundaries
admin2 <- st_read("data/raw/nga_admin2.geojson") # LGA boundaries

# Filter Oyo State administrative boundaries
admin1_oyo <- admin1 %>%
  filter(adm1_name == "Oyo")
admin2_oyo <- admin2 %>%
  filter(adm1_name == "Oyo")

# Save Oyo administrative boundaries to 'data/processed' folder
st_write(admin1_oyo, "data/processed/admin1_oyo.gpkg", delete_dsn = TRUE)
st_write(admin2_oyo, "data/processed/admin2_oyo.gpkg", delete_dsn = TRUE)

# Download and save metadata 
metadata_nga_url <- "https://data.humdata.org/dataset/cod-ab-nga"
metadata_nga <- "data/metadata/nga_admin_boudaries.csv"
download.file(url = metadata_nga_url, destfile = metadata_nga)