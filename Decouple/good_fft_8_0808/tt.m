[lutr, luti] = finalLUT();
xr = rand(8,1);
xi = rand(8,1);
[or,oi] = myfft8(xr,xi,lutr,luti,18);
o = fft(xr+ 1i * xi);
oor = real(o);
ooi = imag(o);