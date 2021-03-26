fs=1000;T=2000;
t=0:1/fs:T-1/fs;
sig=simulated_signal(fs,T);
plot(t,sig);xlim([0,1]);
figure;
iaa=IAA(sig,fs);
plot(t,iaa/360);xlim([0 1]);
tp=0:7*0.2:T;
ta=tsa(iaa,fs,tp);
t0=linspace(0,tp(2)-tp(1),length(ta));
plot(t0,ta);
xlim([0 1]);
%% test the fdm
% iaa2=diff(sig,2)*fs*fs;
% plot(t(2:end-1),iaa2);
% xlim([0 1]);
%% bandwidth optimization
upper_options=linspace(0.01,0.7,100);
[gini,cut_off]=bandwidth_optimize(ta,upper_options);
figure('Name','Bandwidth optimization');
plot(upper_options*fs/2,gini);
xlim([0 0.3]*fs/2);ylim([0.4 0.6]);hold on;plot(cut_off*fs/2,max(gini),'ro');
text(cut_off,max(gini),[num2str(cut_off),' , ',num2str(max(gini))]);
xlabel('Cut off frequency [Hz]');ylabel('Gini index');
SetFigureProperties;
figure('Name','Filtered signal')
b=fir1(128,cut_off);
filtered_ta=filter(b,1,ta);
plot(t0(250:end)-t0(250),filtered_ta(250:end)/4/pi^2);
xlim([0 1]);ylim('auto');
xlabel('Time [s]');ylabel('IAA [rev/s^2]')
SetFigureProperties;
set(gcf,'Units','centimeters','Position',[6 6 16 6]);%12»ò8