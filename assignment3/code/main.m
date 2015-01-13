%% Start with a clean slate
clear all; close all force; clc;

%% INIT
load('data3.mat');
learning_rate = 0.05;
t_max = 200;
num_training_samples = 100;

%% Training
training_data = datasample(xi, num_training_samples, 2);
weights = stochastic_gradient_descent(training_data, tau, learning_rate, t_max);