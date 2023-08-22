global N_LUT_FFT8_2;
global D_LUT_FFT8_2;

RMSE = zeros(9,1);
for N_lut = 8:16
    N_LUT_FFT8_2 = N_lut;
    D_LUT_FFT8_2 = N_lut - 4;
    xr = fi(rand(64,1), 1, 16, 15);
    xi = fi(rand(64,1), 1, 16, 15);
    x_double = double(xr) + 1i*double(xi);
    [fxr, fxi] = myfft64(xr, xi, 15);
    fx_double = double(fxr) + 1i*double(fxi);
    fx_standard = fft(x_double);
    RMSE(N_lut-7) = sqrt(mean(abs(fx_standard - fx_double).^2));
    delete('LUTrs_2.mat');
    delete('LUTis_2.mat');
end