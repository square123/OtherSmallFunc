function [ output ] = selRSSI(input)
%ȥ��ǰ��ٷ�֮�������Ȼ��ѡȡ���ֵ
Temp=sort(input);
n=length(input);
deNum=ceil(n*0.05);
Temp(1:1+deNum)=-100;
Temp(n-deNum:n)=-100;
output=max(Temp);
end

