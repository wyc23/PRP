% global N_LUT_FFT8_1;
% global D_LUT_FFT8_1;

% RMSE = zeros(13, 13);


% for N_lut = 12:24
%     for N_out = 16:28
%         N_LUT_FFT8_1 = N_lut;
%         D_LUT_FFT8_1 = N_lut - 4;
%         temp_e = zeros(10, 1);
%         for k = 1:10
%             xr = fi(rand(8, 1), 1, 16, 15);
%             xi = fi(rand(8, 1), 1, 16, 15);
%             x_double = complex(double(xr), double(xi));
%             [fxr, fxi] = myfft8_1(xr, xi, 16, N_out);
%             fxr = fi(fxr, 1, N_out, N_out - 4);
%             fxi = fi(fxi, 1, N_out, N_out - 4);
%             f = fft(x_double);
%             fx = complex(double(fxr), double(fxi));
%             temp_e(k) = sqrt(mean(abs(f - fx).^2));
%         end
%         RMSE(N_lut - 11, N_out - 15) = mean(temp_e);
%     end
%     delete("*.mat")
% end



% [lr, li] = finalLUT(32);

% parfor k = 1:100
%     xr = fi(rand(8, 1), 1, 16, 15);
%     xi = fi(rand(8, 1), 1, 16, 15);
%     x_double = complex(double(xr), double(xi));
%     [fxr, fxi] = myfft8_1(xr, xi, lr, li, 16, 32);
%     fxr = fi(fxr, 1, 16, 12);
%     fxi = fi(fxi, 1, 16, 12);
%     f = fft(x_double);
%     fx = complex(double(fxr), double(fxi));
%     temp_e(k) = sqrt(mean(abs(f - fx).^2));
%     disp(k)
% end

n_lut = 32;
n_out = 32;
[lutr, luti] = finalLUT(n_lut);
xr = fi(rand(8, 200), 1, 16, 15);
xi = fi(rand(8, 200), 1, 16, 15);
x_double = complex(double(xr), double(xi));
fxr = fi(zeros(8, 200), 1, n_out, n_out-4);
fxi = fi(zeros(8, 200), 1, n_out, n_out-4);
f = zeros(8, 200);
parfor k = 1:200
    [fxr(:, k), fxi(:, k)] = myfft8_1(xr(:, k), xi(:, k), lutr, luti, 16, n_out);
    f(:, k) = fft(x_double(:, k));
end
fx = complex(double(fxr), double(fxi));
RMSE = sqrt(mean(abs(f - fx).^2, "all"));
indicator = [n_lut, n_out];
disp(indicator);
