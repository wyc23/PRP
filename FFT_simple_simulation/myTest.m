clc, clearvars
RMSE = zeros(1, 1000);
sos = 0;
for r = 1:1000
    y = rand(1, 64);
    yhat = myFFT(y);
    YHAT = fft(y);
    RMSE(r) = sqrt(sum((yhat - YHAT).*conj(yhat - YHAT)) / 64);
    sos = sos + sum((yhat - YHAT).*conj(yhat - YHAT));
end
totalRMSE = sqrt(sos / 64000);
plot(RMSE)
xlabel("Trials");
ylabel("RMSE");