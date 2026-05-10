library(ggplot2)

# Load processed data
phc_m <- st_read("data/processed/oyo_phc_analysis.gpkg")
admin1_oyo <- st_read("data/processed/admin1_oyo.gpkg")
admin2_oyo <- st_read("data/processed/admin2_oyo.gpkg")

# Summary statisitcs table
distance_summary <- phc_m %>%
  st_drop_geometry() %>%
  summarise(`Total PHCs` = n(),
    `Mean nearest PHC distance (km)` = mean(nearest_phc_km, na.rm = TRUE),
    `Median nearest PHC distance (km)` = median(nearest_phc_km, na.rm = TRUE),
    `25th percentile distance (km)` = quantile(nearest_phc_km, 0.25, na.rm = TRUE),
    `75th percentile distance (km)` = quantile(nearest_phc_km, 0.75, na.rm = TRUE),
    `Maximum distance (km)` = max(nearest_phc_km, na.rm = TRUE)) %>%
  mutate(across(where(is.numeric), round, 2))

#print(distance_summary)

cluster_summary <- tibble(
  Threshold = c("0.5 km", "1 km", "2 km"),
  `Clustered PHCs` = c(sum(phc_m$nearest_phc_km <= 0.5, na.rm = TRUE),
                       sum(phc_m$nearest_phc_km <= 1, na.rm = TRUE),
                       sum(phc_m$nearest_phc_km <= 2, na.rm = TRUE)),
  `Isolated PHCs` = c(sum(phc_m$nearest_phc_km > 0.5, na.rm = TRUE),
                      sum(phc_m$nearest_phc_km > 1, na.rm = TRUE),
                      sum(phc_m$nearest_phc_km > 2, na.rm = TRUE))) %>%
  mutate(`Share clustered (%)` = round(`Clustered PHCs` / (`Clustered PHCs` + `Isolated PHCs`) * 100, 1))

#print(cluster_summary)

# Save CSV
write.csv(distance_summary, "outputs/distance_summary.csv", row.names = FALSE)
write.csv(cluster_summary, "outputs/dcluster_summary.csv", row.names = FALSE)

# Create a buffer map
buffer_0_5km <- st_buffer(phc_m, dist = 500)
buffer_1km <- st_buffer(phc_m, dist = 1000)
buffer_2km <- st_buffer(phc_m, dist = 2000)

buffer <- ggplot() +
  geom_sf(data = admin1_oyo) + 
  geom_sf(data = buffer_2km, aes(fill = "2 km"), color = NA, alpha = 0.5) +
  geom_sf(data = buffer_1km, aes(fill = "1 km"), color = NA, alpha = 0.6) +
  geom_sf(data = buffer_0_5km, aes(fill = "0.5 km"), color = NA, alpha = 0.8) +
  scale_fill_manual(name = "Buffer distance",
                    values = c("0.5 km" = "yellow", "1 km" = "green", "2 km" = "blue")) +
  labs(title = "Buffer of primary health centre in Oyo State, Nigeria",
       subtitle = "0.5 km, 1 km, and 2 km -radius buffers") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 16),
        plot.subtitle = element_text(size = 12),
        legend.position = "right")

#print(buffer)

# Save PNG
ggsave(filename = "outputs/phc_buffer_map.png", 
       plot = buffer, width = 8, height = 6, dpi = 300)

file.rename("03-visualization-outputs.R", 
            "scripts/03-visualization-outputs.R")
