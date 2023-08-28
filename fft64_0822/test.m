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
input = complex(inputr, inputi);

% generate expected output

standardOut = zeros(64, 25);

actualOutr = zeros(64, 25);
actualOuti = zeros(64, 25);

parfor k = 1:25
    [actualOutr(:, k), actualOuti(:, k)] = myfft64(inputr(:, k), inputi(:, k), fft8_lutr, fft8_luti, twiddle_lutr, twiddle_luti, N, w, factor_fft8, factor_twiddle);
    standardOut(:, k) = fft(input(:, k));
    disp(k);
end

mixedActualOut = fi([actualOutr, actualOuti], 1, 16);
actualOutr = double(mixedActualOut(:, 1:25));
actualOuti = double(mixedActualOut(:, 26:50));
actualOut = complex(actualOutr, actualOuti);

mixedExpectedOut = fi([real(standardOut), imag(standardOut)], 1, 16);
expectedOutr = double(mixedExpectedOut(:, 1:25));
expectedOuti = double(mixedExpectedOut(:, 26:50));
expectedOut = complex(expectedOutr, expectedOuti);

% compare

rmse_expeced = sqrt(mean(abs(standardOut - expectedOut).^2, "all"));
rmse_actual = sqrt(mean(abs(standardOut - actualOut).^2, "all"));