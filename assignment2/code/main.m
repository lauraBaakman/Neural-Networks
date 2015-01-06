%% Start with a clean slate
clear all; close all force;
addpath('../../assignment1/code');

% Ensure that the plot labels are sort of legible
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 2)

matlabpool('open', 4);

%% Init
N = 10;
n_max = 500;
n_d = 10;
error = 0.0005;

alphas = 0.1:0.1:5.0;
% alphas = 0.5:0.5:2;

%% Generate data and compute labels
w_star = ones(1, N);

g_errors = zeros(max(alphas) * N * n_max, size(alphas, 2));
final_g_errors = zeros(size(alphas,2), 1);

%% Min-over
parfor idx=1:size(alphas, 2)
    P = ceil(alphas(idx) * N);
    g_errors_temp = zeros(P * n_max, n_d);
    for it = 1:n_d
        final_g_error_temp = zeros(it, 1);
        [data, ~] = generate_data(P, N);
        labels = w_star * data';
        labels(labels > 0) = 1;
        labels(labels < 0) = -1;
        
        [weight, g_error, final_g_error_temp(it)] =  minover(data, labels', n_max, w_star, error);
        
        g_errors_temp(:, it) = g_error;
        
%         c_labels = weight * data';
%         c_labels(c_labels > 0) = 1;
%         c_labels(c_labels < 0) = -1;
%         
%         1 - sum(c_labels == labels) / P
    end
    final_g_errors(idx) = mean(final_g_error_temp);
%     g_errors(1:P * n_max, idx) = nanmean(g_errors_temp, 2);
%     g_errors(P * n_max + 1:end, idx) = NaN;    
end

matlabpool('close');

%% Plot 1

% % Get a subset of the data
% x = 1:2:size(g_error, 1);
% g_errors_to_plot = g_errors(x, :);
% 
% % Remove NaNs
% g_errors_to_plot( all( isnan( g_errors_to_plot ), 2 ), : ) = [];
% 
% fig = figure();
% semilogx(g_errors_to_plot);
% xlabel('3 * t')
% ylabel('generalization error')
% legend(cellstr(num2str(alphas', '%.2f')))
% % saveas(fig, '../report/img/N5NMAX500error3.png');

%% Plot 2

fig = figure();
plot(alphas, final_g_errors, 'bo-', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
xlabel('alpha')
ylabel('generalization error')
saveas(fig, '../report/img/finalgeneralizationerrors.png');



save('workspace');