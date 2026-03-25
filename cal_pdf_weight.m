% calculate pdf with weight
clear; clc;

% -----------------------
% 测试数据
% -----------------------
N = 500000;
l_vec = randn(N,1);             % 正态分布数据
l_weight = abs(l_vec)-abs(l_vec) + 1.1;    % 权重

N_bin = 50;
edges = linspace(min(l_vec), max(l_vec), N_bin+1);
dl = edges(2) - edges(1);
l = (edges(1:end-1) + edges(2:end))/2;  % bin中心

% -----------------------
% 手动计算加权直方
% -----------------------
pdf_counts = zeros(N_bin,1);

for i = 1:N_bin
    in_bin = l_vec >= edges(i) & l_vec < edges(i+1);  % 落在这个bin的样本
    pdf_counts(i) = sum(l_weight(in_bin));           % 加权求和
end

% 最后一个bin包含右端点
in_bin = l_vec >= edges(end-1) & l_vec <= edges(end);
pdf_counts(end) = sum(l_weight(in_bin));

pdf = pdf_counts / (sum(pdf_counts) * dl);

% -----------------------
% 作图
% -----------------------
figure;
plot(l, pdf, 'ko-', 'LineWidth', 1.2);
xlabel('l');
ylabel('Weighted PDF');
grid on
