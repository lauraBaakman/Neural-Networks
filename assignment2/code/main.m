%% Start with a clean slate
clear all; close all force; clc;
addpath('../../assignment1/code');

%% Init
D = 200;
N = 10;
n_max = 100;
P = 5;

%% Generate data and compute labels
[data, ~] = generate_data(D, N);
w_star = ones(1, N);
labels = w_star * data';
labels(labels > 0) = 1;
labels(labels < 0) = -1;

%% Min-over
minover(data, labels', P, n_max);