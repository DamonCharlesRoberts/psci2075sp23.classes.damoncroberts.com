# Title: Group assignment 1 example

# Notes:
    #* Description: 
        #** R file providing an example of group assignment 1 code
    #* Updated: 2023-02-16
        #** by: dcr

# Load packages
    #* Install these if you haven't yet
# install.packages(c("dplyr", "magrittr", "modelsummary", "ggplot2"))
library(dplyr) # for dataset management
library(magrittr) # for pipe operator
library(modelsummary) # for tables
library(ggplot2) # for graphs

# Make sure working directory is set to psci_2075 folder
getwd() # check current working directory
setwd("~/Desktop/psci_2075") # change it to psci_2075 folder if not set

# Load data
load(file = "psci_2075_data.RData") # may need to change if file name is different

# Part I

    #* Question 2. Calculate summary statistics
nes %>% # grab the nes dataset, and apply the following functions
    mutate( # transform an existing variable and make a new one
        compromise = case_when( # overwrite the compromise variable with the following conditions...
            compromise == "Compromies to get things done" ~ 1, #... when it equals this statement, set it to the value of 1
            compromise == "Sticks to his or her principles" ~ 0 #... when it equals this statement, set it to the value of 0
        )
    ) %>%
    select( # grab a variable...
        compromise # ... specifically the compromise variable
    ) %>%
    rename( # rename a variable...
        Compromise = compromise #... specifically the compromise variable
    ) %>%
    datasummary_skim( # make a table of summary statistics
        ., # using the data from above
        notes = "Data source: NES dataset.", # add these notes to the table
        output = "part_1_summary_stats.docx" # save the table in a word docx file
    )

    #* Question 3. Make histogram or boxplot
        #** Make histogram
nes %>% # grab the nes dataset, and apply the following functions
    mutate( # transform an existing variable and make a new one
        compromise = case_when( # overwrite the compromise variable with the following conditions...
            compromise == "Compromies to get things done" ~ 1, #... when it equals this statement, set it to the value of 1
            compromise == "Sticks to his or her principles" ~ 0 #... when it equals this statement, set it to the value of 0
        )
    ) %>%
    ggplot() + # make a ggplot object...
    geom_histogram( #... specifically a histogram...
        aes(
            x = compromise # put the compromise variable on the x-axis
        ),
        fill = "#D3D3D3", # ...fill the bars with light grey...
        color = "#000000" #... make the outlines of the bars black...
    ) +
    theme_minimal() + # apply the minimal theme to it
    labs( # ... clean up the labels...
        y = "Count", # ...change the y-axis to this...
        x = "Compromise", # ... change the x-axis to this...
        notes = "Data source: NES dataset" # ... add notes to the plot...
    )

        #** Make boxplot
nes %>% # grab the nes dataset, and apply the following functions
    mutate( # transform an existing variable and make a new one
        compromise = case_when( # overwrite the compromise variable with the following conditions...
            compromise == "Compromies to get things done" ~ 1, #... when it equals this statement, set it to the value of 1
            compromise == "Sticks to his or her principles" ~ 0 #... when it equals this statement, set it to the value of 0
        )
    ) %>%
    ggplot() + # make a ggplot object ...
    geom_boxplot( #... specifically a boxplot ...
        aes(
            x = compromise # put the compromise variable on the x axis
        ),
        fill = "#D3D3D3", # ...fill the bars with light grey...
        color = "#000000" #... make the outlines of the bars black...
    ) +
    theme_minimal() + # apply the minimal theme to it
    labs( # ... clean up the labels...
        y = "Count", # ...change the y-axis to this...
        x = "Compromise", # ... change the x-axis to this...
        notes = "Data source: NES dataset" # ... add notes to the plot...
    )

# Part II

    #* Question 1. Calculate summary statistics and create histogram
        
        #** Summary statistics
world %>% # grab the world dataset and apply the following functions to it
    select( # grab a column...
        gdppc # ...specifically the gdppc column
    ) %>%
    rename( # rename a column...
        `GDP per capita` = gdppc #... specifically the gdppc column
    ) %>%
    datasummary_skim( # make a table...
        ., #... with the above data...
        notes = "Data source: World dataset", #... add a note to the table...
        output = "summary_stats_two.docx" #... and store the results into a word document
    )

        #** Histogram
world %>% # grab the world dataset
    ggplot() + # make a ggplot object...
    geom_histogram( #... make a histogram...
        aes(x = gdppc), # ... put the gdppc column on the x axis
        fill = "#D3D3D3", # ...fill the bars with light grey...
        color = "#000000" #... make the outlines of the bars black...
    ) +
    theme_minimal() + # apply the minimal theme to it
    labs( # ... clean up the labels...
        y = "Count", # ...change the y-axis to this...
        x = "GDP per capita", # ... change the x-axis to this...
        notes = "Data source: World dataset" # ... add notes to the plot...
    )

    #* Question 2. Make a new variable that is the log of gdppc
world_clean <- world %>% # grab the world dataset and apply the following functions with the results stored in world_clean
    mutate( # make a transformation to an existing variable and store it in new one
        log_gdppc = log(gdppc) # make new variable called log_gdppc that is equal to the log of the gdppc variable
    )

    #* Question 3. Calculate summary statistics and make histogram of new variable

        #** Summary statistics
world_clean %>% # grab the world_clean dataset and apply the following functions to it
    select( # grab a column...
        log_gdppc # ...specifically the log_gdppc column
    ) %>%
    rename( # rename a column...
        `log(GDP per capita)` = log_gdppc #... specifically the log_gdppc column
    ) %>%
    datasummary_skim( # make a table...
        ., #... with the above data...
        notes = "Data source: World dataset", #... add a note to the table...
        output = "summary_stats_log_gdppc.docx" #... and store the results into a word document
    )

        #** Histogram
world_clean %>% # grab the world_clean dataset
    ggplot() + # make a ggplot object...
    geom_histogram( #... make a histogram...
        aes(x = log_gdppc), # ... put the log_gdppc column on the x axis
        fill = "#D3D3D3", # ...fill the bars with light grey...
        color = "#000000" #... make the outlines of the bars black...
    ) +
    theme_minimal() + # apply the minimal theme to it
    labs( # ... clean up the labels...
        y = "Count", # ...change the y-axis to this...
        x = "GDP per capita", # ... change the x-axis to this...
        notes = "Data source: World dataset" # ... add notes to the plot...
    )