# Title: helper script

# Notes:
    #* Description: script that provides various helper functions
    #* Updated: 2023-02-09
        #** by: dcr

# Loop
#def loop(*args, **kwargs):
#    def wrapper(func):
#        map(lambda x: func(*args, **kwargs), range = kwargs['number_of_samples'])
#    return wrapper
## Sample
#@loop
def sample(data_frame, sample_size = [20, 50, 100, 200, 500, 1000, 5000], type = "random", number_of_samples = 1):
    """
    Name
    ----
    sample

    Description
    ----
    Helper function to create random and non-random samples

    Parameters
    ----


    """
    sample_data = []
    def single_sample():
        single_sample_data = []
        if (type == "random"):
            single_sample_data = map(lambda x: data_frame.sample(x), sample_size)
        else:
            condition_normal = data_frame["Variable B"] != 0
            condition_poisson = data_frame["Variable C"] < 1
            single_sample_data = map(lambda x: data_frame[condition_normal & condition_poisson].sample(x), sample_size)
        return single_sample_data
    sample_data = map(lambda x: single_sample(x), number_of_samples)
    return sample_data