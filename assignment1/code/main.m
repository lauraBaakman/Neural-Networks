%% Start with a clean slate
clear all; close all force; clc;

%% Set random seed
rng('default');

%% Init
P = 10;
N = 2;
d_max = 100;

%% Run
% [data, labels] = generate_data(P, N);

data = [1, 1; 2, 1; 3, 1; 3, 7; 4, 7];
labels = [1, 1, 1 -1, -1]';
P = size(data, 1);
N = size(data, 2);

[weights, d_actual] = rosenblatt(data, labels, d_max);

%% Test
error = zeros(P,1);
for p_idx = 1:P
    error(p_idx) = dot(weights, data(p_idx, :)) * labels(p_idx) > 0;
end
