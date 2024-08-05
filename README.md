 # Police Quick Facts

![alt text](https://github.com/aclu-national/louisiana_police_quick_facts/blob/80d4c708379a125cce253c7c782504e85c067821/app_preview.png)

# Git Structure

- **`README.md`**: This file.
- **`app_creation/`**: Contains the application files for creation.
  - `app.R`: The main R script for the application.
  - `quick_fact_shiny_app.Rproj`: RStudio project file for the Shiny app.
  - **`rsconnect/`**: Contains deployment configuration for Shiny apps.
    - **`shinyapps.io/`**: Configuration for deployment.
      - **`laaclu/`**: Specific app deployment folder.
        - `test2.dcf`: Deployment configuration file.
- **`data_creation/`**: Contains data and scripts for data processing.
  - **`data/`**: Contains data files organized by type.
    - **`killing_data/`**: Data related to killings.
      - `cheat_sheet_killing.csv`: Cheat sheet for killing data.
      - `killing.csv`: Main killing data file.
    - **`misconduct_data/`**: Data related to misconduct.
      - `data_event.csv`: Event data for misconduct.
      - `misconduct.csv`: Main misconduct data file.
    - **`overview_data/`**: Overview data files.
      - `cheat_sheet_overview.csv`: Cheat sheet for overview data.
      - `overview.csv`: Main overview data file.
  - `data_creation_master_script.R`: Master script for data creation.
  - `df.csv`: Additional CSV file used in data creation.
  - `quick_fact_data_creation.Rproj`: RStudio project file for data creation.
  - **`scripts/`**: R scripts for data processing.
    - `killing_df_creation.R`: Script for creating killing data dataframe.
    - `misconduct_df_creation.R`: Script for creating misconduct data dataframe.
    - `personnel_df_creation.R`: Script for creating personnel data dataframe.

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

