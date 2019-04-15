h = [2 exp(-0.1)+2 exp(-0.2)+4 exp(-0.3)+3 exp(-0.4)+2 exp(-0.5) exp(-0.6) exp(-0.7) exp(-0.8) exp(-0.9) exp(-1)];
x = ones(1,11);
y = conv(x,h);
stem(0:10, y(1,1:11));
set(gcf,'color','w');
export_fig problem5c.pdf;