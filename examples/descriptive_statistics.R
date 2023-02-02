# Title: Doing descriptive statistics in R

# Notes:
    #* Description: R file giving an example of doing descriptive statistics
    #* Updated: 2023-02-01
        #** by: dcr

# Load packages
    #* Make sure to install these!!
        #** install.packages("dplyr")
        #** install.packages("ggplot2")
        #** install.packages("modelsummary")
library(dplyr)
library(ggplot2)
library(modelsummary)

# Set working directory to psci_2075 folder on desktop
getwd() # it may already be set
setwd("~/Desktop/psci_2075") # if not, though...
# Load datasets
load(file = "psci_2075_data.RData") # note: file name may be different
    #* Check to see if world dataset loaded correctly
head(world) # previews the first five lines of world dataset
# Make histogram for the gdppc variable in the world dataset
world %>% # grab the world dataset, and do the following
    ggplot() + # make a ggplot object
    geom_histogram( # make a histogram
        aes(x = log(gdppc)), # use the gdppc variable and take the log of it
        fill = "#D3D3D3", # fill the bars with light grey
        color = "#000000" # make the outlines of the bars black
    ) +
    theme_minimal() + # change the theme to be prettier
    labs( # clean up the labels
        x = "GDP (Per Capita)", # change the x-axis label to this
        y = "Count of countries", # change the y-axis label to this
        captions = "Data source: World dataset." # add a caption
    )
# Make boxplot for the gdppc variable in the world dataset
world %>% # grab the world dataset
    ggplot() + # make a ggplot object
    geom_boxplot( # make a geom_boxplot
        aes(x = log(gdppc)), # using the log transformed gdppc variable
        fill = "#D3D3D3", # fill it with a light grey color
        alpha = 0.7 # don't make the color solid
    ) +
    theme_minimal() + # use the minimal theme to look nicer
    labs( # adjust the labels
        x = "GDP (per capita)", # change the x axis to this
        caption = "Data source: World dataset."
    )
# Calculate the descriptive statistics of the gdppc variable in the world dataset
    #* Calculate the mean
mean(world$gdppc, na.rm = TRUE) # from the world dataset, grab ($) the column called gdppc
    #* Calculate the standard deviation
sd(world$gdppc, na.rm = TRUE) # from the world dataset, grab ($) the column called gdppc
    #* Calculate a few more things
summary(world$gdppc) # from the world dataset, grab ($) the column called gdppc
        #** but no standard deviation!!
    #* Use the modelsummary package to make a couple of these calculations...
    #* ... and to make a table of them
world %>%
    mutate(
        log_gdppc = log(gdppc)
    ) %>%
    select(
        log_gdppc
    ) %>%
    rename(`log(GDP per capita)` = log_gdppc) %>%
    datasummary_skim(
        notes = "Data source: world dataset.",
        output = "gdppc_summary.html"
    )
        #** to see the table, go to your psci_2075 folder ...
        #** ... and find the file called gdppc_summary.html ...
        #** ... double click on the file to open it in a web browser ...
        #** ... once opened in the web browser, highlight the table ...
        #** ... and copy and paste it into your word document