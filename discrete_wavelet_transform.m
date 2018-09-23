
function [App,Det] = discrete_wavelet_transform(f)
[App,Det] = dwt(f,'sym4');