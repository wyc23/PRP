global N_LUT_FFT8_1;
global D_LUT_FFT8_1;

RMSE = zeros(13, 13);

% Preallocate RMSE array for parfor
RMSE_parfor = cell(1, 13);

parfor N_lut_idx = 1:13
    N_lut = 11 + N_lut_idx;

    RMSE_local = zeros(1, 13); % local RMSE array for current N_lut

    for N_out = 12:24
        N_LUT_FFT8_1 = N_lut;
        D_LUT_FFT8_1 = N_lut - 4;
        temp_rmse = zeros(1, 10);
        for k = 1:10
            xr = fi(rand(8, 1), 1, 16, 15);
            xi = fi(rand(8, 1), 1, 16, 15);
            x_double = complex(double(xr), double(xi));
            [fxr, fxi] = myfft8_1(xr, xi, 16, N_out);
            fxr = fi(fxr, 1, N_out, N_out - 4);
            fxi = fi(fxi, 1, N_out, N_out - 4);
            f = fft(x_double);
            fx = complex(double(fxr), double(fxi));
            temp_rmse(k) = sqrt(mean(abs(f - fx).^2));
        end
        RMSE_local(N_out - 11) = mean(temp_rmse);
    end

    RMSE_parfor{N_lut_idx} = RMSE_local;
end

% Combine the results from parfor loop
for N_lut_idx = 1:13
    RMSE(N_lut_idx, :) = RMSE_parfor{N_lut_idx};
end

[X, Y] = meshgrid(12:24, 12:24);
surf(X, Y, RMSE);
xlabel('N_lut');
ylabel('N_out');
zlabel('RMSE');