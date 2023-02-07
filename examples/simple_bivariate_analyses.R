# Title: Simple bivariate analyses in R

# Notes:
    #* Description:
        #** An R file on simple descriptive analyses in R
    #* Updated: 2022-02-06
        #** by: dcr

# Setup
    #* Load functions
library(magrittr) # to load the pipe operator
library(modelsummary) # for tables
library(ggplot2) # for graphs
    #* Make sure working directory is set
        #** Note: This should be set to your psci_2075 folder
        #** May need to adjust this
getwd() # this should be set to your psci_2075 folder. If not...
setwd("~/Desktop/psci_2075") # would need to change this
    #* Load data
load("psci_2075_data.RData") # may need to change to name of file

# Crosstabs
    #* Notes:
        #** Use if both of your variables are categorical

# Boxplots
    #* Notes:
        #** Use if at least one of your variables are categorical

# Scatterplot
    #* Notes:
        #** Use if BOTH variables are continuous