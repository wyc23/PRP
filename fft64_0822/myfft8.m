function [outputr, outputi] = myfft8(inputr, inputi, fft8LUTr, fft8LUTi, N, w, factor_fft8)
    inputrkEven = zeros(4, 1);
    inputrkOdd = zeros(4, 1);
    inputikEven = zeros(4, 1);
    inputikOdd = zeros(4, 1);
    for m = 1:4
        inputrkEven(m) = inputr(m) + inputr(m + 4);
        inputrkOdd(m) = inputr(m) - inputr(m + 4);
        inputikEven(m) = inputi(m) + inputi(m + 4);
        inputikOdd(m) = inputi(m) - inputi(m + 4);
    end
    mixData = fi([inputrkEven, inputrkOdd, inputikEven, inputikOdd], 1, N);
    inputrkEven = mixData(:,1);
    inputrkOdd = mixData(:,2);
    inputikEven = mixData(:,3);
    inputikOdd = mixData(:,4);
    function fr = calcr(k)
        fr = 0;
    if mod(k, 2) == 1
        qualifiedData = cat(1, inputrkOdd.bin(1:2,:), inputrkOdd.bin(4,:), inputikOdd.bin(2:4,:));
        % qualifiedData1 = cat(1, inputr.bin(1:2,:), inputr.bin(4,:), inputi.bin(2:4,:));
        % qualifiedData2 = cat(1, inputr.bin(5:6,:), inputr.bin(8,:), inputi.bin(6:8,:));
    elseif mod(k, 4) == 0
        qualifiedData = inputrkEven.bin(1:4,:);
        % qualifiedData1 = inputr.bin(1:4,:);
        % qualifiedData2 = inputr.bin(5:8,:);
    elseif mod(k, 4) == 2
        qualifiedData = cat(1, inputrkEven.bin(1,:), inputrkEven.bin(3,:), inputikEven.bin(2,:), inputikEven.bin(4,:));
        % qualifiedData1 = cat(1, inputr.bin(1,:), inputr.bin(3,:), inputi.bin(2,:), inputi.bin(4,:));
        % qualifiedData2 = cat(1, inputr.bin(5,:), inputr.bin(7,:), inputi.bin(6,:), inputi.bin(8,:));
    end
    for t = 1:N
        index = bin2dec(qualifiedData(:,t)');
        % index1 = bin2dec(qualifiedData1(:,t)');
        % index2 = bin2dec(qualifiedData2(:,t)');
        fr = fr + fft8LUTr(index + 1, k + 1) * 2 ^ -inputrkEven.FractionLength;
        if (w > 0)
            fr = double(fi(fr, 1, w));
        end
        % fr = fr + (fft8LUTr(index1 + 1, k + 1) + (-1)^k * fft8LUTr(index2 + 1, k + 1)) * 2 ^ -inputr.FractionLength;
        if t == 1
            fr = fr * (-2);
            if (w > 0)
                fr = double(fi(fr, 1, w));
            end
        elseif t == N
            break;
        else
            fr = fr * 2;
            if (w > 0)
                fr = double(fi(fr, 1, w));
            end
        end
    end
    end
    function f_i = calci(k)
        f_i = 0;
    if mod(k, 2) == 1
        qualifiedData = cat(1, inputrkOdd.bin(2:4,:), inputikOdd.bin(1:2,:), inputikOdd.bin(4,:));
        % qualifiedData1 = cat(1, inputr.bin(2:4,:), inputi.bin(1:2,:), inputi.bin(4,:));
        % qualifiedData2 = cat(1, inputr.bin(6:8,:), inputi.bin(5:6,:), inputi.bin(8,:));
    elseif mod(k, 4) == 0
        qualifiedData = inputikEven.bin(1:4,:);
        % qualifiedData1 = inputi.bin(1:4,:);
        % qualifiedData2 = inputi.bin(5:8,:);
    elseif mod(k, 4) == 2
        qualifiedData = cat(1, inputrkEven.bin(2,:), inputrkEven.bin(4,:), inputikEven.bin(1,:), inputikEven.bin(3,:));
        % qualifiedData1 = cat(1, inputr.bin(2,:), inputr.bin(4,:), inputi.bin(1,:), inputi.bin(3,:));
        % qualifiedData2 = cat(1, inputr.bin(6,:), inputr.bin(8,:), inputi.bin(5,:), inputi.bin(7,:));
    end
    for t = 1:N
        index1 = bin2dec(qualifiedData(:,t)');
        % index1 = bin2dec(qualifiedData1(:,t)');
        % index2 = bin2dec(qualifiedData2(:,t)');
        f_i = f_i + fft8LUTi(index1 + 1, k + 1) * 2 ^ -inputikEven.FractionLength;
        if (w > 0)
            f_i = double(fi(f_i, 1, w));
        end
        % f_i = f_i + (fft8LUTi(index1 + 1, k + 1) + (-1)^k * fft8LUTi(index2 + 1, k + 1)) * 2 ^ -inputi.FractionLength;
        if t == 1
            f_i = f_i * (-2);
            if (w > 0)
                f_i = double(fi(f_i, 1, w));
            end
        elseif t == N
            break;
        else
            f_i = f_i * 2;
            if (w > 0)
                f_i = double(fi(f_i, 1, w));
            end
        end
    end
    end
outputr = zeros(8, 1);
outputi = zeros(8, 1);
for k = 0:7
    outputr(k + 1) = calcr(k);
    outputi(k + 1) = calci(k);
end
outputr = outputr ./ factor_fft8;
outputi = outputi ./ factor_fft8;
end