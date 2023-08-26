function [outputr, outputi] = twiddle(inputr, inputi, twiddleLUTr, twiddleLUTi, n_in, factor)
    outputr = zeros(64,1);
    outputi = zeros(64,1);
    for n = 0:7
        for k = 0:7
            realpart = inputr(8*n+k+1);
            imagpart = inputi(8*n+k+1);
            data = cat(1, realpart.bin, imagpart.bin);

            if n == 0 || k == 0
                outputr(8*n+k+1) = double(inputr(8*n+k+1)) * factor;
                outputi(8*n+k+1) = double(inputi(8*n+k+1)) * factor;
                continue;
            end
            for t = 1:n_in
                index = bin2dec(data(:, t)');
                outputr(8*n+k+1) = outputr(8*n+k+1) + twiddleLUTr(index + 1, 7 * n + k - 7);
                outputi(8*n+k+1) = outputi(8*n+k+1) + twiddleLUTi(index + 1, 7 * n + k - 7);
                if t == 1
                    outputr(8*n+k+1) = outputr(8*n+k+1) * (-2);
                    outputi(8*n+k+1) = outputi(8*n+k+1) * (-2);
                elseif t == n_in
                    outputr(8*n+k+1) = outputr(8*n+k+1) * 2 ^ -inputr.FractionLength;
                    outputi(8*n+k+1) = outputi(8*n+k+1) * 2 ^ -inputr.FractionLength;
                    break;
                else
                    outputr(8*n+k+1) = outputr(8*n+k+1) * 2;
                    outputi(8*n+k+1) = outputi(8*n+k+1) * 2;
                end
            end
        end
    end
    
    
end