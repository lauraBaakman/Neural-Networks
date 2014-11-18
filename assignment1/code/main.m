%% Start with a clean slate
clear all; close all force; clc;

%% Init
P = 10;
N = 2;

[data, labels] = generate_data(P, N);
[weights, n] = rosenblatt(data, labels, 200);