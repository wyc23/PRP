RMSE = zeros(33, 33);
for n_lut = 4:36
    index = 0;
    for error_log = linspace(-2,-8,33)
        index = index + 1;
        [lutr, luti] = finalLUT(n_lut);
        xr = fi(rand(8, 200) - 0.5, 1, 16, 15);
        xi = fi(rand(8, 200) - 0.5, 1, 16, 15);
        x_double = complex(double(xr), double(xi));
        x_double_real = x_double + (10^error_log + 1i * 10^error_log)/sqrt(2);
        fxr = fi(zeros(8, 200), 1, 16, 16-4);
        fxi = fi(zeros(8, 200), 1, 16, 16 -4);
        f = zeros(8, 200);
        parfor k = 1:200
            [fxr(:, k), fxi(:, k)] = myfft8(xr(:, k), xi(:, k), lutr, luti, 16, 16);
            f(:, k) = fft(x_double_real(:, k));
        end
        fx = complex(double(fxr), double(fxi));
        RMSE(n_lut-3, index) = sqrt(mean(abs(f - fx).^2, "all"));
        indicator = [n_lut, index];
        disp(indicator);
    end
end