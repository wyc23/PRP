clear,clc
n_in = 36;
n_lut = 4;
n_out =16;

[lutr, luti] = finalLUT();
factor = 0.5/max(lutr(:));
lutr = double(fi(lutr .* factor, 1, n_lut, n_lut));
luti = double(fi(luti .* factor, 1, n_lut, n_lut));
xxr = rand(8, 200) - 0.5;
xxi = rand(8, 200) - 0.5;
xr = fi(xxr, 1, n_in, n_in);
xi = fi(xxi, 1, n_in, n_in);
x_double = complex(xxr,xxi);
fxr = zeros(8, 200);
fxi = zeros(8, 200);
f = zeros(8, 200);
parfor k = 1:200
    [fxr(:, k), fxi(:, k)] = myfft8(xr(:, k), xi(:, k), lutr, luti, n_in);
    f(:, k) = fft(x_double(:, k));
end
fxr = fi(fxr./factor, 1, n_out);
fxi = fi(fxi./factor, 1, n_out);
fx = complex(double(fxr), double(fxi));
RMSE = sqrt(mean(abs(f - fx).^2, "all"));
disp(log10(RMSE))