# Title: Simple bivariate analyses in R

# Notes:
    #* Description:
        #** An R file on simple descriptive analyses in R
    #* Updated: 2022-02-06
        #** by: dcr

# Setup
    #* Load functions
        #** Note: make sure to install these packages first if you haven't already!!
# install.packages("magrittr")
# install.packages("dplyr")
# install.packages("modelsummary")
# install.packages("ggplot2")

library(magrittr) # to load the pipe operator
library(dplyr) # for datacleaning
library(modelsummary) # for tables
library(ggplot2) # for graphs

    #* Make sure working directory is set
        #** Note: This should be set to your psci_2075 folder
        #** May need to adjust this
getwd() # this should be set to your psci_2075 folder. If not...
setwd("~/Desktop/psci_2075") # would need to change this

    #* Load data
load("psci_2075_data.RData") # may need to change to name of file

# Clean data
nes_clean <- nes %>%
mutate( #... I am now going to "mutate" or transform these columns into a new one
        #* vote12 - did the respondent vote for Obama in '12 or not?
            #** Coded as: 
                #*** 1 = Mitt Romney
                #*** 2 = Barack Obama
                #*** 3 = Someone Else
                #*** 4 = Not asked
            #** Recoded to:
                #*** 0 = Mitt Romney/Someone Else
                #*** 1 = Barack Obama
                #*** NA = Not Asked
        vote12_clean = case_when(
            vote12 == "Mitt Romney" ~ 0, # make values of Mitt Romney equal to 0
            vote12 == "Barack Obama" ~ 1, # make values of Barack Obama equal to 1
            vote12 == "Someone Else" ~ 0 # make values of Someone Else equal to 0
        ),
        vote12_clean = factor(
            vote12_clean, # take the newly created column
            labels = c(
                "Not Obama", # add this label to values of 0
                "Obama" # add this labels to values of 1
            ),
            ordered = TRUE # the numerical value order matters here
        ),
        #* disc_police - belief that police treat Black Americans better than Whites
            #** Coded as:
                #*** 1 = Treat Whites much better
                #*** 2 = Treat Whites moderately better
                #*** 3 = Treats Whites a little better
                #*** 4 = Treats both the same 
                #*** 5 = Treats Blacks a little better
                #*** 6 = Treats Blacks moderately better
                #*** 7 = Treats Blacks much better
            #** Recoded to:
                #*** 0 = Treats Whites [much/moderately/a little better]/treats both the same
                #*** 1 = Treats Blacks [much/moderately a little better]
        disc_police_clean = case_when(
            disc_police == "Treats whites much better" ~ 0, # make this response equal to 0
            disc_police == "Treats whites moderately better" ~ 0, # make this response equal to 0
            disc_police == "Treats whites a little better" ~ 0, # make this response equal to 0
            disc_police == "Treats both the same" ~ 0, # make this response equal to 0
            disc_police == "Treats blacks a little better" ~ 1, # make this response equal to 1
            disc_police == "Treats blacks moderately better" ~ 1, # make this response equal to 1
            disc_police == "Treats Blacks much better" ~ 1 # make this response equal to 1
        ),
        disc_police_clean = factor(
            disc_police_clean, # take the newly created column
            labels = c(
                "Does not treat better", # add this label if equal to 0
                "Does treat better" # add this label if equal to 1
            ),
            ordered =  TRUE # the numerical value order matters here
        )
    )

# Crosstabs
    #* Notes:
        #** Use if both of your variables are categorical

    #* Using the `table()` function:
        #** With the original variables
table( # use the table function
    nes_clean$vote12, # from the nes_clean dataset, use the vote12 variable
    nes_clean$disc_police # from the nes_clean dataset, use the disc_police variable
)
        #** With the clean variables
table(
    nes_clean$vote12_clean, # from the nes_clean dataset, use the vote12_clean variable
    nes_clean$disc_police_clean # from the nes_clean dataset, use the disc_police_clean variable
)

    #* Using the `xtabs()` and `ftable()` functions
        #** With the original variables
nes_clean %>% # grab the nes dataset
    xtabs( # perform the crosstab..
        ~ vote12 + disc_police, # use the vote12 and disc_police variables
    data = . # and use the data connected by the pipe operator (can just use .)
    ) %>%
    ftable()  #... and then make it look nicer with ftable
        #** With the clean variables
nes_clean %>% # grab the nes dataset
    xtabs( # perform the crosstab..
        ~ vote12_clean + disc_police_clean, # use the vote12 and disc_police variables
    data = . # and use the data connected by the pipe operator (can just use .)
    ) %>%
    ftable()  #... and then make it look nicer with ftable

    #* Using the `datasummary_crosstab()` function
        #** With the original variables
nes_clean %>% # grab the nes dataset
    datasummary_crosstab( # use the datasummary_crosstab on it
        disc_police ~ vote12, # using the disc_police and vote12 variables
        notes = "Data source: NES dataset.", # add notes to table
        data = ., # using the dataset connected by the pipe operator
        output = "bivariate_crosstab.docx" # store result in the word document bivariate_crosstab.docx
    )
        #** With the clean variables
nes_clean %>% # grab the nes dataset
    datasummary_crosstab( # use the datasummary_crosstab on it
        disc_police_clean ~ vote12_clean, # using the disc_police_clean and vote12_clean variables
        notes = "Data source: NES dataset.", # add notes to table
        data = ., # using the dataset connected by the pipe operator
        output = "bivariate_crosstab.docx" # store result in the word document bivariate_crosstab.docx
    )

# Boxplots
    #* Notes:
        #** Use if at least one of your variables are categorical

states %>% # grab the states dataset
    mutate( # create a new column based on an existing one
        trumpwin_clean = factor( # create a column trumpwin_clean with value labels
            trumpwin, # use the existing trumpwin variable for this
            labels = c(
                "Loss", # for the first value (0), label it Loss
                "Won" # for the second value (1), label it Won
            ),
            ordered = TRUE # the order of the values and labels matter
        )
    ) %>% # after I've done this, now I can make a plot
    ggplot() + # make a ggplot object
    geom_boxplot( # make a box plot
        aes(
            x = trumpwin_clean, # where the x-axis is whether trump won or not
            y = murderrate # and the y-axis is the murder rate in the state
        ),
        fill = "#D3D3D3" # fill the boxplot with a light grey color
    ) +
    theme_minimal() + # add the minimal theme to look prettier
    labs( # clean up the labels
        x = "Trump won state", # change x-axis label to this
        y = "Murder rate per capita", # change y-axis label to this
        caption = "Data source: States dataset." # add caption
    )

# Scatterplot
    #* Notes:
        #** Use if BOTH variables are continuous

nes %>% # grab the nes dataset and apply the following
    ggplot() + # create a ggplot object
    geom_point( # make this plot a scatterplot
        aes(
            x = ftobama, # use the ftobama variable for the x-axis
            y = ftgay # use the ftgay variable for the y-axis
        ),
        color = "#000000", # add black for outline of points
        fill = "#D3D3D3", # add grey to fill of points
        alpha = 0.5 # add transparency to each point
    ) + 
    theme_minimal() + # use the minimal theme to make prettier
    labs( # adjust the labels
        x = "Feeling thermometer: Obama", # change the x-axis label to this
        y = "Feeling thermometer: LGBTQIA+", # change the y-axis label to this
        caption = "Data source: NES dataset." # add this as the caption
    )