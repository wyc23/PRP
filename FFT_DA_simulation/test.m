clc, clearvars
RMSE = zeros(1, 1000);
sos = 0;
for r = 1:1000
    y = (rand(1, 8) - 0.5) * 2;
    yhat = myfft8(y);
    YHAT = fft(y);
    RMSE(r) = sqrt(sum((yhat - YHAT).*conj(yhat - YHAT)) / 8);
    sos = sos + sum((yhat - YHAT).*conj(yhat - YHAT));
end
totalRMSE = sqrt(sos / 8000);
plot(RMSE)
xlabel("Trials");
ylabel("RMSE");
