# IPSN Data on Exposure of Cesium 137 and Iode 131 after Chernobyl accident (1997)

#0) Packages

library(arrow)
library(haven)        # For reading .dta files
library(dplyr)        # For data manipulation (mutate, case_when, group_by, etc.)
library(tidyverse)    # Includes ggplot2, dplyr, tidyr, etc.
library(janitor)      # For cleaning data, e.g., renaming variables
library(summarytools) # For frequency tables (freq)
library(reshape2)     # For reshaping data (melt, cast)
library(stargazer)    # For regression tables (if needed)
library(plm)          # For panel data models (if needed)
library(sf)
library(ggplot2)

#I) Data

data <- read_delim("Cesium 137 et Iode 131 data (IPSN).csv", delim = ";")

#II) Map Vizualisation

FR <- read_sf("gadm41_FRA_2.json")

ggplot(FR) +
  geom_sf(fill = "#69b3a2", color = "white") +
  theme_void()

data$code_dep <- gsub("·", "", data$code_dep)  # Remove separators
data$code_dep <- ifelse(nchar(data$code_dep) == 1, 
                               paste0("0", data$code_dep), 
                               data$code_dep)

data$code_dep[data$code_dep %in% c("·2A·", ".2A.", " 2A ", "2 A")] <- "2A"
data$code_dep[data$code_dep %in% c("·2B·", ".2B.", " 2B ", "2 B")] <- "2B"

write_parquet(data, "cesium_iodine_data.parquet")

map <- left_join(FR, data, by = c("CC_2" = "code_dep"))

ggplot(map) +
  geom_sf(aes(fill = as.factor(`Cesium 137`)), color = "white") +
  scale_fill_brewer(palette = "Spectral", direction = -1, name = "Exposure Cesium 137") +
  theme_minimal()

ggplot(map) +
  geom_sf(aes(fill = as.factor(`Iode 131`)), color = "white") +
  scale_fill_brewer(palette = "Spectral", direction = -1, name = "Exposure Iodine 131") +
  theme_minimal()