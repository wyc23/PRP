function [outputr, outputi] = myfft8(realPart, imgPart, LUTrs_1, LUTis_1, N)
        function fr = calcr(k)
            fr = 0;
        if mod(k, 2) == 1
            qualifiedData1 = cat(1, realPart.bin(1:2,:), realPart.bin(4,:), imgPart.bin(2:4,:));
            qualifiedData2 = cat(1, realPart.bin(5:6,:), realPart.bin(8,:), imgPart.bin(6:8,:));
        elseif mod(k, 4) == 0
            qualifiedData1 = realPart.bin(1:4,:);
            qualifiedData2 = realPart.bin(5:8,:);
        elseif mod(k, 4) == 2
            qualifiedData1 = cat(1, realPart.bin(1,:), realPart.bin(3,:), imgPart.bin(2,:), imgPart.bin(4,:));
            qualifiedData2 = cat(1, realPart.bin(5,:), realPart.bin(7,:), imgPart.bin(6,:), imgPart.bin(8,:));
        end
        for t = 1:N
            index1 = bin2dec(qualifiedData1(:,t)');
            index2 = bin2dec(qualifiedData2(:,t)');
            fr = fr + (LUTrs_1(index1 + 1, k + 1) + (-1)^k * LUTrs_1(index2 + 1, k + 1)) * 2 ^ -realPart.FractionLength;
            if t == 1
                fr = fr * (-2);
            elseif t == N
                break;
            else
                fr = fr * 2;
            end
        end
        end
        function f_i = calci(k)
            f_i = 0;
        if mod(k, 2) == 1
            qualifiedData1 = cat(1, realPart.bin(2:4,:), imgPart.bin(1:2,:), imgPart.bin(4,:));
            qualifiedData2 = cat(1, realPart.bin(6:8,:), imgPart.bin(5:6,:), imgPart.bin(8,:));
        elseif mod(k, 4) == 0
            qualifiedData1 = imgPart.bin(1:4,:);
            qualifiedData2 = imgPart.bin(5:8,:);
        elseif mod(k, 4) == 2
            qualifiedData1 = cat(1, realPart.bin(2,:), realPart.bin(4,:), imgPart.bin(1,:), imgPart.bin(3,:));
            qualifiedData2 = cat(1, realPart.bin(6,:), realPart.bin(8,:), imgPart.bin(5,:), imgPart.bin(7,:));
        end
        for t = 1:N
            index1 = bin2dec(qualifiedData1(:,t)');
            index2 = bin2dec(qualifiedData2(:,t)');
            f_i = f_i + (LUTis_1(index1 + 1, k + 1) + (-1)^k * LUTis_1(index2 + 1, k + 1)) * 2 ^ -imgPart.FractionLength;
            if t == 1
                f_i = f_i * (-2);
            elseif t == N
                break;
            else
                f_i = f_i * 2;
            end
        end
        end
    outputr = zeros(8, 1);
    outputi = zeros(8, 1);
    for k = 0:7
        outputr(k + 1) = calcr(k);
        outputi(k + 1) = calci(k);
    end
end