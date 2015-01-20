%% Start with a clean slate
clear all; close all force;
addpath('../../assignment1/code');

% Defaults
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 4);
set(0,'defaultAxesFontName', 'CMU Serif Roman')
set(0,'defaultTextFontName', 'CMU Serif Roman')

% matlabpool('open', 4);

%% Init
N = 10;
n_max = 500;
n_d = 20;
error = 0.0005;

alphas = 0.1:0.1:5.0;

%% Generate data and compute labels
w_star = ones(1, N);

%% Min-over
generalization_errors = nan .* ones(size(alphas,2), ceil(alphas(end) * N) * n_max);
final_error = zeros(size(alphas, 2), 1);

for idx=1:size(alphas, 2)
    P = ceil(alphas(idx) * N);
    final_error_temp = zeros(n_d, 1);
    for it = 1:n_d
        [data, ~] = generate_data(P, N);
        labels = w_star * data';
        labels(labels > 0) = 1;
        labels(labels < 0) = -1;
        
        [weights] =  minover(data, labels', n_max, error); 
        
        e = generalization_error(w_star, weights);
        generalization_errors(idx, 1:size(e,1)) = e';
        final_error_temp(it) = e(end);
    end
    final_error(idx) = mean(final_error_temp);
    clear final_error_temp e
end

%% Plots

% Remove columns where every alpha has a nan
generalization_errors = generalization_errors(:,~all(isnan(generalization_errors), 1));

%% Plot 1: verloop van de error
fig = figure();
semilogx(generalization_errors');
xlabel('t')
ylabel('generalization error')
h_leg = legend(cellstr(num2str(alphas', '%.2f')));
set(h_leg,'FontSize',18);
saveas(fig, '../report/img/generalizationerrorverloop.png');

%% Plot 2: generealization error as a function of alpha
fig = figure();
plot(alphas, final_error, 'bo', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 5);
xlabel('alpha')
ylabel('generalization error')
saveas(fig, '../report/img/finalgeneralizationerrors.png');
save('workspace');