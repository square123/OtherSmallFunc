clear;
clc;
kincetName='I:\wifiProject\location\location\location\kinectdata.csv';
probeName='I:\wifiProject\location\location\location\probeGet.csv';
[kdata1,kdata2,kdata3,kdata4,kdata5,kdata6]=textread(kincetName,'%s%d%f%f%f%f','delimiter', ',');
[pdata1,pdata2,pdata3,pdata4,pdata5,pdata6]=textread(probeName,'%s%s%d%d%d%d','delimiter', ',');
%关于数据不整齐的以后再考虑

% sel=[size(pdata1,1),size(pdata2,1),size(pdata3,1),size(pdata4,1),size(pdata5,1),size(pdata6,1)];
% len=max(sel);
len=size(pdata2,1);
%剔除不相关元素，只保留了该MAC码的数组
for i=len:-1:1
    if(~strcmp(pdata2{i},'F0:25:B7:C1:07:97'))
        pdata1(i)=[];
        pdata2(i)=[];
        pdata3(i)=[];
        pdata4(i)=[];
        pdata5(i)=[];
        pdata6(i)=[];
    end
end
len=size(pdata2,1);
llen=size(kdata1,1);
tempstr='';%储存相同时间的
r1=[];
r2=[];
r3=[];
r4=[];
kkdata1=[];
kkdata2=[];
kkdata3=[];
kkdata4=[];
kkdata5=[];
for k=1:llen
    if(strcmp(kdata1{k},tempstr))
        r1=[r1 kdata3(k)];
        r2=[r2 kdata4(k)];
        r3=[r3 kdata5(k)];
        r4=[r4 kdata6(k)];
    elseif((~strcmp(kdata1{k},tempstr))&&(~strcmp(tempstr,'')))
        r1=mean(r1);
        r2=mean(r2);
        r3=mean(r3);
        r4=mean(r4);
        kkdata1=[kkdata1;tempstr];
        kkdata2=[kkdata2;r1];
        kkdata3=[kkdata3;r2];
        kkdata4=[kkdata4;r3];
        kkdata5=[kkdata5;r4];
        tempstr=kdata1{k};
        r1=[];
        r2=[];
        r3=[];
        r4=[];
    elseif(strcmp(tempstr,''))
        tempstr=kdata1{k};
        r1=[r1 kdata3(k)];
        r2=[r2 kdata4(k)];
        r3=[r3 kdata5(k)];
        r4=[r4 kdata6(k)];
    end
end
llen=size(kkdata1,1);
outputkinect=[];
for i=1:len
    for j=1:llen
       if(strcmp(kdata1{j},pdata1{i}))
           
       end
    end
end
