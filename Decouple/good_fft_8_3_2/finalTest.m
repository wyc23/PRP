RMSE = zeros(33, 33);
n_out =16;
for n_lut = 4:36
    for n_in = 4:36
        [lutr, luti] = finalLUT();
        factor = max(lutr(:));
        lutr = fi(lutr .* factor, 1, n_lut, "RoundingMethod", "Floor");
        luti = fi(luti .* factor, 1, n_lut, "RoundingMethod", "Floor");
        xxr = rand(8, 200) - 0.5;
        xxi = rand(8, 200) - 0.5;
        xr = fi(xxr, 1, n_in, n_in);
        xi = fi(xxi, 1, n_in, n_in);
        x_double = complex(xxr,xxi);
%         fxr = fi(zeros(8, 200), 1, n_out, n_out-4);
%         fxi = fi(zeros(8, 200), 1, n_out, n_out-4);
        fxr = zeros(8, 200);
        fxi = zeros(8, 200);
        f = zeros(8, 200);
        parfor k = 1:200
            [fxr(:, k), fxi(:, k)] = myfft8(xr(:, k), xi(:, k), lutr, luti, n_in, n_out);
            f(:, k) = fft(x_double(:, k));
        end
        fxr = fi(fxr, 1, n_out);
        fxi = fi(fxi, 1, n_out);
        fx = complex(double(fxr), double(fxi)) ./ factor;
        RMSE(n_lut-3, n_in-3) = sqrt(mean(abs(f - fx).^2, "all"));  
        indicator = [n_lut, n_in];
        disp(indicator);
    end
end