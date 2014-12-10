clear all; close all force; clc;
% Ensure that the plot labels are sort of legible
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 2);

%% Assignment a. (Workspace: Aa_N50_Nd500_Nmax1000)
load('../workspace/Aa_N50_Nd500_Nmax1000');
data_plot = figure('name', 'Assignment a.');
hold on
    plot(alphas, results, 'Marker', 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 5);
    qls = theoreticalQls(N, alphas);
    plot(alphas, qls, 'Marker', 'd', 'MarkerSize', 5, 'Color', 'red', 'MarkerFaceColor', 'red');
hold off

axis([0.75 3.0 -0.25 1.25])
xlabel('\alpha = N / d');
ylabel('Q_{l.s.}');
saveas(data_plot, '../report/img/Aa_N50_nd500_nmax1000.png');
clear all;

%% Assignment b. All N in separate figures. (Workspace: Ab_N25-25-150_Nd75_Nmax250)
load('../workspace/Ab_N25-25-150_Nd75_Nmax250');
for i = 1:size(results, 1)
   data_plot = figure('name', sprintf('Assignment b. N = %d', NS(i)));
   plot(alphas, results(i, :), 'Marker', 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 5);
   axis([0.75 3.0 -0.25 1.25]);
   xlabel('\alpha = N / d');
   ylabel('Q_{l.s.}');
   saveas(data_plot, sprintf('../report/img/Ab_N%s_nd75_nmax250.png', num2str(NS(i))));
end
clear all;

%% Assignment b. All N in one figure. (Workspace: Ab_N25-25-150_Nd75_Nmax250)
% This part is broken.........
% load('../workspace/Ab_N25-25-150_Nd75_Nmax250');
% figure('name', 'Assignment b. N = [25:25:150]');
% data_plot = plot(alphas, results, 'Marker', 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 10);
% axis([0.75 3.0 -0.25 1.25]);
% xlabel('\alpha = P / N');
% ylabel('Q_{l.s.}');
% saveas(data_plot, '../report/img/Ab_N25-25-150_nd75_nmax250.png');
% clear all;