# Title: Logistic regression

# Notes:
    #* Description:
        #** R file for logistic regression exercise
    #* Updated:
        #** 2023-04-25
        #** dcr

# Setup
    #* Make sure packages are installed
#install.packages("modelsummary")
#install.packages("lindia")
#install.packages("ggplot2")
#install.packages("visreg")
#install.packages("jtools")
    #* Load packages
library(modelsummary)
library(lindia)
library(ggplot2)
library(visreg)
library(jtools)
    #* Load dataset
load(
    file = "../assets/PSCI_2075_v2.1.RData"
)

# Cleaning

    #* make a new column called vote_obama...
        #** ...and make the default value NA
nes$vote_obama <- NA

    #* if voted for Romney, give the new column a value of 0
nes$vote_obama[nes$vote12 == "Mitt Romney"] <- 0

    #* if voted for Obama, give the new column a value of 1
nes$vote_obama[nes$vote12 == "Barack Obama"] <- 1

    #* make a new column called pid7_int...
        #** ...and make the default value NA
nes$pid7_int <- NA

    #* if said "Not sure", make them a independent
nes$pid7[nes$pid7 == "Not sure"] <- "Independent"

    #* then remove labels from pid7 and store as pid7_int
nes$pid7_int <- as.numeric(nes$pid7)

    #* let's remove all NA rows from the dataset
nes_clean <- na.omit(nes)
    #* Check to make sure everything looks right
summary(nes$vote12)
summary(nes$vote_obama)
summary(nes_clean$pid7_int)

# Descriptive statistics
    #* Don't have the code here, but you should always describe your data!

# Regression
    #* Linear regression (LPM)
bivariate_linear <- lm(
    formula = vote_obama ~ pid7_int # does party identification predict vote choice?
    , data = nes_clean
)
    #* Logistic regression (Logit)
logistic_regression <- glm(
    formula = vote_obama ~ pid7_int # vote for obama as predicted by party identification
    , data = nes_clean # using this dataset
    , family = binomial # a logistic regression model
)

# Regression diagnostics
    #* Linear regression (LPM)
gg_diagnose(
    bivariate_linear
)

# Table of results
    #* Linear regression (LPM)
modelsummary(
    bivariate_linear # the regression I made above
    , notes = c(
        "Data source: NES dataset."
        , "Estimates from an Ordinary Least Squares regression."
        , "Standard errors in parentheses."
    ) # include these notes at the bottom of the table
    , stars = TRUE # include stars in table
    , output = "my_linear_bivariate_regression.docx"
)
    #* Logistic regression (Logit)
        #** As logged-odds
modelsummary(
    logistic_regression # the regression I made above
    , notes = c(
        "Data source: NES dataset."
        , "Estimates from an Ordinary Least Squares regression."
        , "Standard errors in parentheses."
    ) # include these notes at the bottom of the table
    , stars = TRUE # include stars in table
    , output = "my_linear_bivariate_regression.docx"
)
        #** As odds ratios
modelsummary(
    logistic_regression # the regression I made above
    , exponentiate = TRUE # show odds ratio instead
    , notes = c(
        "Data source: NES dataset."
        , "Credit: damoncroberts.com"
        , "Estimates are from a logistic regression; interpreted as odds ratios."
        , "Standard errors in parentheses."
    ) # include these notes at the bottom of the table
    , stars = TRUE # include stars in table
    , output = "odds_ratio_results.docx"
)

# Plots of results
    #* Linear regression (LPM)
        #** make a table (data.frame) with predicted and actual values
predicted_plot <- data.frame(
    predicted_values = predict(bivariate_linear),
    actual_values = nes_clean$vote_obama
)
    #** plot predicted vs. actual values
ggplot(
    data = predicted_plot # take the data from predicted_plot
) + 
geom_point( # put points on the graph based on the data
    aes(
        x = predicted_values, # put predicted_values column on x-axis
        y = actual_values # put actual_values column on y-axis
    )
) +
geom_abline( # draw a line through the points
    intercept=0
    , slope=1
) +
theme_minimal() + # make it prettier with this theme
labs( # add labels to the plot
    x='Predicted Values'
    , y='Actual Values'
)
    #* Logistic regression (Logit)
        #** With visreg package
visreg(
    logistic_regression # the logistic regression model above
    , "pid7_int" # the independent variable
    , scale = "response" # want to look at it in terms of possible values (0 or 1)
    , band = FALSE # do not show a band of confidence intervals
)
        #** With jtools package
effect_plot(
    logistic_regression # use the results from this model
    , pred = pid7_int # the independent variable to look at
    , interval = FALSE # do not show confidence interval
) +
theme_minimal() + # apply the minimal theme
labs( # apply the following labels
    y = "Probability of voting for Obama"
    , x = "Party Identification"
)