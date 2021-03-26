function index=Gini_index(x)
% Copyright@ vastera@163.com
% General introduction:Calculate the Gini index (originated from economics to quantify the inequality among people's income)
%% ====================== INPUT ========================
% x:          Type:vector
%                           x description: the input to be calculated
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% index:          Type:a double
%                           index description:The output Gini index
%% =====================================================
%% Sort x in ascent order
x=sort(abs(x),'ascend');
if iscolumn(x)
    x=x';
end
%%% calculate the gini index
len=length(x);
norm1=norm(x,1);
index=1-2/norm1/len*x*(len-(1:len)+0.5)';
end