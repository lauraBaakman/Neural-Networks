%% Start with a clean slate
clear all; close all force; clc;

% Defaults
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 4);
set(0,'defaultAxesFontName', 'CMU Serif Roman')
set(0,'defaultTextFontName', 'CMU Serif Roman')

%% INIT
load('data3.mat');
learning_rate = 0.05;
t_max = 200;

train_ratio = 0.4;
test_ratio = 0.4;

%% Subset data
[train_ind, ~, test_ind] = dividerand(1:size(xi, 2), train_ratio, 1 - train_ratio - test_ratio, test_ratio);

data_training = xi(:, train_ind);
labels_training = tau(train_ind);

data_test = xi(:, test_ind);
labels_test = tau(test_ind);

%% Train/Test
[weights, cost, generalization_error] = stochastic_gradient_descent(data_training, labels_training, data_test, labels_test, learning_rate, t_max);

%% Plot Errors
h = figure('name', 'threshold');
plot(1:t_max, cost, 1:t_max, generalization_error)
h_legend = legend('Cost', 'Generalization Error');
set(h_legend, 'FontSize',14, 'Orientation','horizontal', 'Location', 'north');
xlabel('time');
ylabel('error')
saveas(h, sprintf('../report/img/errors_train_%d_test_%d.png', size(data_training, 2), size(data_test, 2)));

%% Plot weights
h = figure('name', 'weights');
bar(weights, 'r');
set(gca,'XTick',1:2);
set(gca,'XTickLabel',['w1'; 'w2']);
saveas(h, sprintf('../report/img/weights_train_%d_test_%d.png', size(data_training, 2), size(data_test, 2)));

%% Store mat file
dat = datestr(now,'yyyymmdd-HHMMSS');
save(sprintf('train_%d_test_%d_%s.mat', size(data_training, 2), size(data_test, 2), dat));