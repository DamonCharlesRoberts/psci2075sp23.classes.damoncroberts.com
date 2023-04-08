# Title: confidence intervals example

# Notes:
    #* Description:
        #** Complete working example of calculating confidence intervals
    #* Updated: 2023-04-07
        #** by: dcr

# Ensure working directory is set to psci_2075 folder on desktop
    #* Check my working directory
getwd()
    #* if my working directory is not set to psci_2075 folder, then change it
setwd("~/Desktop/psci_2075")

# Load data
load(file = "PSCI_2075_v2.1.RData") # file name may be different

# Load packages
library(modelsummary) # for creating tables and a plot for CI's
library(texreg) # an alternative way to make a plot for CI's
library(ggplot2) # for extra functions to help make the plots prettier

# Exploratory data analysis and summary statistics
    #* DO NOT HAVE THE CODE HERE, BUT ALWAYS REMEMBER TO DO THIS STEP FIRST

# Bivariate regression
bivariate <- lm( # run linear regression
    formula = fthrc ~ faminc, # fthrc = dependent variable, faminc = independent variable
    data = nes
)

# Table of Bivariate regression
    #* Without CI's
modelsummary( # make table of regression results
    bivariate, # with the bivariate regression model from above
    notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE, # print out the stars to show my p-values
    output = "bivariate_regression_table.docx" # save it to this file
)
    #* With CI's
bivariate <- lm( # run linear regression
    formula = fthrc ~ faminc, # fthrc = dependent variable, faminc = independent variable
    data = nes
)

modelsummary( # make table of regression results
    bivariate, # with the bivariate regression model from above
    notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    statistic = 'conf.int', # instead of displaying standard errors, do confidence interval
    stars = TRUE, # print out the stars to show my p-values
    output = "bivariate_regression_with_cis.docx" # save it to this file
)

# Plots with the results
    #* With the texreg package
plotreg( # make a plot with the CI's
    bivariate # with the bivariate regression
    ,omit.coef = "(Intercept)" # do not include the intercept term
)
    #* With the modelsummary package
        #** NOTE: 
            #*** I personally find this one a bit prettier
            #*** It also lets you do all the extra customization with ggplot functions you usually can do
modelplot( # make a plot with the CI's
    bivariate # with the bivariate regression
    ,coef_omit="Intercept" # do not include the intercept term
) +
geom_vline(
    aes(xintercept = 0),
    linetype = 2
)