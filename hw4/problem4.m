t=-pi:0.001:pi;
t0=[-pi, -pi/2, -pi/2, pi/2, pi/2, pi];
x0=[0, 0, 1, 1, 0, 0];
set(gcf,'color','w');
for N=[1, 3, 5, 10, 20, 50]
    x=1/2;
    for n=1:N
        x=x + sin(n * pi / 2) / (pi * n) * exp(-1i * n .* t) + sin(-n * pi / 2) / (pi * -n) * exp(-1i * -n .* t);
    end
    plot(t0, x0);
    hold on;
    plot(t, x);
    title(sprintf('N=%d', N));
    hold off;
    export_fig(sprintf('problem4c-%d.pdf', N));
end