clear
clc
close all

% Loading in data

tbl = readtable('./cora-experiments-pvals-l9-n60.csv', 'ReadRowNames', true);
% plot(tbl, 'input', 'output')

range = 1:7;
X = tbl{range, "p"};
y1 = tbl{range, "accuracy"};
y2 = tbl{range, "f1_micro"};
y3 = tbl{range, "f1_macro"};

acc = 10;
min_x = min(X);
max_x = max(X);
min_y = floor(min(min(y2*acc), min(y3*acc)))/acc;
max_y = ceil(max(max(y2*acc), max(y3*acc)))/acc;

plot_performance(X, y2, y3, "P", [min_x max_x min_y max_y], "p_values_long")

range = 1:4;
X = tbl{range, "p"};
y1 = tbl{range, "accuracy"};
y2 = tbl{range, "f1_micro"};
y3 = tbl{range, "f1_macro"};

acc = 10;
min_x = min(X);
max_x = max(X);
min_y = floor(min(min(y2*acc), min(y3*acc)))/acc;
max_y = ceil(max(max(y2*acc), max(y3*acc)))/acc;

plot_performance(X, y2, y3, "P", [min_x max_x min_y max_y], "p_values_short")