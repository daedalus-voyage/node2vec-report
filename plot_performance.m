function [] = plot_performance(X, y2, y3, x_label, axis_range, filename)
%PLOT PERFORMANCE Plots performance (accuracy, f1 micro, f1 macro)
%   Detailed explanation goes here

%%
% Loading in data

% tbl = readtable('./cora-experiments-walk-number.csv', 'ReadRowNames', true);
% % plot(tbl, 'input', 'output')
% 
% % n = tbl{'walkNumber'};
% tbl = removevars(tbl, 'p');
% tbl = removevars(tbl, 'walkLength');
% tbl = removevars(tbl, 'q');
% 
% X = tbl{:, "walkNumber"};
% y1 = tbl{:, "accuracy"};
% y2 = tbl{:, "f1_micro"};
% y3 = tbl{:, "f1_macro"};

% plot(tbl, "walkNumber", ["accuracy", "f1_micro", "f1_macro"])

%
% Tiled layout with separate graphs

fig1 = figure('Position', [10 10 600 300]);
% axes1 = axes('Parent', fig1);

% hold(axes1,'on');

tl = tiledlayout(1, 2);

% ax1 = nexttile;
% plot(X, y1,'DisplayName','accuracy','Marker','+','LineWidth',0.5,...
%     'LineStyle','-', 'Color','#0072BD')
% title("Accuracy")
% xlabel("Walk number")
ax2 = nexttile;
plot(X, y2,'MarkerSize',12,'Marker','.',...
    'LineWidth',2,'Color','#D95319',...
    'LineStyle',':')
title("F1 (micro)")
% xlabel("Walk number")
ax3 = nexttile;
plot(X, y3,'MarkerSize',12,'Marker','.',...
    'LineWidth',2,'Color','#EDB120',...
    'LineStyle',':')
title("F1 (macro)")
% xlabel("Walk number")

axis([ax2, ax3], axis_range);
ylabel(tl, "Performance")
xlabel(tl, x_label)

saveas(gcf,append('./results/', filename, '_tiled.png'))

%
% 3 metrics in 1 graph

fig2 = figure;
axes2 = axes('Parent', fig2);
% hold(axes2,'on');

% plot(X, y1,'DisplayName','accuracy','Marker','+','MarkerSize', 16,'LineWidth',0.5,...
%     'LineStyle','-')
% hold on
plot(X, y2,'MarkerSize',10,'Marker','.','Parent',axes2,...
    'LineWidth',2,'Color','#D95319',...
    'LineStyle',':')
hold on
plot(X, y3,'MarkerSize',10,'Marker','.','Parent',axes2,...
    'LineWidth',2,'Color','#EDB120',...
    'LineStyle',':')

axis(axis_range);
ylabel("Performance")
xlabel(x_label)

legend("f1 (micro)", "f1 (macro)", 'Location', 'southeast', 'FontSize', 12)

saveas(gcf,append('./results/', filename, '.png'))

end

