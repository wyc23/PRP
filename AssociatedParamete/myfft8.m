function [outputr, outputi] = myfft8(realPart, imgPart, LUTrs_1, LUTis_1, N)
        realPartkEven = zeros(4, 1);
        realPartkOdd = zeros(4, 1);
        imgPartkEven = zeros(4, 1);
        imgPartkOdd = zeros(4, 1);
        for m = 1:4
            realPartkEven(m) = realPart(m) + realPart(m + 4);
            realPartkOdd(m) = realPart(m) - realPart(m + 4);
            imgPartkEven(m) = imgPart(m) + imgPart(m + 4);
            imgPartkOdd(m) = imgPart(m) - imgPart(m + 4);
        end
        mixData = fi([realPartkEven, realPartkOdd, imgPartkEven, imgPartkOdd], 1, N);
        realPartkEven = mixData(:,1);
        realPartkOdd = mixData(:,2);
        imgPartkEven = mixData(:,3);
        imgPartkOdd = mixData(:,4);
        function fr = calcr(k)
            fr = 0;
        if mod(k, 2) == 1
            qualifiedData = cat(1, realPartkOdd.bin(1:2,:), realPartkOdd.bin(4,:), imgPartkOdd.bin(2:4,:));
            % qualifiedData1 = cat(1, realPart.bin(1:2,:), realPart.bin(4,:), imgPart.bin(2:4,:));
            % qualifiedData2 = cat(1, realPart.bin(5:6,:), realPart.bin(8,:), imgPart.bin(6:8,:));
        elseif mod(k, 4) == 0
            qualifiedData = realPartkEven.bin(1:4,:);
            % qualifiedData1 = realPart.bin(1:4,:);
            % qualifiedData2 = realPart.bin(5:8,:);
        elseif mod(k, 4) == 2
            qualifiedData = cat(1, realPartkEven.bin(1,:), realPartkEven.bin(3,:), imgPartkEven.bin(2,:), imgPartkEven.bin(4,:));
            % qualifiedData1 = cat(1, realPart.bin(1,:), realPart.bin(3,:), imgPart.bin(2,:), imgPart.bin(4,:));
            % qualifiedData2 = cat(1, realPart.bin(5,:), realPart.bin(7,:), imgPart.bin(6,:), imgPart.bin(8,:));
        end
        for t = 1:N
            index = bin2dec(qualifiedData(:,t)');
            % index1 = bin2dec(qualifiedData1(:,t)');
            % index2 = bin2dec(qualifiedData2(:,t)');
            fr = fr + LUTrs_1(index + 1, k + 1) * 2 ^ -realPartkEven.FractionLength;
            % fr = fr + (LUTrs_1(index1 + 1, k + 1) + (-1)^k * LUTrs_1(index2 + 1, k + 1)) * 2 ^ -realPart.FractionLength;
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
            qualifiedData = cat(1, realPartkOdd.bin(2:4,:), imgPartkOdd.bin(1:2,:), imgPartkOdd.bin(4,:));
            % qualifiedData1 = cat(1, realPart.bin(2:4,:), imgPart.bin(1:2,:), imgPart.bin(4,:));
            % qualifiedData2 = cat(1, realPart.bin(6:8,:), imgPart.bin(5:6,:), imgPart.bin(8,:));
        elseif mod(k, 4) == 0
            qualifiedData = imgPartkEven.bin(1:4,:);
            % qualifiedData1 = imgPart.bin(1:4,:);
            % qualifiedData2 = imgPart.bin(5:8,:);
        elseif mod(k, 4) == 2
            qualifiedData = cat(1, realPartkEven.bin(2,:), realPartkEven.bin(4,:), imgPartkEven.bin(1,:), imgPartkEven.bin(3,:));
            % qualifiedData1 = cat(1, realPart.bin(2,:), realPart.bin(4,:), imgPart.bin(1,:), imgPart.bin(3,:));
            % qualifiedData2 = cat(1, realPart.bin(6,:), realPart.bin(8,:), imgPart.bin(5,:), imgPart.bin(7,:));
        end
        for t = 1:N
            index1 = bin2dec(qualifiedData(:,t)');
            % index1 = bin2dec(qualifiedData1(:,t)');
            % index2 = bin2dec(qualifiedData2(:,t)');
            f_i = f_i + LUTis_1(index1 + 1, k + 1) * 2 ^ -imgPartkEven.FractionLength;
            % f_i = f_i + (LUTis_1(index1 + 1, k + 1) + (-1)^k * LUTis_1(index2 + 1, k + 1)) * 2 ^ -imgPart.FractionLength;
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