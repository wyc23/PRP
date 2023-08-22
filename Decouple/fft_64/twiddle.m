function [outputr, outputi] = twiddle(inputr, inputi, n, k, w)
    global N_LUT_TWIDDL;
    global D_LUT_TWIDDLE;
    global N_MID1

    try load twiddleLUTr.mat
    catch
        twiddleLUTr = fi(zeros(4, 49), 1, N_LUT_TWIDDL, D_LUT_TWIDDLE);
        for r = 1:7
            for s = 1:7
                fil = [cos(-2 * r * s * pi / 64); -sin(-2 * r * s * pi / 64)];
                twiddleLUTr(:, 7 * r + s - 7) = genLUT(fil, N_LUT_TWIDDL, D_LUT_TWIDDLE);
            end
        end
        save twiddleLUTr.mat twiddleLUTr;
    end
    try load twiddleLUTi.mat
    catch
        twiddleLUTi = fi(zeros(4, 49), 1, N_LUT_TWIDDL, D_LUT_TWIDDLE);
        for r = 1:7
            for s = 1:7
                fil = [sin(-2 * r * s * pi / 64); cos(-2 * r * s * pi / 64)];
                twiddleLUTi(:, 7 * r + s - 7) = genLUT(fil, N_LUT_TWIDDL, D_LUT_TWIDDLE);
            end
        end
        save twiddleLUTi.mat twiddleLUTi;
    end
    data = cat(1, inputr.bin, inputi.bin);
    outputr = 0;
    outputi = 0;
    if n == 0 || k == 0
        outputr = inputr;
        outputi = inputi;
        return;
    end
    for t = 1:N_MID1
        index = bin2dec(data(:, t)');
        outputr = outputr + twiddleLUTr(index + 1, 7 * n + k - 7);
        outputi = outputi + twiddleLUTi(index + 1, 7 * n + k - 7);
        if t == 1
            outputr = outputr * (-2);
            outputi = outputi * (-2);
            outputr = fi(outputr, 1, w);
            outputi = fi(outputi, 1, w);
        elseif t == N_MID1
            outputr = fi(outputr * 2 ^ -inputr.FractionLength, 1, w);
            outputi = fi(outputi * 2 ^ -inputr.FractionLength, 1, w);
            break;
        else
            outputr = outputr * 2;
            outputi = outputi * 2;
            outputr = fi(outputr, 1, w);
            outputi = fi(outputi, 1, w);
        end
    end
end