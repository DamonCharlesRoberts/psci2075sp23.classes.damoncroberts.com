# Title: regression diagnostics

# Notes:
    #* Description:
        #** R script for model diagnostics
    #* Updated:
        #** 2023-04-19
        #** dcr

# Load packages
library(ggplot2)
library(car)
library(lindia)

# Load data
load(file = "../assets/PSCI_2075_v2.1.RData")

# Recode the pid7 variable
    #* Recode those that say not sure to independent
nes$pid7[nes$pid7 == "Not sure"] <- "Independent"
    #* Turn it into numeric instead of factors
nes$pid7 <- as.numeric(nes$pid7)

# Descriptive statistics
    #* I don't have the code here to do this, but you should always explore your data!!!

# Regressions
    #* Bivariate regression
regression <- lm( # fit a linear regression
    formula = fthrc ~ pid7 # predict feelings toward hillary clinton with party identification
    , data = nes # these data are from the nes dataset
)
    #* Multivariate regression
multivariate_regression <- lm( # fit a linear regression
    formula = fthrc ~ pid7 + gender # predict feelings toward hillary clinton with party identification
    , data = nes # these data are from the nes dataset
)

# Table of regression results
    #* Bivariate regression
modelsummary( # make table of regression results
    regression, # with the bivariate regression model from above
    notes = c(
        "Data source: NES dataset.",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE # print out the stars to show my p-values
)
    #* Multivariate regression
modelsummary( # make table of regression results
    multivariate_regression, # with the multivariate regression model from above
    notes = c(
        "Data source: NES dataset.",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses" # add a note to tell people how this model was created and with what data.
    ),
    stars = TRUE # print out the stars to show my p-values
)

# Diagnostics of models
    #* Bivariate regression
        #** Histogram of residuals
ggplot(
) + # make a plot
geom_histogram( # specifically a histogram
    aes(x = regression$residuals), # and put the residuals from the regression on the x-axis
    color = "#000000", # make the lines between the bars black
    fill = "#D3D3D3" # fill the bars with a light grey color
) +
geom_vline( # add a vertical line
    xintercept = mean(regression$residuals), # the vertical line should be the mean value of my residuals
    color = "#000000", # the color of the line should be black
    linetype = 2 # and I want the line to be dotted
) +
theme_minimal() + # apply the minimal theme to it
labs( # adjust some of the labels
    x = "Residuals", # make x-axis label this
    y = "Count", # make y-axis label this
    caption = "Plot of residuals from model."
)
        #** residual plot
residualPlot( # make plot of my residuals
    regression # for my regression model
    , id = list(n = 10, cex=.7,location="lr") # some extra options
)
        #** leverage plot
influencePlot( # make a leverage plot
    regression, # using my regression
    id=list(
        method="noteworthy"
        , n=10
        , cex=0.7
        , location="lr"
    )
)
    #* Multivariate regression
        #** Histogram of residuals
ggplot(
) + # make a plot
geom_histogram( # specifically a histogram
    aes(x = regression$residuals), # and put the residuals from the regression on the x-axis
    color = "#000000", # make the lines between the bars black
    fill = "#D3D3D3" # fill the bars with a light grey color
) +
geom_vline( # add a vertical line
    xintercept = mean(regression$residuals), # the vertical line should be the mean value of my residuals
    color = "#000000", # the color of the line should be black
    linetype = 2 # and I want the line to be dotted
) +
theme_minimal() + # apply the minimal theme to it
labs( # adjust some of the labels
    x = "Residuals", # make x-axis label this
    y = "Count", # make y-axis label this
    caption = "Plot of residuals from model."
)
        #** residual plot
residualPlot( # make plot of my residuals
    regression # for my regression model
    , id = list(n = 10, cex=.7,location="lr") # some extra options
)
        #** leverage plot
influencePlot( # make a leverage plot
    multivariate_regression, # using my regression
    id=list(
        method="noteworthy"
        , n=10
        , cex=0.7
        , location="lr"
    )
)
        #** added variable plot
avPlots( # make a added variable plot
    multivariate_regression # with the multivariate regression
    , intercept = FALSE # do not include the intercept term
    , id=list( # some extra options
        n=5
        , cex=.7
        , location="lr"
    )
    , grid = FALSE
)
    #* All of these plots but in one figure
gg_diagnose(
    multivariate_regression
)