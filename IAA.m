function iaa=IAA(phi,fs)
% Copyright@ vastera@163.com
% General introduction:Convert the instantaneous phase into instantaneous angular acceleartion
%% ====================== INPUT ========================
% phi:          Type:vector
%                           phi description:instantaneous phases to be converted
% fs:           Type:integer
%                            fs description: sampling frequency
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% iaa:           Type:vector with the same length of phi
%                           iaa description: instantaneous angular acceleration after conversion
%% =====================================================
if iscolumn(phi)
    phi=phi';
end
amp=fft(detrend(phi));
T=length(phi)/fs;
f=0:1/T:fs-1/T;
A=-4*pi^2*f.^2.*amp;
iaa=ifft(A,'symmetric');
end