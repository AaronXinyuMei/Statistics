% jpdf l&dpsi
clear;clc;
[n,c] = hist3([L(:), dpsi(:)],[60,60]);
n=n';
dx = c{1,1}(2)-c{1,1}(1);
dy = c{1,2}(2)-c{1,2}(1);
cc = n/(sum(n(:))*dx*dy);
figure;
contour(c{1},c{2},cc,40);
set(gca,'YDir','normal')
colormap(turbo);
colorbar;
xlabel('','Interpreter','latex','String','$l$');
ylabel('','Interpreter','latex','String','$\Delta\phi$');