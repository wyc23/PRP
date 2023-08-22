clc, clearvars
RMSE = zeros(1, 1000);
sos = 0;
for r = 1:1000
    rl = randi(2^16, 8, 1) - 2^15 - 1;
    img = randi(2^16, 8, 1) - 2^15 - 1;
    bin_rl = dec2bin(rl, 16);
    bin_img = dec2bin(img, 16);
    yhat = myfft8(bin_rl, bin_img)./2^15;
    YHAT = fft(rl + 1i * img)./2^15;
    RMSE(r) = sqrt(sum((yhat - YHAT).*conj(yhat - YHAT)) / 8);
    sos = sos + sum((yhat - YHAT).*conj(yhat - YHAT));
end
totalRMSE = sqrt(sos / 8000);
plot(RMSE)
xlabel("Trials");
ylabel("RMSE");
