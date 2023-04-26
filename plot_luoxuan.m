t = 0:pi/1e3:4*pi;
lambda = 1/pi*log10(t);
r=exp(lambda.*t);
x = r .* cos(t);
y = r .* sin(t);
plot(x,y);