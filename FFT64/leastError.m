clc, clear

least_error = zeros(10,1);
actual_error = zeros(10, 1);

for m = 1:10
RMSE_least = 0;
RMSE = 0;
xr = fi(rand(64, 1), 1, 16);
xxr = xr.double;

xr_max = max(xxr);

xi = fi(rand(64, 1), 1, 16);
xxi = xi.double;

xi_max = max(xxi);

yy = fft(xxr + 1i * xxi);
yyr = real(yy);
yyi = imag(yy);
yr = fi(yyr, 1, 16);
yi = fi(yyi, 1, 16);

[yyyr, yyyi] = myfft64(xr, xi, 15);

RMSE_least = RMSE_least + sum((yyr - yr.double).^2) + sum((yyi - yi.double).^2) / sqrt(xr_max ^ 2 + xi_max ^ 2);
RMSE = RMSE + sum((yyr - yyyr.double).^2) + sum((yyi - yyyi.double).^2) / sqrt(xr_max ^ 2 + xi_max ^ 2);

RMSE_least = sqrt(RMSE_least / 64);
RMSE = sqrt(RMSE / 64);
least_error(m) = RMSE_least;
actual_error(m) = RMSE;

end
plot(least_error);
ylim([0, max(actual_error) * 1.2])
hold on
plot(actual_error);