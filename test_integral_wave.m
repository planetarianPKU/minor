w = load("C:\Users\16000\Desktop\C012_HXZ_30_.txt");
plot(w);

for i = 1:length(w)
w_sum(i) = sum(w(1:i));
end
L = length(w);
F=0:length(w)-1;

f = fft(w);
A = abs(f);
A = A/(L/2);
subplot(1,2,1)
plot(F(1:L/2),A(1:L/2));%原数据的FFT
f(1) = 0;%令f(1)置0
f1 =f ;
x_ac = real(ifft(f1));
A1 = abs(f1);
A1 = A1/(L/2);
subplot(1,2,2)
plot(F(1:L/2),A1(1:L/2));%去除直流分量后的FFT

plot(w_sum_filt);
hold on;plot(w_sum)