clear
clc
close all

% Loading in data

tbl = readtable('./cora-experiments-walk-length.csv', 'ReadRowNames', true);
% plot(tbl, 'input', 'output')

X = tbl{:, "walkLength"};
y1 = tbl{:, "accuracy"};
y2 = tbl{:, "f1_micro"};
y3 = tbl{:, "f1_macro"};

acc = 10;
min_x = min(X);
max_x = max(X);
min_y = floor(min(min(y2*acc), min(y3*acc)))/acc;
max_y = ceil(max(max(y2*acc), max(y3*acc)))/acc;

plot_performance(X, y2, y3, "Walk length", [min_x max_x min_y max_y], "walk_length")