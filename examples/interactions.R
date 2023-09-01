# Title: Interaction models

# Notes:
    #* Description: R Script demonstrating how to make plots to aid with the interpretation of a interactive regression model
    #* Updated: 2023-03-16
    #* Updated by: dcr

# Load packages
library(magrittr) # for pipe operator (%>%)
library(modelsummary) # for making regression tables
library(marginaleffects) # for making plots of results
library(visreg) # alternative for making plots of results

# Run regressions

bivariate <- lm( # run linear regression
    formula = fthrc ~ faminc, # fthrc = dependent variable, faminc = independent variable
    data = nes
)

interaction <- lm( # run linear regression
    formula = fthrc ~ faminc + gender + faminc:gender, # fthrc = dependent variable, faminc = independent variable
    data = nes
)
# Make table of results

modelsummary( # make table of regression results
    bivariate, # with the bivariate regression model from above
    notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE # print out the stars to show my p-values
)

modelsummary( # make table of regression results
    interaction, # with the interaction regression model from above
    notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE # print out the stars to show my p-values
)

# Alternative way to make table of results

stargazer(# make table of regression results
    bivariate,
    interaction
)

# Plot results of interactive regression

plot_predictions( # plot predicted values from this
    interaction, # plot the interaction model
    condition = c("faminc", "gender")
) +
theme_minimal() +
labs(
    y = "Feeling thermometer: Hillary Clinton",
    x = "Family income",
    caption = "Data source: NES dataset.\n Effect of family income on feelings toward Hillary Clinton, conditional on gender."
)

# Alternative way to plot results of interactive regression

visreg(# plot the predicted values from this
    interaction,
    "faminc",
    by = "gender",
    overlap = TRUE
)