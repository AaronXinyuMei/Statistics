% Calculate conditional mean
% sample here for L on r
clear;clc;
N_bin = 300;
%r = 0;L = 0;

[N,edges]=histcounts(r,N_bin);
r_center = (edges(1:end-1)+edges(2:end))/2;
L_center = zeros(N_bin, 1);

% Loop over the bins to calculate the conditional means
for i = 1:N_bin
    % Find the indices of r_effect in the current bin
    bin_mask = r >= edges(i) & r < edges(i+1);    
    % Calculate the conditional mean of L and dpsi in the current bin
    L_center(i) = mean(L(bin_mask));    
end
% L condition on r
figure;
plot(r_center,L_center,'ko-')
xlabel('$r$','interpreter','latex')
ylabel('$<l|r>$','interpreter','latex')