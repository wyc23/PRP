n_lut = 12;
n_out = 12;

[lutr, luti] = finalLUT(n_lut);
xr = fi(rand(8, 200) - 0.5, 1, 16, 15);
xi = fi(rand(8, 200) - 0.5, 1, 16, 15);
x_double = complex(double(xr), double(xi));
fxr = fi(zeros(8, 200), 1, n_out, n_out-4);
fxi = fi(zeros(8, 200), 1, n_out, n_out-4);
f = zeros(8, 200);
parfor k = 1:200
    [fxr(:, k), fxi(:, k)] = myfft8(xr(:, k), xi(:, k), lutr, luti, 16, n_out);
    f(:, k) = fft(x_double(:, k));
end
fx = complex(double(fxr), double(fxi));
RMSE = sqrt(mean(abs(f - fx).^2, "all"));