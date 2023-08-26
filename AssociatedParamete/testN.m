n_fft8 = 16;
n_in = 16;
n_out = 16;

% fft8 LUT

fft8_lutr = zeros(64, 8);
fft8_luti = zeros(64, 8);

for k = 0:7
    if mod(k, 2) == 0
        fft8_lutr(1:16, k + 1) = genFFT8LUTr(k);
        fft8_luti(1:16, k + 1) = genFFT8LUTi(k);
    else
        fft8_lutr(:, k + 1) = genFFT8LUTr(k);
        fft8_luti(:, k + 1) = genFFT8LUTi(k);
    end
end

factor_fft8 = 0.5 / max(fft8_lutr(:));
fft8_lutr = double(fi(fft8_lutr * factor_fft8, 1, n_fft8, n_fft8));
fft8_luti = double(fi(fft8_luti * factor_fft8, 1, n_fft8, n_fft8));

% calculate RMSE

RMSE = zeros(33,1);

for N=4:36
    xr = rand(8, 200) - 0.5;
    xi = rand(8, 200) - 0.5;
    x = complex(xr, xi);
    dataMix = double(fi([xr, xi], 1, n_in));
    xr = dataMix(:,1:200);
    xi = dataMix(:,201:400);
    fxr = zeros(8, 200);
    fxi = zeros(8, 200);
    f = zeros(8, 200);
    parfor k = 1:200
        [fxr(:, k), fxi(:, k)] = myfft8(xr(:, k), xi(:, k), fft8_lutr, fft8_luti, N);
        f(:, k) = fft(x(:, k));
    end
    fxr = fi(fxr./factor_fft8, 1, n_out);
    fxi = fi(fxi./factor_fft8, 1, n_out);
    fx = complex(double(fxr), double(fxi));
    RMSE(N - 3) = sqrt(mean(abs(f - fx).^2, "all"));
    disp(N);
end
rmse_log = log10(RMSE);
plot(4:36, rmse_log)
xlabel("N")
ylabel("log10(RMSE)")