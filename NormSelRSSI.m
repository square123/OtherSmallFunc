function [ output ] = NormSelRSSI( input )
%�������׵ķ��������ݽ�����ѡ
%  ���õ��˸�˹ģ�͵ķ���
Temp=input;
n=length(input);
Temp_mu=mean(Temp);
Temp_sigma=std(Temp);
for i=1:n
%     normcdf(Temp(i),Temp_mu,Temp_sigma)
    if(normcdf(Temp(i),Temp_mu,Temp_sigma)<0.5)
        Temp(i)=0;
    end
end
Temp(Temp==0)=[];
output=mean(Temp);
end

