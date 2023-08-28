% constants

N = 16;
w = 17;
n_fft8 = 16;
n_twiddle = 16;

% generate look-up tables

[fft8_lutr, fft8_luti, twiddle_lutr, twiddle_luti, factor_fft8, factor_twiddle] = fft64LUT(n_fft8, n_twiddle);

% generate input data

inputr = rand(64, 25) - 0.5;
inputi = rand(64, 25) - 0.5;
mixData = fi([inputr, inputi], 1, 16);
inputr = double(mixData(:, 1:25));
inputi = double(mixData(:, 26:50));

% generate expected output

standardOut = zeros(64, 25);

actualOutr = zeros(64, 25);
actualOuti = zeros(64, 25);

parfor k = 1:25
    [actualOutr(:, k), actualOuti(:, k)] = myfft64(inputr(:, k), inputi(:, k), fft8_lutr, fft8_luti, twiddle_lutr, twiddle_luti, N, w, factor_fft8, factor_twiddle);
    standardOut(:, k) = fft(inputr(:, k), inputi(:, k));
end

actualOutr = double(fi(actualOutr, 1, 16));
actualOuti = double(fi(actualOuti, 1, 16));
actualOut = complex(actualOutr, actualOuti);

expectedOutr = double(fi(real(standardOut), 1, 16));
expectedOuti = double(fi(imag(standardOut), 1, 16));
expectedOut = complex(expectedOutr, expectedOuti);

% compare

rmse_expeced = sqrt(mean(abs(standardOut - expectedOut).^2, "all"));
rmse_actual = sqrt(mean(abs(standardOut - actualOut).^2, "all"));