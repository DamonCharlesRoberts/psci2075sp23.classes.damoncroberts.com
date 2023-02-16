# Title: helper script

# Notes:
    #* Description: script that provides various helper functions
    #* Updated: 2023-02-09
        #** by: dcr

import pandas as pd
from ipywidgets import widgets
import plotly.graph_objects as go

def single_sample(df, sample_size, type = "random"):
    if type == "random":
        sample = df.sample(sample_size)
    else:
        condition_normal = df["data.normal"] < 1
        condition_poisson = df["data.poisson"] == 0
        sample = df[condition_normal & condition_poisson].sample(sample_size)
    return sample

def mean_samples(df, sample_size, type = "random", num = 1):
    sample_means = pd.DataFrame()
    def repeated_sample(df, sample_size, type = type, num = num):
        sample_list = [single_sample(df, sample_size, type) for n in range(num)]
        return sample_list
    raw_samples = repeated_sample(df,sample_size, type = type, num = num)
    for i in raw_samples:
        sample_means = pd.concat([sample_means, i.mean(axis = 0).to_frame().T])
    return sample_means

def sample_histogram(dictionary, variable, type = "random"):
    sample_widget = widgets.Dropdown(
        options = ["20", "50", "100", "200", "500", "1000", "2000"],
        value = "20",
        description = "Sample size:"
    )
    trace = go.Histogram(
        x = dictionary.get("population_data")[variable],
        marker_color = "#353535")
    fig = go.FigureWidget(data = trace)
    fig.layout.bargap = 0.01
    fig.update_xaxes(showgrid=True, gridwidth=1, gridcolor='#D3D3D3')
    fig.update_yaxes(showgrid=True, gridwidth=1, gridcolor='#D3D3D3')
    fig.update_layout(plot_bgcolor = "#ffffff")
    def response(change):
        if sample_widget.value == "20":
            temp_df = dictionary.get("size_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50":
            temp_df = dictionary.get("size_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100":
            temp_df = dictionary.get("size_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200":
            temp_df = dictionary.get("size_200")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500":
            temp_df = dictionary.get("size_500")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000":
            temp_df = dictionary.get("size_1000_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000":
            temp_df = dictionary.get("size_2000")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
    sample_widget.observe(response, names = "value")
    box = widgets.VBox([
        sample_widget, 
        fig
    ])
    display(box)

def samples_histogram(dictionary, variable, type = "random"):
    sample_widget = widgets.Dropdown(
        options = ["20", "50", "100", "200", "500", "1000", "2000"],
        value = "20",
        description = "Sample size:"
    )
    sampling_widget = widgets.Dropdown(
        options = ["2", "5", "10", "20", "50", "100"],
        value = "2",
        description = "# of samples"
    )
    trace = go.Histogram(
        x = dictionary.get("population_data")[variable],
        marker_color = "#353535")
    fig = go.FigureWidget(data = trace)
    fig.layout.bargap = 0.01
    fig.update_xaxes(showgrid=True, gridwidth=1, gridcolor='#D3D3D3')
    fig.update_yaxes(showgrid=True, gridwidth=1, gridcolor='#D3D3D3')
    fig.update_layout(plot_bgcolor = "#ffffff")
    def response(change):
        if sample_widget.value == "20" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_20_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "20" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_20_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "20" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_20_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "20" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_20_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "20" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_20_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "20" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_20_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_50_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_50_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_50_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_50_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_50_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "50" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_50_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_100_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_100_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_100_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_100_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_100_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "100" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_100_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_200_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_200_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_200_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_200_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_200_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "200" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_200_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_500_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_500_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_500_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_500_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_500_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "500" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_500_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_1000_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_1000_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_1000_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_1000_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_1000_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "1000" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_1000_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "2":
            temp_df = dictionary.get("size_2000_sample_2")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "5":
            temp_df = dictionary.get("size_2000_sample_5")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "10":
            temp_df = dictionary.get("size_2000_sample_10")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "20":
            temp_df = dictionary.get("size_2000_sample_20")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "50":
            temp_df = dictionary.get("size_2000_sample_50")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
        elif sample_widget.value == "2000" and sampling_widget.value == "100":
            temp_df = dictionary.get("size_2000_sample_100")[variable].tolist()
            with fig.batch_update():
                fig.data[0].x = temp_df
    sample_widget.observe(response, names = "value")
    sampling_widget.observe(response, names = "value")
    box = widgets.VBox([
        sample_widget, 
        sampling_widget, 
        fig
    ])
    display(box)