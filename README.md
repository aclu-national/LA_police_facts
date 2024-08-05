 # Police Quick Facts

![alt text](https://github.com/aclu-national/police_quick_facts/blob/bd90a8217161fabc1920e9e4fa4a4d7f7aaec6aa/app_preview.png)

# Git Structure

- **`README.md`**: This file.
- **`app_creation/`**: Contains the application files for creation.
  - `app.R`: The main R script for the application.
  - `app_creation.Rproj`: RStudio project file.
  - `df.csv`: CSV file used in the app creation.
- **`app_preview.png`**: Image preview of the app.
- **`data_creation/`**: Contains scripts and data related to the creation process.
  - **`original_data/`**: Raw data files.
    - **`killing_data/`**: Contains data related to killings.
      - `cheat_sheet_killing.csv`: Cheat sheet for killing data.
      - `killing.csv`: Main killing data file.
    - **`misconduct_data/`**: Contains data related to misconduct.
      - `data_event.csv`: Event data for misconduct.
      - `misconduct.csv`: Main misconduct data file.
    - **`overview_data/`**: Overview data files.
      - `cheat_sheet_overview.csv`: Cheat sheet for overview data.
      - `overview.csv`: Main overview data file.
  - **`scripts/`**: R scripts for data processing.
    - `app_script.R`: Script for the app.
    - `police_killing_df.R`: Script for processing police killing data.
    - `police_misconduct_df.R`: Script for processing police misconduct data.
    - `police_personnel_df.R`: Script for processing police personnel data.

## Purpose
This project provides essential information about policing in Louisiana, aiming to offer valuable insights and data to users.

## Sources
The data for this tool is sourced from:
- [Louisiana Law Enforcement and Accountability Database](llead.co) (January 2024)
- [Mapping Police Violence](https://mappingpoliceviolence.org/) (March 2024)
- [FBI Crime Explorer Law Enforcement Personnel Data](https://cde.ucr.cjis.gov/) (January 2024)

## Disclaimer
The information presented by this tool is derived from publicly available resources. We cannot guarantee the accuracy or completeness of the data provided.

## Questions
For any inquiries or concerns regarding this tool, please contact us at [eappelson@laaclu.org](mailto:eappelson@laaclu.org).

## Product
Explore the tool [here](https://laaclu.shinyapps.io/test2/).

