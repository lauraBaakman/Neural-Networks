%% Start with a clean slate
clear all; close all force; clc;

%% Init
% P = 10;
% N = 2;
% d_max = 100;

%% Run
% [data, labels] = generate_data(P, N);

% data = [1, 1; 2, 1; 3, 1; 3, 7; 4, 7];
% labels = [1, 1, 1 -1, -1]';
% P = size(data, 1);
% N = size(data, 2);
%
% [weights, d_actual] = rosenblatt(data, labels, d_max);
%
%% Test
% error = zeros(P,1);
% for p_idx = 1:P
%     error(p_idx) = dot(weights, data(p_idx, :)) * labels(p_idx) > 0;
% end

%% Init Test
NS = (25:25:150);
% NS = 25;
alphas = (0.75:0.05:3.0);
n_d = 75;
n_max = 250;

results = zeros(size(NS, 2), size(alphas,2));
convs = zeros(size(NS, 2), size(alphas,2));

pp = parpool('local', 4);

for j = 1:size(NS,2)
    parfor i = 1:size(alphas, 2)
        [result, conv] = test(n_d, n_max, NS(j), alphas(i));
        results(j, i) = result;
        convs(j, i) = conv;
    end
end
delete(pp);

