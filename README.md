![alt text](https://github.com/aclu-national/louisiana_police_quick_facts/blob/5a3a7304842ee61510c4678ce136f67ec83f2ebb/image_facts.png)

## Summary
This comprehensive project contains 55 unique questions regarding police killings, misconduct, and or personnel from 330+ law enforcement agencies across Louisiana spanning 60+ years, for a total of 120,000+ quick facts. We created this project to make actionable insights easy to search, find, and share.


## Sources

The data for this tool is sourced from:
- [Louisiana Law Enforcement and Accountability Database](llead.co)
- [Mapping Police Violence](https://mappingpoliceviolence.org/)
- [FBI Crime Explorer Law Enforcement Personnel Data](https://cde.ucr.cjis.gov/)

## Replicating
### 1. Clone
Clone the repository to your local machine:
```bash
git clone https://github.com/aclu-national/LA_police_facts
```
### 2. Data 
Run `data_creation_master_script.R`. This should download `df.csv` inside the app creation folder.

### 3. App
Run `app.R`. This should create the tool. 


## Git Structure


```
LA_police_facts
├── README.md
├── app_creation
│   ├── LA_police_facts_app.Rproj
│   ├── app.R
│   ├── df.csv
│   └── rsconnect
│       └── shinyapps.io
│           └── laaclu
│               └── test2.dcf
├── data_creation
│   ├── data
│   │   ├── killing_data
│   │   │   ├── 2024-01-11
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2024-03-01
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2024-03-25
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2024-09-05
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2024-11-18
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2025-01-27
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2025-02-26
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2025-03-26
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2025-05-07
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   ├── 2025-07-03
│   │   │   │   └── Mapping Police Violence.csv
│   │   │   └── cheat_sheet_killing.csv
│   │   ├── misconduct_data
│   │   │   ├── data_agency-reference-list.csv
│   │   │   ├── data_event.csv
│   │   │   └── misconduct.csv
│   │   └── overview_data
│   │       ├── 2024-02-27
│   │       │   └── pe_1960_2022.csv
│   │       ├── 2025-01-27
│   │       │   └── lee_1960_2023.csv
│   │       ├── 35158-0001-Codebook.pdf
│   │       ├── 35158-0001-Data.rda
│   │       └── cheat_sheet_overview.csv
│   ├── data_creation_master_script.R
│   ├── quick_fact_data_creation.Rproj
│   └── scripts
│       ├── killing_df_creation.R
│       ├── misconduct_df_creation.R
│       └── personnel_df_creation.R
└── image_facts.png

```

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


## Disclaimer
All of the information accessible from this tool is generated using publicly accessible resources. As a result, we cannot verify the accuracy of any of the numbers generated.

## Questions
If you have any questions or concerns about the content of this tool, you can contact [eappelson@laaclu.org](mailto:eappelson@laaclu.org).

