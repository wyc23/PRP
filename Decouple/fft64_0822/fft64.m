function [outputr, outputi] = myFun(inputr, inputi)
%myFun - Description
%
% Syntax: [outputr, outputi] = myFun(inputr, inputi)
%
% Long description
% outputr, outputi: real and imaginary part of the output, double
% inputr, inputi: real and imaginary part of the input, double

% Generate lookup tables for fft8 and twiddle

n_fft8 = 16;
n_twiddle = 16;

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

% twiddle LUT

twiddle_lutr = zeros(4, 49);
twiddle_luti = zeros(4, 49);

for r = 1:7
    for s = 1:7
        fil = [cos(-2 * r * s * pi / 64); -sin(-2 * r * s * pi / 64)];
        twiddle_lutr(:, 7 * r + s - 7) = genLUT(fil);
        fil = [sin(-2 * r * s * pi / 64); cos(-2 * r * s * pi / 64)];
        twiddle_luti(:, 7 * r + s - 7) = genLUT(fil);
    end
end

factor_twiddle = 0.5 / max(twiddle_lutr(:));
twiddle_lutr = double(fi(twiddle_lutr * factor_twiddle, 1, n_twiddle, n_twiddle));
twiddle_luti = double(fi(twiddle_luti * factor_twiddle, 1, n_twiddle, n_twiddle));

input_mix = fi([inputr; inputi], 1, 16);
