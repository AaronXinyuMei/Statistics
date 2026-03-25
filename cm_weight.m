% Calculate weighted conditional mean
clear; clc;

N_bin = 300;  
% r, L, weight 已经定义，长度相同

edges = linspace(min(r), max(r), N_bin+1);
r_center = (edges(1:end-1)+edges(2:end))/2;
L_center = zeros(N_bin, 1);

% -----------------------
% 循环计算加权条件均值
% -----------------------
for i = 1:N_bin
    bin_mask = r >= edges(i) & r < edges(i+1);      % 当前 bin
    L_in_bin = L(bin_mask);
    w_in_bin = weight(bin_mask);
    
    if ~isempty(L_in_bin)
        L_center(i) = sum(L_in_bin .* w_in_bin) / sum(w_in_bin);  % 加权平均
    else
        L_center(i) = NaN;  % 空 bin 用 NaN
    end
end

% -----------------------
% 作图
% -----------------------
figure;
plot(r_center, L_center, 'ko-', 'LineWidth', 1.2);
xlabel('$r$', 'Interpreter', 'latex');
ylabel('$\langle L | r \rangle_\mathrm{weighted}$', 'Interpreter', 'latex');
grid on;
title('Weighted Conditional Mean');