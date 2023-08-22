function output = myfft8(realPart, imgPart)
    function LUTr = genLUTr(k)
        if mod(k, 2) == 0
            LUTr = zeros(16, 1);
            fil = zeros(4, 1);
        else
            LUTr = zeros(64, 1);
            fil = zeros(6, 1);
        end
        index = 1;
        for m = 0:3
            if abs(cos(m * k * pi / 4)) < 0.001
                continue
            end
            fil(index) = cos(m * k * pi / 4);
            index = index + 1;
        end
        for m = 0:3
            if abs(sin(m * k * pi / 4)) < 0.001
                continue
            end
            fil(index) = sin(m * k * pi / 4);
            index = index + 1;
        end
        if mod(k, 2) == 0
            for m = 0:15
               LUTr(m + 1) = sum(str2num(dec2bin(m,4)') .* fil);
            end
        else
            for m = 0:63
               LUTr(m + 1) = sum(str2num(dec2bin(m,6)') .* fil);
            end
        end
    end
    function LUTi = genLUTi(k)
        if mod(k, 2) == 0
            LUTi = zeros(16, 1);
            fil = zeros(4, 1);
        else
            LUTi = zeros(64, 1);
            fil = zeros(6, 1);
        end
        index = 1;
        for m = 0:3
            if abs(sin(m * k * pi / 4)) < 0.001
                continue
            end
            fil(index) = -sin(m * k * pi / 4);
            index = index + 1;
        end
        for m = 0:3
            if abs(cos(m * k * pi / 4)) < 0.001
                continue
            end
            fil(index) = cos(m * k * pi / 4);
            index = index + 1;
        end
        if mod(k, 2) == 0
            for m = 0:15
               LUTi(m + 1) = sum(str2num(dec2bin(m,4)') .* fil);
            end
        else
            for m = 0:63
               LUTi(m + 1) = sum(str2num(dec2bin(m,6)') .* fil);
            end
        end
    end
try load LUTrs.mat;
catch
    LUTrs = zeros(64, 8);
    for k = 0:7
        if mod(k, 2) == 0
            LUTrs(1:16, k + 1) = genLUTr(k);
        else
            LUTrs(:, k + 1) = genLUTr(k);
        end
    end
    save LUTrs.mat LUTrs;
end
try load LUTis.mat;
catch
    LUTis = zeros(64, 8);
    for k = 0:7
        if mod(k, 2) == 0
            LUTis(1:16, k + 1) = genLUTi(k);
        else
            LUTis(:, k + 1) = genLUTi(k);
        end
    end
    save LUTis.mat LUTis;
end
    function fr = calcr(k)
        fr = 0;
    if mod(k, 2) == 1
        qualifiedData1 = cat(1, realPart(1:2,:), realPart(4,:), imgPart(2:4,:));
        qualifiedData2 = cat(1, realPart(5:6,:), realPart(8,:), imgPart(6:8,:));
    elseif mod(k, 4) == 0
        qualifiedData1 = realPart(1:4,:);
        qualifiedData2 = realPart(5:8,:);
    elseif mod(k, 4) == 2
        qualifiedData1 = cat(1, realPart(1,:), realPart(3,:), imgPart(2,:), imgPart(4,:));
        qualifiedData2 = cat(1, realPart(5,:), realPart(7,:), imgPart(6,:), imgPart(8,:));
    end
    for t = 1:16
        index1 = bin2dec(qualifiedData1(:,t)');
        index2 = bin2dec(qualifiedData2(:,t)');
        fr = fr + LUTrs(index1 + 1, k + 1) + (-1)^k * LUTrs(index2 + 1, k + 1);
        if t == 1
            fr = fr * (-2);
        elseif t == 16
            break;
        else
            fr = fr * 2;
        end
    end
    end
    function fi = calci(k)
        fi = 0;
    if mod(k, 2) == 1
        qualifiedData1 = cat(1, realPart(2:4,:), imgPart(1:2,:), imgPart(4,:));
        qualifiedData2 = cat(1, realPart(6:8,:), imgPart(5:6,:), imgPart(8,:));
    elseif mod(k, 4) == 0
        qualifiedData1 = imgPart(1:4,:);
        qualifiedData2 = imgPart(5:8,:);
    elseif mod(k, 4) == 2
        qualifiedData1 = cat(1, realPart(2,:), realPart(4,:), imgPart(1,:), imgPart(3,:));
        qualifiedData2 = cat(1, realPart(6,:), realPart(8,:), imgPart(5,:), imgPart(7,:));
    end
    for t = 1:16
        index1 = bin2dec(qualifiedData1(:,t)');
        index2 = bin2dec(qualifiedData2(:,t)');
        fi = fi + LUTis(index1 + 1, k + 1) + (-1)^k * LUTis(index2 + 1, k + 1);
        if t == 1
            fi = fi * (-2);
        elseif t == 16
            break;
        else
            fi = fi * 2;
        end
    end
    end
output = zeros(8, 1);
for k = 0:7
    output(k + 1) = calcr(k) + 1i * calci(k);
end
end