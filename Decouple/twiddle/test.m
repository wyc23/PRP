

RMSE = zeros(33, 33);

for n_lut = 4:36
    twiddleLUTr = zeros(4, 49);
    for r = 1:7
        for s = 1:7
            fil = [cos(-2 * r * s * pi / 64); -sin(-2 * r * s * pi / 64)];
            twiddleLUTr(:, 7 * r + s - 7) = genLUT(fil);
        end
    end
    twiddleLUTi = zeros(4, 49);
    for r = 1:7
        for s = 1:7
            fil = [sin(-2 * r * s * pi / 64); cos(-2 * r * s * pi / 64)];
            twiddleLUTi(:, 7 * r + s - 7) = genLUT(fil);
        end
    end
    factor = 0.5/max(twiddleLUTr(:));
    twiddleLUTr = double(fi(twiddleLUTr .* factor, 1, n_lut, n_lut));
    twiddleLUTi = double(fi(twiddleLUTi .* factor, 1, n_lut, n_lut));

    for n_in = 4:36

        inputr = rand(64, 25) - 0.5;
        inputi = rand(64, 25) - 0.5;
        input = complex(inputr, inputi);
        inputr = fi(inputr, 1, n_in, n_in);
        inputi = fi(inputi, 1, n_in, n_in);

        outputr = zeros(64, 25);
        outputi = zeros(64, 25);
        standard_out = zeros(64, 25);

        parfor m = 1:25
            [outputr(:, m), outputi(:, m)] = twiddle(inputr(:, m), inputi(:, m), twiddleLUTr, twiddleLUTi, n_in, factor);
            standard_out(:, m) = standard_twiddle(input(:, m));
        end
        outputr = fi(outputr, 1, 16);
        outputi = fi(outputi, 1, 16);
        output = complex(double(outputr), double(outputi)) ./ factor;
        RMSE(n_lut-3, n_in-3) = sqrt(mean(abs(output - standard_out).^2, "all"));
        indicator = [n_lut, n_in];
        disp(indicator);
    end
end


