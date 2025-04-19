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

library(rnaturalearth)
library(sf)

#I) Data

data <- read_delim("Cesium 137 et Iode 131 data (IPSN).csv", delim = ";")
write_parquet(data, "cesium_iodine_data.parquet")

#II) Map Vizualisation

FR <- readRDS("gadm36_FRA_2_sf.rds")

