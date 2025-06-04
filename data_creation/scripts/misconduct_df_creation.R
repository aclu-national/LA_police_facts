# Code to turn LLEAD misconduct data into a question, agency, year dataframe for the quick facts app.

# -----------------------------------------------------------------------
# Author: Elijah Appelson
# Update Date: January 27th, 2025
# -----------------------------------------------------------------------

# Loading Libraries
library(tidyverse)
library(janitor)

# Creating a function to turn lists into text sentences
make_list <- function(values) {
  if (length(values) == 1) {
    return(values)
  } else if (length(values) == 2) {
    return(paste(values, collapse = " and "))
  } else {
    return(paste(head(values, -1), collapse = ", ") %>% paste(values[length(values)], sep = ", and "))
  }
}

# Loading data
misconduct <- read_csv("data/misconduct_data/misconduct.csv")
event <- read_csv("data/misconduct_data/data_event.csv") 

# Extracting the date from the misconduct event data
misconduct_date <- event %>%
  filter(kind %in% c("complaint_receive", "officer_post_decertification")) %>%
  group_by(allegation_uid) %>%
  summarize(
    year = min(year),
    month = min(month),
    day = min(day)
  ) %>%
  ungroup()

# Creating a total year misconduct dataframe
total_years_misconduct <- misconduct %>%
  select(-year) %>%
  left_join(misconduct_date, by = "allegation_uid") %>%
  mutate(year = ifelse(!is.na(year), as.numeric(year), NA)) %>%
  # filter(!is.na(year)) %>%
  arrange(agency_name, year) %>%
  mutate(group = cumsum(c(0, !(diff(year) %in% c(0,1))))) %>%
  distinct(agency_name,group, year) %>%
  group_by(agency_name,group) %>%
  summarize(year = paste(min(year), max(year), sep = "-")) %>%
  mutate(year_1 = str_sub(year, 1,4),
         year_2 = str_sub(year,6,10),
         year = ifelse(year_1 == year_2, year_1,year)) %>%
  select(-c(year_1,year_2)) %>%
  mutate(year = str_replace_all(year,"NA-NA", "Unknown Year")) %>%
  group_by(agency_name) %>%
  summarize(year = make_list(unique(year))) %>%
  select(correct_agency_name = agency_name, year)

# Defining a year by year misconduct dataframe with special columns
year_by_year_misconduct <- misconduct %>%
  select(-year) %>%
  left_join(misconduct_date, by = "allegation_uid") %>%
  mutate(year = ifelse(is.na(year), "Unknown Year", year)) %>%
  group_by(agency_name, year) %>%
  summarize(
    
    # Counting total allegations, dispositions, repercussions, and officers
    n_allegation = n(),
    n_disposition = sum(ifelse(!is.na(disposition),1,0)),
    n_action = sum(ifelse(!is.na(action),1,0)),
    n_officers = n_distinct(uid),
    
    # Giving common allegations, dispositions, repercussions, and officers
    common_allegations = tabyl(allegation) %>%
      arrange(-n) %>%
      head(5) %>%
      filter(!is.na(allegation) & allegation != "") %>%
      mutate(allegation_plus_n = paste0(str_to_title(allegation), " (",n,")")) %>%
      pull(allegation_plus_n) %>%
      make_list(),
    common_allegations = ifelse(common_allegations %in% c("",NA,", and "), "No Allegations Reported", common_allegations),
    common_dispositions = tabyl(disposition) %>%
      arrange(-n) %>%
      head(5) %>%
      filter(!is.na(disposition) & disposition != "") %>%
      mutate(disposition_plus_n = paste0(str_to_title(disposition), " (",n,")")) %>%
      pull(disposition_plus_n) %>%
      make_list(),
    common_dispositions = ifelse(common_dispositions %in% c("",NA,", and "), "No Dispositions Reported", common_dispositions),
    common_action = tabyl(action) %>%
      arrange(-n) %>%
      head(5) %>%
      filter(!is.na(action) & action != "") %>%
      mutate(action_plus_n = paste0(str_to_title(action), " (",n,")")) %>%
      pull(action_plus_n) %>%
      make_list(),
    common_action = ifelse(common_action %in% c("",NA,", and "), "No Repercussions Reported", common_action),
    common_officer = tabyl(full_name) %>%
      arrange(-n) %>%
      head(5) %>%
      filter(!is.na(full_name) & full_name != "") %>%
      mutate(action_plus_n = paste0(str_to_title(full_name), " (",n,")")) %>%
      pull(action_plus_n) %>%
      make_list(),
    common_officer = ifelse(common_officer %in% c("",NA,", and "), "No Officers Reported", common_officer),
    
    # Counting the number of specific allegation, disposition, and repercussion types
    n_uof = sum(`Use of Force`),
    n_weapon = sum(`Weapon Violation`),
    n_discourtesy = sum(`Discourtesy`),
    n_harassment = sum(`Harassment`),
    n_sexual_harassmet = sum(`Sexual Harassment`),
    n_sexual_assault = sum(`Sexual Assault`),
    n_domestic_violence = sum(`Domestic Violence`),
    n_sustained = sum(`Sustained`),
    n_terminated = sum(`Terminated`),
    n_decertified = sum(`Decertified`)
  ) %>%
  mutate(correct_agency_name = agency_name,
         years_report = year)

# Defining an all year misconduct dataframe with special columns
all_year_misconduct <- misconduct %>%
  select(-year) %>%
  group_by(agency_name) %>%
  summarize(n_allegation = n(),
            n_disposition = sum(ifelse(!is.na(disposition),1,0)),
            n_action = sum(ifelse(!is.na(action),1,0)),
            n_officers = length(unique(uid)),
            common_allegations = tabyl(allegation) %>%
              arrange(-n) %>%
              head(5) %>%
              filter(!is.na(allegation) & allegation != "") %>%
              mutate(allegation_plus_n = paste0(str_to_title(allegation), " (",n,")")) %>%
              pull(allegation_plus_n) %>%
              make_list(),
            common_allegations = ifelse(common_allegations %in% c("",NA,", and "), "No Allegations Reported", common_allegations),
            common_dispositions = tabyl(disposition) %>%
              arrange(-n) %>%
              head(5) %>%
              filter(!is.na(disposition) & disposition != "") %>%
              mutate(disposition_plus_n = paste0(str_to_title(disposition), " (",n,")")) %>%
              pull(disposition_plus_n) %>%
              make_list(),
            common_dispositions = ifelse(common_dispositions %in% c("",NA,", and "), "No Dispositions Reported", common_dispositions),
            common_action = tabyl(action) %>%
              arrange(-n) %>%
              head(5) %>%
              filter(!is.na(action) & action != "") %>%
              mutate(action_plus_n = paste0(str_to_title(action), " (",n,")")) %>%
              pull(action_plus_n) %>%
              make_list(),
            common_action = ifelse(common_action %in% c("",NA,", and "), "No Repercussions Reported", common_action),
            common_officer = tabyl(full_name) %>%
              arrange(-n) %>%
              head(5) %>%
              filter(!is.na(full_name) & full_name != "") %>%
              mutate(action_plus_n = paste0(str_to_title(full_name), " (",n,")")) %>%
              pull(action_plus_n) %>%
              make_list(),
            common_officer = ifelse(common_officer %in% c("",NA,", and "), "No Officers Reported", common_officer),
            n_uof = sum(`Use of Force`),
            n_weapon = sum(`Weapon Violation`),
            n_discourtesy = sum(`Discourtesy`),
            n_harassment = sum(`Harassment`),
            n_sexual_harassmet = sum(`Sexual Harassment`),
            n_sexual_assault = sum(`Sexual Assault`),
            n_domestic_violence = sum(`Domestic Violence`),
            n_sustained = sum(`Sustained`),
            n_terminated = sum(`Terminated`),
            n_decertified = sum(`Decertified`)
  ) %>%
  mutate(correct_agency_name = agency_name,
         years_report = "Total Years Reporting Misconduct") %>%
  left_join(total_years_misconduct, by = "correct_agency_name")

# Joining the year by year misconduct with the all year misconduct
df <- rbind(year_by_year_misconduct, all_year_misconduct) %>%
  ungroup() %>%
  distinct(correct_agency_name, year, .keep_all = TRUE) %>%
  mutate_all(as.character) %>%
  pivot_longer(cols = "n_allegation":"n_decertified") %>%
  select(correct_agency_name, year, years_report, rowname = name, value) %>%
  group_by(correct_agency_name) %>%
  
  # Creating sentences to go with the numbers
  mutate(
    text = case_when(
      rowname == "n_allegation" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " misconduct allegation in "," misconduct allegations in "), year,"."),
      rowname == "n_disposition" ~ paste0(correct_agency_name, " reported ", value, ifelse(value == 1, " disposition for misconduct allegations in " ," dispositions for misconduct allegations in "), year,"."),
      rowname == "n_action" ~ paste0(correct_agency_name, " reported ", value, ifelse(value == 1, " repercussion for misconduct allegations in " ," repercussions for misconduct allegations in "), year,"."),
      rowname == "n_officers" ~ paste0("At least ", value, ifelse(value == 1, " individual officer at "," individual officers at "), correct_agency_name, " received misconduct allegations in ", year,"."),
      rowname == "common_allegations" ~ paste0(ifelse(value == 1, "The most common reported allegation against ","The most common reported allegations against "), correct_agency_name, " in ", year, ifelse(value == 1, " is ", " include "), value,"."),
      rowname == "common_dispositions" ~  paste0(ifelse(value == 1, "The most common reported disposition against ","The most common reported disposition against "), correct_agency_name, " in ", year, ifelse(value == 1, " is ", " include "), value,"."),
      rowname == "common_action" ~ paste0(ifelse(value == 1, "The most common reported repercussion against ","The most common reported repercussion against "), correct_agency_name, " in ", year, ifelse(value == 1, " is ", " include "), value,"."),
      rowname == "common_officer" ~ paste0(ifelse(value == 1, "The officer with the most reported misconduct allegations at ","The officers with the most reported misconduct allegations at "), correct_agency_name, " in ", year, ifelse(value == 1, " is ", " include "), value,"."),
      rowname == "n_uof" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to use of force in "," allegations related to use of force in "), year,"."),
      rowname == "n_weapon" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to a weapon violation in "," allegations related to a weapon violation in "), year,"."),
      rowname == "n_discourtesy" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to discourtesy in "," allegations related to discourtesy in "), year,"."),
      rowname == "n_harassment" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to harassment in "," allegations related to harassment in "), year,"."),
      rowname == "n_sexual_harassmet" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to sexual harassment in "," allegations related to sexual harassment in "), year,"."),
      rowname == "n_sexual_assault" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to sexual assault in "," allegations related to sexual assault in "), year,"."),
      rowname == "n_domestic_violence" ~ paste0(correct_agency_name, " received at least ", value, ifelse(value == 1, " allegation related to domestic violence in "," allegations related to domestic violence in "), year,"."),
      rowname == "n_sustained" ~ paste0(value, ifelse(value == 1, " allegation against "," allegations against "), correct_agency_name, ifelse(value == 1, " was sustained"," were sustained"), " in ", year,"."),
      rowname == "n_terminated" ~ paste0(value, ifelse(value == 1, " officer with a misconduct allegation at "," officers with misconduct allegations at "), correct_agency_name, ifelse(value == 1, " was terminated"," were terminated"), " in ", year,"."),
      rowname == "n_decertified" ~ paste0(value, ifelse(value == 1, " officer with a misconduct allegation at "," officers with misconduct allegations at "), correct_agency_name, ifelse(value == 1, " was decertified"," were decertified"), " in ", year,".")
    )
  )

# Creating the final misconduct dataframe
police_misconduct_df <- df %>%
  select(correct_agency_name, year, years_report, variable = rowname, value, text) %>%
  group_by(year, variable) %>%
  mutate(num_value = as.numeric(value)) %>%
  mutate(value_percentile = round(ifelse(is.na(num_value), NA, ecdf(num_value)(num_value) * 100),2)) %>%
  
  # Creating questions appropriate to the text
  mutate(
    question = case_when(
      variable == "n_allegation" ~ "How many allegations?",
      variable == "n_disposition" ~ "How many dispositions?",
      variable == "n_action" ~ "How many repercussions?",
      variable == "n_officers" ~ "How many officers received misconduct allegations?",
      variable == "common_allegations" ~ "What were common misconduct allegations?",
      variable == "common_dispositions" ~  "What were common dispositions?",
      variable == "common_action" ~ "What were common repercussions?",
      variable == "common_officer" ~ "Which officer(s) had the most reported allegations?",
      variable == "n_uof" ~ "How many use of force allegations were reported?",
      variable == "n_weapon" ~ "How many weapon violation allegations were reported?",
      variable == "n_discourtesy" ~ "How many discourtesy allegations were reported?",
      variable == "n_harassment" ~ "How many harassment allegations were reported?",
      variable == "n_sexual_harassmet" ~ "How many sexual harassment allegations were reported?",
      variable == "n_sexual_assault" ~ "How many sexual assault allegations were reported?",
      variable == "n_domestic_violence" ~ "How many domestic violence allegations were reported?",
      variable == "n_sustained" ~ "How many allegations were sustained?",
      variable == "n_terminated" ~ "How many officers were terminated for misconduct?",
      variable == "n_decertified" ~ "How many harassment decertified for misconduct?",
    ),
    question_p1 = case_when(
      variable == "n_allegation" ~ "How many misconduct allegations were reported against",
      variable == "n_disposition" ~ "How many dispositions for allegations were reported against",
      variable == "n_action" ~ "How many repercussions for allegations were reported against",
      variable == "n_officers" ~ "How many officers received misconduct allegations from",
      variable == "common_allegations" ~ "What were the most common misconduct allegations against",
      variable == "common_dispositions" ~  "What were the most common dispositions for misconduct allegations against",
      variable == "common_action" ~ "What were the most common repercussions for misconduct allegations against",
      variable == "common_officer" ~ "Which officer(s) had the most reported allegations while employed by",
      variable == "n_uof" ~ "How many use of force allegations were reported against",
      variable == "n_weapon" ~ "How many weapon violation allegations were reported against",
      variable == "n_discourtesy" ~ "How many discourtesy allegations were reported against",
      variable == "n_harassment" ~ "How many harassment allegations were reported against",
      variable == "n_sexual_harassmet" ~ "How many sexual harassment allegations were reported against",
      variable == "n_sexual_assault" ~ "How many sexual assault allegations were reported against",
      variable == "n_domestic_violence" ~ "How many domestic violence allegations were reported against",
      variable == "n_sustained" ~ "How many misconduct allegations were sustained by",
      variable == "n_terminated" ~ "How many misconduct allegations led to terminations by",
      variable == "n_decertified" ~ "How many misconduct allegations led to decertified by",
    ),
    question_p2 = correct_agency_name,
    question_p3 = years_report,
    question_complex = paste0(question_p1," ",question_p2," in ",question_p3, "?"),
    category = "Misconduct",
    source = "Louisiana Law Enforcement Accountability Database",
    link = "https://llead.co/"
  )
