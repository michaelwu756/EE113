x = -1:4;
y = [0 1 0.5 0.25 0.125 0];
stem(x,y);
set(gcf,'color','w');
export_fig problem2ax.pdf;

x = -1:6;
y = [0 4 1 0.25 0.0625 0.015625 0.00390625 0];
stem(x,y);
export_fig problem2ay.pdf;

x = -1:6;
y = [0 4 0.5 0.0625 0.0078125 0 0 0];
stem(x,y);
export_fig problem2b.pdf;