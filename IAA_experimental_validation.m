%%%%%%%%%Import Experimental data 
load('..\Data\2Hz_encoder_xy.mat')
fault_type='outer';
fs=102400;T=60;
addpath('..\');
addpath('..\KLPD\');
%%%%%%%%%%%% Convert into phase %%%%
eval([fault_type,'_phase=BiChannels2Phase(',fault_type,');'])

%%%%%%%%%%%% IAA %%%%%%%%%%%%%%
iaa=eval(['IAA(',fault_type,'_phase,fs)']);
Draw(iaa,fs);
v=LPD(eval([fault_type,'_phase']),17,fs)/5000;
[f_c,f_p_s,f_i,f_o,f_cg,f_b,f_m,f_sf,f_pf,f_rf] = CharacteristicFreq(mean(abs(v)),36,35,108,3,0.0035,0.0195,10);% calculate the characteristic frequencies
iaa_env=envelope(iaa);% use envelope instead of iaa itself
%%%%%%%%%%Time synchronous averaging
if strcmp(fault_type,'outer') 
    tp=0:3/f_o:T;
elseif strcmp(fault_type,'inner')
    tp=0:3/f_i:T;
else
    tp=0:3/f_b:T;
end
ta=tsa(iaa,fs,tp);
t0=linspace(0,tp(2)-tp(1),length(ta));
figure('Name','time synchronous averaging');
plot(t0,ta);
xlim([0 1]);

%%%%%%%%%%%%%%%%%%%%%%% down sample the envelope signal before bandwidth optimization
ta_resample=resample(ta,10240,fs);
t0=resample(t0,10240,fs);
fs=10240;T=60;
t=0:1/fs:T-1/fs;
%%%%%%%%%% use the Gini index to find the optimal bandwidth of lowpass filter for IAA signal
upper_options=linspace(0.01,0.7,100);
[gini,cut_off]=bandwidth_optimize(ta_resample,upper_options);
figure('Name','Bandwidth optimization');
plot(upper_options,gini);
xlim([0 0.7]);xlabel('Bandwidth / (0.5 \times sampling frequency)');
ylabel('Gini index');
SetFigureProperties;
figure('Name','Filtered signal')
b=fir1(128,cut_off);
filtered_ta=filter(b,1,ta_resample);
plot(t0(round(end/10):end)-t0(round((end/10))),filtered_ta(round(end/10):end)/fs);% omit the first little snippet of signal
% plot(t0,filtered_ta);
xlim([0 max(t0)]);
xlabel('Time [s]');ylabel('IAA [rev/s^2]');
SetFigureProperties;