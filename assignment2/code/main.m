%% Start with a clean slate
clear all; close all force; clc;
addpath('../../assignment1/code');

%% Init
P = 250;
N = 10;
n_max = 200;

%% Generate data and compute labels
[data, ~] = generate_data(P, N);
w_star = ones(1, N);
labels = w_star * data';
labels(labels > 0) = 1;
labels(labels < 0) = -1;

%% Min-over
[weight, g_errors] = minover(data, labels', n_max, w_star);

c_labels = weight * data';
c_labels(c_labels > 0) = 1;
c_labels(c_labels < 0) = -1;

1 - sum(c_labels == labels) / P