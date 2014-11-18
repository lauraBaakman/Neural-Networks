%% Start with a clean slate
clear all; close all force; clc;

%% Set random seed
rng('default');

%% Init
P = 10;
N = 2;
d = 999999;

%% Run
[data, labels] = generate_data(P, N);
[weights, n] = rosenblatt(data, labels, d);

%% Test
error = zeros(10,1);
for p_idx = 1:P
    error(p_idx) = dot(weights, data(p_idx, :)) * labels(p_idx) > 0;
end
