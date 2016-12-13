function [ output ] = NormSelRSSI( input )
%利用文献的方法对数据进行优选
%  采用到了高斯模型的方法
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

