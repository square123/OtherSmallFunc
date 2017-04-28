clear;%该脚本考虑的是单人的算法，如果要考虑多人的脚本，则需要对kdata{2}进行分析,
%除此之外，在系统中，如果未打开WiFi开关，则也无法匹配到相应的Mac地址，甚至有可能会出现意外的情况，即匹配错误，如果匹配错误就很尴尬了，就将错误一直延续下去
%因为从系统来看，我们是无法知道它是否打开WiFi开关了
clc;
kincetName=fopen('H:\MAC地址采集\双人测试数据\test\1.csv');
probeName=fopen('H:\MAC地址采集\双人测试数据\test\probeGet.csv');
kdata=textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');
pdata=textscan(probeName,'%s %s %d %d %d %d','delimiter', ',');
%获得多个Mac地址序列
temp=pdata{:,2};
%其存储的格式期望是这样的：将每个Mac码的索引找到，将索引存下来
%mac1   mac2    ……
%1      5
%2      6
%3      7
%9      8
%10     0
utemp=unique(temp);%找到最多的函数，要对之前的程序进行一下优化
maxNum=0;
for i=1:length(utemp)%找到最大值
    if(length(find(strcmp(pdata{:,2},utemp(i))))>=maxNum)
        maxNum=length(find(strcmp(pdata{:,2},utemp(i))));
    end
end
indexData=zeros(maxNum,length(utemp));%想办法存储索引，其长度是变长的
for i=1:length(utemp)
    lin=zeros(1,maxNum-length(find(strcmp(pdata{:,2},utemp(i)))));
     indexData(:,i)=[find(strcmp(pdata{:,2},utemp(i)));lin'];
end
kdataTime=[];%得到输出时间
pdataTime=[];
for i=1:length(kdata{1,1})
    kdataTime=[kdataTime; str2double(kdata{1,1}{i})];
end
for i=1:length(pdata{1,1})
    pdataTime=[pdataTime;str2double(pdata{1,1}{i})];
end
%最终输出格式是 两列表，分数，长度->权值,索引对应Mac地址
output=zeros(length(utemp),2);
%开始查找
for k=1:length(utemp)%遍历索引
    %建立索引
    outputRSSITime=pdataTime(indexData(1:length(find(indexData(:,k))),k));%存储的时间
    outputRSSI1=pdata{3}(indexData(1:length(find(indexData(:,k))),k));%存储的RSSI1信息
    outputRSSI2=pdata{4}(indexData(1:length(find(indexData(:,k))),k));%存储的RSSI2信息
    outputRSSI3=pdata{5}(indexData(1:length(find(indexData(:,k))),k));%存储的RSSI3信息
    outputRSSI4=pdata{6}(indexData(1:length(find(indexData(:,k))),k));%存储的RSSI4信息
    %以上找到了对应某Mac下的时间和RSSI对应表
    %以下要找对应Mac的Kinect信息
    outputkinectTime=[];
    outputkinect1=[];
    outputkinect2=[];
    outputkinect3=[];
    outputkinect4=[];
    for i=1:length(find(indexData(:,k)))%遍历的是探针
        for j=1:length(kdata{1})%遍历的是kinect
            if(kdataTime(j)>outputRSSITime(i))%可以先不找相等的值，先找大于该值的值，
                if(j-1>0)
                    if(kdataTime(j-1)==outputRSSITime(i))
                        outputkinectTime=[outputkinectTime;outputRSSITime(i)];
                        outputkinect1=[outputkinect1;kdata{3}(j-1)];
                        outputkinect2=[outputkinect2;kdata{4}(j-1)];
                        outputkinect3=[outputkinect3;kdata{5}(j-1)];
                        outputkinect4=[outputkinect4;kdata{6}(j-1)];
                        break;
                    else  %要找到时间相近的距离的均值，而且要有时间距离的权值，不能是简单平均
                        d1=kdataTime(j)-outputRSSITime(i);
                        d2=outputRSSITime(i)-kdataTime(j-1);
                        rd1=d1/(d1+d2);
                        rd2=d2/(d1+d2);
                        outputkinectTime=[outputkinectTime;outputRSSITime(i)];
                        outputkinect1=[outputkinect1;rd1*kdata{3}(j)+rd2*kdata{3}(j-1)];
                        outputkinect2=[outputkinect2;rd1*kdata{4}(j)+rd2*kdata{4}(j-1)];
                        outputkinect3=[outputkinect3;rd1*kdata{5}(j)+rd2*kdata{5}(j-1)];
                        outputkinect4=[outputkinect4;rd1*kdata{6}(j)+rd2*kdata{6}(j-1)];
                        break;
                    end
                else
                    outputkinectTime=[outputkinectTime;outputRSSITime(i)];
                        outputkinect1=[outputkinect1;kdata{3}(j)];
                        outputkinect2=[outputkinect2;kdata{4}(j)];
                        outputkinect3=[outputkinect3;kdata{5}(j)];
                        outputkinect4=[outputkinect4;kdata{6}(j)];
                    break;
                end
            end
        end
    end
    %以上找到和Mac地址匹配的对应对，但可能会存在数据没有对齐的情况
    t1=length(outputkinectTime);
    t2=length(outputRSSITime);
    if(t1~=t2)%将后面没有的数据置空
    outputRSSITime(t1+1:t2)=[];
    outputRSSI1(t1+1:t2)=[];
    outputRSSI2(t1+1:t2)=[];
    outputRSSI3(t1+1:t2)=[];
    outputRSSI4(t1+1:t2)=[];
    end
    %以上完成了数据的对齐下面要开始真正的算法权值计算
    %数据转换框架 满分为100分
    %将数据的间隔转换成四个序列，每个序列分别计算，得到相关的距离标识-1 0 1，其中要通过阈值来进行判断是否是保持不变
    %要输出的序列（因为调用各种标号太繁琐了，这里想再写入一个函数）
    [score,num,x,y]=CompareKR(outputRSSI1,outputRSSI2,outputRSSI3,outputRSSI4,outputkinect1,outputkinect2,outputkinect3,outputkinect4);
    %以上得出了数据的输出形式，下面开始数据的的权值输出
    output(k,1)=score;
    output(k,2)=num;
end
%以上得到了单人的Mac地址，对应的数据表，下面是对数据再进行考究
maxs=max(output(:,2));
a=pi/maxs;
weight=0.5-0.5*cos(a*output(:,2));
optoutput=output(:,1).*weight;
[ss,ii]=max(optoutput);
disp('最终匹配到的MAC地址：')
utemp{ii}
disp('分数：')
ss
