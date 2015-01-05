%% Start with a clean slate
clear all; close all force; clc;
addpath('../../assignment1/code');

%% Init
N = 10;
n_max = 500;
n_d = 10;
error = 0.05;

% alphas = 0.1: 0.1: 5.0;
alphas = [1.5];

%% Generate data and compute labels
w_star = ones(1, N);

% g_errors = zeros(max(alphas) * N * n_max, size(alphas, 2));

%% Min-over
for idx=1:size(alphas, 2)
    P = round(alphas(idx) * N);
    g_errors = -1 * ones(P * n_max, 1);
    for it = 1:n_d
        [data, ~] = generate_data(P, N);
        labels = w_star * data';
        labels(labels > 0) = 1;
        labels(labels < 0) = -1;
        
        [weight, g_error] =  minover(data, labels', n_max, w_star, error);
        
        g_errors = g_errors + g_error;
        
%         c_labels = weight * data';
%         c_labels(c_labels > 0) = 1;
%         c_labels(c_labels < 0) = -1;
%         
%         1 - sum(c_labels == labels) / P
    end
    g_errors(idx, :) = g_errors(idx, :) ./n_d;
    plot(g_errors);
end

save('workspace');