# Title: inference_data

# Notes:
    #* Description:
        #** Script to generate simulated data
    #* Updated: 2023-02-15
        #** by: dcr

# Import needed functions
from random import seed # for seed
from numpy.random import normal, negative_binomial, binomial # for simulating data with particular distributions
from helper import single_sample, mean_samples
import pandas as pd # for managing the simulated data as a pd.DataFrame
import numpy as np # for managing the columns of simulated data

# Set the seed
seed(2075)

# Population distribution
    #* Define N
population_N = 1000000
    #* Simulate population data
population_data = pd.DataFrame({
    "data.normal": normal(0, 1, population_N),
    "data.poisson": negative_binomial(1, 0.5, population_N),
    "data.binomial": binomial(1, 0.5, population_N)
})

# Sample data
sample_data = {}
sample_sizes = [20, 50, 100, 200, 500, 1000, 2000]
for i in sample_sizes:
    sample_data['size_{}'.format(i)] = single_sample(df = population_data, sample_size = i)
sample_data["population_data"] = population_data

non_random_sample_data = {}
for i in sample_sizes:
    non_random_sample_data['size_{}'.format(i)] = single_sample(df = population_data, sample_size = i, type = "non-random")
non_random_sample_data["population_data"] = population_data

# Samples data
samples_data = {}
num_of_samples = [2, 5, 10, 20, 50, 100, 1000]
for j in num_of_samples:
    for i in sample_sizes:
        samples_data['size_{}_sample_{}'.format(i,j)] = mean_samples(df = population_data, sample_size = i, type = "random", num = j)
samples_data["population_data"] = population_data

non_random_samples_data = {}
for j in num_of_samples:
    for i in sample_sizes:
        non_random_samples_data['size_{}_sample_{}'.format(i,j)] = mean_samples(df = population_data, sample_size = i, type = "random", num = j)
non_random_samples_data["population_data"] = population_data