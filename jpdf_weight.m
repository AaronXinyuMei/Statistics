% Weighted joint PDF of L & dpsi
clear; clc;

% -----------------------
% 输入数据
% -----------------------
% L, dpsi: 列向量
% weight: 每个样本权重，长度与 L, dpsi 相同
N = 100000;  % 样本数量

% -----------------------
% 生成测试数据
% -----------------------
L = randn(N,1);                 % L ~ N(0,1)
dpsi = 0.5*L + 0.5*randn(N,1);  % dpsi 与 L 有部分线性相关
weight = abs(L) - abs(L) + 0.1;  % 权重随 L & dpsi 增加，避免为0
% weight = rand(N,1);  
N_bin = [70, 80];  % x 和 y 的 bin 数

% -----------------------
% 构建 bin edges
% -----------------------
edges_x = linspace(min(L), max(L), N_bin(1)+1);
edges_y = linspace(min(dpsi), max(dpsi), N_bin(2)+1);
dx = edges_x(2) - edges_x(1);
dy = edges_y(2) - edges_y(1);

% -----------------------
% 初始化二维计数矩阵
% -----------------------
n_weighted = zeros(N_bin);

% -----------------------
% 循环统计加权计数
% -----------------------
for i = 1:N_bin(1)
    for j = 1:N_bin(2)
        mask = L >= edges_x(i) & L < edges_x(i+1) & ...
               dpsi >= edges_y(j) & dpsi < edges_y(j+1);
        n_weighted(i,j) = sum(weight(mask));
    end
end

% -----------------------
% 最后一个 bin 包含右端点
% -----------------------
mask = L >= edges_x(end-1) & L <= edges_x(end) & ...
       dpsi >= edges_y(end-1) & dpsi <= edges_y(end);
n_weighted(end,end) = sum(weight(mask));

% -----------------------
% 归一化为联合 PDF
% -----------------------
cc = n_weighted / (sum(n_weighted(:)) * dx * dy);

% -----------------------
% bin centers
% -----------------------
x_center = (edges_x(1:end-1)+edges_x(2:end))/2;
y_center = (edges_y(1:end-1)+edges_y(2:end))/2;

% -----------------------
% 作图
% -----------------------
figure;
contour(x_center, y_center, cc', 40);  % 注意转置
set(gca,'YDir','normal')
colormap(turbo);
colorbar;
xlabel('$l$', 'Interpreter', 'latex');
ylabel('$\Delta\phi$', 'Interpreter', 'latex');
title('Weighted Joint PDF');