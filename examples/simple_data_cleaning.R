# Title: Simple data cleaning in R

# Notes:
    #* Description:
      #** Example R file to clean data in R
    #* Updated: 2023-02-06
      #** by: dcr

# Load packages
library(magrittr) # for the pipe operator
library(dplyr) # for handy data cleaning functions

# Make sure working directory is set
  #* Should be set to your psci_2075 folder
getwd() # check working directory. If not to psci_2075 folder...
setwd("~/Desktop/psci_2075") #... need to set it. May need to change code here.

# Load dataset
load("psci_2075_data.RData")

# Select two of the variables and put in new dataframe
nes_subset <- nes %>% # grab the nes dataset and store result of what follows to nes_subset
  select( # select the following columns...
    vote12, # ...vote12...
    disc_police #...disc_police...
  )

    #* Check to see if I only have these two columns in the new dataframe
head(nes_subset, 5)

# Rename columns
    #* Note: Notice how I use ` on the renamed variable names...
    #* I only do this because the new variable name has spaces in it...
    #* so I need to enclose it with `.
    #* I only make variable names with spaces when I am prepping it for...
    #* a table or graph. Otherwise, I would not rename it with spaces.
nes_renamed <- nes_subset %>% # use the nes_subset dataframe created above...
    rename( # and rename the following columns
    `Vote for Obama` = vote12, # rename vote12
    `Police discrimmination` = disc_police # rename disc_police
    )
    #* Check to see if I have renamed these columns
head(nes_renamed, 5)

# Filter rows
    #* Note: only do this in cases where this is appropriate.
    #* You should not do this very often.
nes_filtered <- nes %>% # take the nes dataset...
    filter( # keep the rows when
        race == "White" # the row has a value of "White" for the race variable
        )
    #* Check to see if we have respondents of a different race in the new dataframe
summary(nes_filtered$race)

# When I want to create a new column based on an existing one
    #* Make a new variable that is the log of gdppc
world_clean <- world %>% # take the world dataset
    mutate( # mutate an existing variable to make a new one
        log_gdppc = log(gdppc) # make a new column equivalent to the log of gdppc
        )
        #** View the average value of gdppc and the new log_gdppc variable...
        #** the mean of log_gdppc should be the same as the mean for the log of gdppc
print(
    paste("Old gdppc", mean(world_clean$gdppc, na.rm = TRUE))
)
print(
    paste("Log transformed gdppc", mean(world_clean$log_gdppc, na.rm = TRUE))
)

    #* Say instead I want to make a new variable with certain values depending on an existing columns values
nes_clean <- nes %>% # take the nes dataset...
    mutate(# take an existing variable and make a new one with it
        vote_clean = case_when(
            vote12 == "Mitt Romney" ~ 0, # if Mitt Romney, code it to 0
            vote12 == "Barack Obama" ~ 1, # if Barack Obama, code it to 1
            vote12 == "Someone Else" ~ 0 # if Someone Else, code it to 0
        ),
        vote_clean = factor(# add labels to the values
            vote_clean, # take the vote_clean variable created above
            labels = c(
                "Someone Else", # give the first value the label Someone Else
                "Barack Obama" # give the next value the label Obama
            ),
            ordered = TRUE # The order of the values matter (i.e., 0 = Someone Else, 1 = Barack Obama)
            )
    )
        #** View summary statistics of this new variable
summary(nes_clean$vote_clean)