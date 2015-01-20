%% Start with a clean slate
clear all; close all force;
addpath('../../assignment1/code');

% Ensure that the plot labels are sort of legible
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 2)

% matlabpool('open', 4);

%% Init
N = 10;
n_max = 500;
n_d = 20;
error = 0.0005;

alphas = 0.1:0.1:5.0;
% alphas = 0.5:0.5:2;

%% Generate data and compute labels
w_star = ones(1, N);

%% Min-over
for idx=1:size(alphas, 2)
    P = ceil(alphas(idx) * N);
    for it = 1:n_d
        [data, ~] = generate_data(P, N);
        labels = w_star * data';
        labels(labels > 0) = 1;
        labels(labels < 0) = -1;
        
        [weights] =  minover(data, labels', n_max, error); 
        
        %   Compute generalization error as function of time
        %   Store final weights for everything
    end
    % Compute mean final generalization error for this alpha
end

% %% Plot 1
% 
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
% h_leg = legend(cellstr(num2str(alphas', '%.2f')));
% set(h_leg,'FontSize',18);
% % saveas(fig, '../report/img/N5NMAX500error3.png');
% 
% %% Plot 2
% 
% fig = figure();
% plot(alphas, final_g_errors, 'bo-', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
% xlabel('alpha')
% ylabel('generalization error')
% % saveas(fig, '../report/img/finalgeneralizationerrors.png');
% save('workspace');