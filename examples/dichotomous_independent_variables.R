# Title: Interpreting dichotomous independent variables

# Notes:
    #* Description: R Script demonstrating how to make plots to aid with the interpretation of a dichotomous independent variable in a linear regression
    #* Updated: 2023-03-16
    #* Updated by: dcr

# Load packages
library(magrittr) #for pipe operator (%>%)
library(dplyr) # for case_when and mutate functions (data cleaning)
library(modelsummary) # for making table of regression results
library(stargazer) # alternative for making table of regression results
library(marginaleffects) # for making plot of regression results
library(visreg) # alternative for making plot of regression results

# Load data
waffles <- ("waffles.csv")

# Clean the data

waffles_clean <- waffles %>% # take the waffles dataset and apply the following to it
    mutate( # create a new column based on an existing column
        WaffleHousesBinary = case_when( # make a column called WaffleHousesBinary with the following conditions
            WaffleHouses == 0 ~ 0, # when there are zero wafflehouses, set this new column value to 0
            WaffleHouses > 0 ~ 1 # when there are more than zero wafflehouses, set this new column value to 1
        )
    )

# Run regression

regression <- lm( # run a linear regression
    formula = Divorce ~ I(WaffleHousesBinary), # Divorce is predicted by a binary version of my wafflehouses variable
    data = waffles_clean # using this dataset
)

    #* Make table of results
modelsummary(
    regression, # make a table summarizing results of my regression
        notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE # print out the stars to show my p-values
)

    #* alternative way to make table of results
stargazer(
    regression # make a table summarizing the results of my regression
)
    #* Plot results
plot_predictions( # plot the predictions
    regression, # use the regression model
    by = "WaffleHousesBinary" # should be split up by whether there is a waffle house or not
) +
theme_minimal() + # add this theme to the plot
labs( # add these labels
    caption = "Data source: Waffles dataset (McElreath 2020).\n Predicted values of divorce rate based on presence of waffle houses."
)
    #* alternative way to make plot of results
visreg( # plot the results of the model
    regression, # of my regression model
    "WaffleHousesBinary", # what is the variable it should be split by?
    band = FALSE, # do not include band of uncertainty
    overlay = TRUE # include an overlay
)