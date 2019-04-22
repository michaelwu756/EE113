n = 0:24;
m = [1 0 0 1/2 0 0 0 3/2 0 0 0 0 0 0 0 0 0 0 3/2 0 0 0 1/2 0 0];
p = [0 0 0 0 0 0 0 -pi/2 0 0 0 0 0 0 0 0 0 0 pi/2 0 0 0 0 0 0];
stem(n, m);
set(gcf,'color','w');
title('Magnitude');
export_fig problem4-mag.pdf;
stem(n, p);
title('Phase');
export_fig problem4-phase.pdf;