function sig_noisy=simulated_signal(fs,T)
% Copyright@ vastera@163.com
% General introduction:generate signal described in Zhaoming' paper health assessment of rotating machinery using a rotary encoder
%% ====================== INPUT ========================
% fs:                        Type: integer
%                              description: sampling frequency
% T:                         Type: integer
%                                description: total samling time duration
%% ====================== OUTPUT =======================
% sig:          Type:vector
%                           sig description:the generated signal
%% =====================================================
%%%%%% Initilization of parameters %%%%%%%%%%%%%%%%%%
t=0:1/fs:T-1/fs;
T0=0.2;
v0=300;% 300rpm 5Hz.
A=0.05;% fault amplitude
w=0.002;% fault impulsive duration
f_dr=36; %drive harmonics frequency
B1=0.2;beta1=pi/3;B2=0.1;beta2=-pi/6; 
%%%%%% G(t) part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(size(t));
i=1;
while i*T0<=max(t)
    g=g-A*exp(-((t-i*T0+T0/2)/2/w).^2);
    i=i+1;
end
%%%%%% Drive or load part %%%%%%%%%%%%%%%%%%%%%%%%%%%
x_dr=B1*sin(2*pi*f_dr*t-beta1)+B2*sin(2*pi*2*f_dr*t-beta2);% drive or load part
%%%%%% Add Noise part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sig=2*pi*v0*t+g+x_dr;
sig=2*pi*v0*t+g+x_dr;
sig_noisy=awgn(sig,10);
end