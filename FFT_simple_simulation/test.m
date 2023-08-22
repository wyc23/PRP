clc, clearvars
x = linspace(0, 1, 64);
y = sin(11 * x) + cos(23 * x);
% plot(x, y)
% hold on;
noisyY = y + (rand(1, 64) - 0.5) * 3;
% plot(x, noisyY)
% hold on
yhat = myFFT(noisyY);
PSD = yhat .* conj(yhat) / 64;
freq = 0:63;
% plot(freq, PSD)
for index = 1:64
    if PSD(index) < 6
        yhat(index) = 0;
    end
end
deNoisedY = real(myIFFT(yhat));
plot(x, deNoisedY)