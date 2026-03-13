% Calculate pdf
% l_vec
clear;clc;
N_bin = 70;
%edges = -0.1:0.0001:0.1;
[N,edges]=histcounts((l_vec),N_bin);
dl = edges(2)-edges(1);
l = (edges(1:end-1)+edges(2:end))/2;
pdf = N/(sum(N)*dl);
figure;
semilogy(l(1:end-1), pdf(1:end-1)', 'ko-')