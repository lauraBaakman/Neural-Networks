
% Ensure that the plot labels are sort of legible
set(0,'DefaultAxesFontSize', 24);
set(0,'defaultlinelinewidth', 2);

data_plot = plot(alphas, results, 'Marker', 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 10);
axis([0.75 3.0 -0.25 1.25])
xlabel('\alpha = P / N');
ylabel('Q_{l.s.}');

saveas(data_plot, '../report/img/Aa_N50_nd500_nmax1000.png');
