# Title: multivariate regression example

# Notes:
    #* Description:
        #** Complete working example of doing a bivariate regression
    #* Updated: 2023-03-08
        #** by: dcr

# Ensure working directory is set to psci_2075 folder on desktop
    #* Check my working directory
getwd()
    #* if my working directory is not set to psci_2075 folder, then change it
setwd("~/Desktop/psci_2075")

# Load data
waffles <- read.csv(file = "waffles.csv")

# Load packages
library(ggplot2) # for making handy graphics
library(modelsummary) # for making handy tables
library(magrittr) # for the nifty %>% operator
library(stargazer) # for making an alternative table of regression output
# Descriptive statistics (Exploratory data analysis)
    #* Univariate descriptive statistics
        #** Tabular
waffles %>% # grab the waffles dataset
    select( # select the columns I want to analyze
        WaffleHouses,
        Divorce
    ) %>%
    datasummary_skim( # make a table of univariate statistics
        data = ., # use the dataset linked with the pipe operators
        notes = "Data source: Waffles dataset (McElreath 2020).", # provide a caption for the table
        output = "univariate_descriptives.docx" # save the output to this file
    )
        #** Graphical
            #*** WaffleHouses column
waffles %>% # grab the waffles dataset
    ggplot() + # make a graph using the data
    geom_histogram( # specifically a histogram
        aes(x = WaffleHouses), # put the WaffleHouses variable on the x-axis
        color = "#000000", # add black lines around the borders of the bars
        fill = "#D3D3D3" # fill the bars with a light grey color
    ) +
    theme_minimal() + # clean up the theme to be prettier
    labs( # change the labels
        x = "Waffle Houses", # change x-axis label to this
        y = "Count", # change y-axis label to this
        caption = "Data source: Waffles dataset (McElreath 2020)."
    )
            #*** Divorce column
waffles %>% # grab the waffles dataset
    ggplot() + # make a graph using the data
    geom_histogram( # specifically a histogram
        aes(x = Divorce), # put the Divorce variable on the x-axis
        color = "#000000", # add black lines around the borders of the bars
        fill = "#D3D3D3" # fill the bars with a light grey color
    ) +
    theme_minimal() + # clean up the theme to be prettier
    labs( # change the labels
        x = "Divorce", # change x-axis label to this
        y = "Count", # change y-axis label to this
        caption = "Data source: Waffles dataset (McElreath 2020)."
    )

    #* Bivariate descriptive analyses
waffles %>% # grab the waffles dataset
    ggplot() + # make a graph using the data
    geom_point( # specifically a scatterplot
        aes(x = WaffleHouses, y = Divorce), # put WaffleHouses column on x-axis and Divorce column on y-axis
        color = "#000000", # make color of dots black
        fill = "#000000" # make fill color of dots black
    ) +
    theme_minimal() + # clean up the theme to be prettier
    labs( # change the labels
        x = "Waffle Houses?", # change x-axis label to this
        y = "Divorce rate", # change y-axis label to this
        caption = "Data source: Waffles dataset (McElreath 2020)." # add caption to plot
    )
# Regression
    #* Bivariate regression
        #** Visual (useful for first go at things, but not the final solution)
waffles %>% # grab the waffles dataset
    ggplot() + # make a graph using the data
    geom_point( # specifically a scatterplot
        aes(x = WaffleHouses, y = Divorce), # put WaffleHouses column on x-axis and Divorce column on y-axis
        color = "#000000", # make color of dots black
        fill = "#000000" # make fill color of dots black
    ) +
    geom_smooth(# add a line of best fit
        method = lm, # line should be linear
        color = "#000000", # make this line black
        se = FALSE # do not include visual representation of uncertainty
    ) +
    theme_minimal() + # clean up the theme to be prettier
    labs( # change the labels
        x = "Waffle Houses?", # change x-axis label to this
        y = "Divorce rate", # change y-axis label to this
        caption = "Data source: Waffles dataset (McElreath 2020)." # add caption to plot
    )
        #** Tabular (official way to present regression results)
            #*** First calculate the model and store the result
model <- lm( # calculate a linear model
    data = Waffles, # use the waffles dataset
    formula = Divorce ~ WaffleHouses # Divorce is the dependent variable and number of waffle houses is the independent variable
)
                #**** Can do a quick check of the model to see if it worked
summary(model)
                #**** can also look at our residuals if we want to understand how uncertain we are with the model
waffles %>% # take the waffles data
    ggplot() + # make a plot with it
    geom_histogram( # specifically a histogram
        aes(x = model$residuals), # and put the residuals from the model on the x-axis
        color = "#000000", # make the lines between the bars black
        fill = "#D3D3D3" # fill the bars with a light grey color
    ) +
    geom_vline( # add a vertical line
        xintercept = mean(model$residuals), # the vertical line should be the mean value of my residuals
        color = "#000000", # the color of the line should be black
        linetype = 2 # and I want the line to be dotted
    ) +
    theme_minimal() + # apply the minimal theme to it
    labs( # adjust some of the labels
        x = "Residuals", # make x-axis label this
        y = "Count", # make y-axis label this
        caption = "Plot of residuals from model." # add this caption to the plot
    )
            #*** Let's make a nice and easy to read output of the model's results
                #**** Using the modelsummary function
modelsummary(
    model, # take the model and use it for the output
    output = "regression.docx" # store the result of the table into this file
     )
                #**** Using the stargazer function
stargazer(
    model, # take the model and use it for the output
    type = "text" # make the type of output something that works nicely with a text file
)
    #* Multivariate regression
        #** Graphical
waffles %>% # grab my waffles dataset
    ggplot( # I am going to make a plot with these data
        data = ., # I already specified my dataset above so I can just use the dot as a shortcut
    ) +
    geom_point( # specifically, I am going to make a scatterplot
        aes(
            x = WaffleHouses, # put this variable on my x-axis
            y = Divorce, # put this variable on my y-axis
            size = MedianAgeMarriage # change the size of the dots based on age of marriage variable
        ),
        fill = "#D3D3D3", # fill the color of each dot with light grey
        color = "#D3D3D3" # color the dots with light grey
    ) +
    geom_smooth( # add a line of best fit to it
        method = "lm", # specifically a straight line
        color = "#000000", # make the line black
        se = FALSE # do not include a visual representation of uncertainty
    ) +
    theme_minimal() + # add the minimal theme
    labs( # adjust the labels
        x = "Number of waffle houses", # change x-axis label to this
        y = "Divorce", # change y-axis labe lto this
        caption = "Data source: Waffles dataset (McElreath 2020)." # add this as the caption to the plot
    )
        #** Tabular
multivariate_regression <- lm( # calculate a regression with a straight line
    formula = Divorce ~ WaffleHouses + MedianAgeMarriage, # keep what I had before, just add MedianAgeMarriage to my formula
    data = waffles # using the waffles dataset

)
            #*** Put the results into a nice table
                #**** With modelsummary
modelsummary( # make a table of results to a regression
    multivariate_regression, # show the results of my multivariate_regression
    notes = c(
        "Data source: Waffles dataset (McElreath 2020).",
        "Coefficient estimates from OLS.",
        "Standard errors in parentheses", # add a note to tell people how this model was created and with what data.
    ),
    output = "multivariate_regression.docx", # store the table in this word document
    stars = TRUE # print out the stars to show my p-values
)
                #**** With stargazer
stargazer(
    multivariate_regression, # take the model and use it for the output
    type = "text" # make the type of output something that works nicely with text files
)