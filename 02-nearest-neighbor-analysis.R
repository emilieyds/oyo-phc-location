library(dplyr)

# Load cleaned PHC data
phc <- st_read("data/processed/oyo_phc_clean.gpkg")

# Project PHC data to metric CRS
phc_m <- st_transform(phc, 32631)

# Calculate nearest-neighbor distance
dist_matrix <- st_distance(phc_m)

# Remove self-distance 
diag(dist_matrix) <- NA

# Extract distance to nearest other PHC
nearest_dist_m <- apply(dist_matrix, 1, min, na.rm = TRUE)

phc_m <- phc_m %>%
  mutate(nearest_phc_m = as.numeric(nearest_dist_m),
         nearest_phc_km = nearest_phc_m / 1000)

# Categorize nearest-neighbor distance (0.5, 1, 2km)
phc_m <- phc_m %>%
  mutate(dist_cat = cut(nearest_phc_km,
                        breaks = c(0, 0.5, 1, 2, Inf),
                        labels = c("< 0.5 km", "0.5–1 km", "1–2 km", "> 2 km"),
                        include.lowest = TRUE,
                        right = FALSE))

# Save output file 
st_write(phc_m, "data/processed/oyo_phc_analysis.gpkg", delete_dsn = TRUE)
