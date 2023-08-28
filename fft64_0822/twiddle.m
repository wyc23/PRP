function [outputr, outputi] = twiddle(inputr, inputi, twiddleLUTr, twiddleLUTi, N, w, factor_twiddle)
    outputr = zeros(64,1);
    outputi = zeros(64,1);
    mixData = fi([inputr, inputi], 1, N);
    inputr = mixData(:, 1);
    inputi = mixData(:, 2);
    for n = 0:7
        for k = 0:7
            realpart = inputr(8*n+k+1);
            imagpart = inputi(8*n+k+1);
            data = cat(1, realpart.bin, imagpart.bin);

            if n == 0 || k == 0
                outputr(8*n+k+1) = double(inputr(8*n+k+1)) * factor_twiddle;
                outputi(8*n+k+1) = double(inputi(8*n+k+1)) * factor_twiddle;
                continue;
            end
            for t = 1:N
                index = bin2dec(data(:, t)');
                outputr(8*n+k+1) = outputr(8*n+k+1) + twiddleLUTr(index + 1, 7 * n + k - 7);
                outputi(8*n+k+1) = outputi(8*n+k+1) + twiddleLUTi(index + 1, 7 * n + k - 7);
                outputr(8*n+k+1) = double(fi(outputr(8*n+k+1), 1, w));
                outputi(8*n+k+1) = double(fi(outputi(8*n+k+1), 1, w));
                if t == 1
                    outputr(8*n+k+1) = outputr(8*n+k+1) * (-2);
                    outputi(8*n+k+1) = outputi(8*n+k+1) * (-2);
                    outputr(8*n+k+1) = double(fi(outputr(8*n+k+1), 1, w));
                    outputi(8*n+k+1) = double(fi(outputi(8*n+k+1), 1, w));
                elseif t == N
                    outputr(8*n+k+1) = outputr(8*n+k+1) * 2 ^ -inputr.FractionLength;
                    outputi(8*n+k+1) = outputi(8*n+k+1) * 2 ^ -inputr.FractionLength;
                    outputr(8*n+k+1) = double(fi(outputr(8*n+k+1), 1, w));
                    outputi(8*n+k+1) = double(fi(outputi(8*n+k+1), 1, w));
                    break;
                else
                    outputr(8*n+k+1) = outputr(8*n+k+1) * 2;
                    outputi(8*n+k+1) = outputi(8*n+k+1) * 2;
                    outputr(8*n+k+1) = double(fi(outputr(8*n+k+1), 1, w));
                    outputi(8*n+k+1) = double(fi(outputi(8*n+k+1), 1, w));
                end
            end
        end
    end
    outputr = outputr ./ factor_twiddle;
    outputi = outputi ./ factor_twiddle;
end