function [outputr, outputi] = myfft64(inputr, inputi, fft8_lutr, fft8_luti, twiddle_lutr, twiddle_luti, N, w, factor_fft8, factor_twiddle)

% 1st stage

mid1r = zeros(64, 1);
mid1i = zeros(64, 1);

for n_2 = 0:7
    [mid1r(n_2 + 1:8:64), mid1i(n_2 + 1:8:64)] = myfft8(inputr(n_2 + 1:8:64), inputi(n_2 + 1:8:64), fft8_lutr, fft8_luti, N, w, factor_fft8);
end

% 2nd stage

[mid2r, mid2i] = twiddle(mid1r, mid1i, twiddle_lutr, twiddle_luti, N, w, factor_twiddle);

% 3rd stage

outputr = zeros(64, 1);
outputi = zeros(64, 1);

for k_2 = 0:7
    [outputr(k_2 + 1:8:64), outputi(k_2 + 1:8:64)] = myfft8(mid2r(8 * k_2 + 1 : 8 * k_2 + 8), mid2i(8 * k_2 + 1 : 8 * k_2 + 8), fft8_lutr, fft8_luti, N, w, factor_fft8);
end

end