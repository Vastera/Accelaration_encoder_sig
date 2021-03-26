function [gini,cut_off]=bandwidth_optimize(sig,upper_options)
% Copyright@ vastera@163.com
% General introduction:Optimize the input signal by chosing the cut off frequency of filter according the Gini index
%% ====================== INPUT ========================
% sig:          Type:vector
%                           sig description:input sig
% upper_options   Types vector within 0<upper_options<1
%                           upper_options description: the upper bound
%                           options for filter band % Range of cutoff frequencies
%% ====================== OUTPUT =======================
% filtered_sig:     Type: vector
%                    filtered_sig description: the filtered signal
%
% cut_off:          Type: a double
%                           cut_off description: the optimal cut off frequency
%% =====================================================
gini=zeros(size(upper_options));% Initialize gini index
i=1;
h_wait= waitbar(0,'Optimazing bandwidth...');
for upper_bound = upper_options
    waitbar(i/length(upper_options),h_wait,'Optimazing bandwidth...');
    b=fir1(128,upper_bound);
    filtered_sig0=filtfilt(b,1,sig);
    gini(i)=Gini_index(filtered_sig0(round(end/10):end));
% gini(i)=Gini_index(filtered_sig0);
    i=i+1;
end
close(h_wait);
[~,index]=max(gini);
cut_off=upper_options(index);
end