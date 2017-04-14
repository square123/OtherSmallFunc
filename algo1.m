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

llen=size(kdata1,1);%对kinect值进行压缩
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
        r1=[r1 kdata3(k)];
        r2=[r2 kdata4(k)];
        r3=[r3 kdata5(k)];
        r4=[r4 kdata6(k)];
    elseif(strcmp(tempstr,''))
        tempstr=kdata1{k};
        r1=[r1 kdata3(k)];
        r2=[r2 kdata4(k)];
        r3=[r3 kdata5(k)];
        r4=[r4 kdata6(k)];
    end
end
        r1=mean(r1);
        r2=mean(r2);
        r3=mean(r3);
        r4=mean(r4);
        kkdata1=[kkdata1;tempstr];
        kkdata2=[kkdata2;r1];
        kkdata3=[kkdata3;r2];
        kkdata4=[kkdata4;r3];
        kkdata5=[kkdata5;r4];
%通过以上程序已经可以完成时间的合并
%但以后在存入数据时，应该在输出数据时就完成同时刻的编写，可以参考自己之前再探针中使用的方法，或者可以考虑加入Kalaman算法，只要时间不拖即可，或者考虑下卡尔曼滤波是否适合不连续的轨迹？
len=size(pdata2,1);
llen=size(kkdata1,1);
%需要输出对应rssi时刻的kinect结点
%将字符转换成数字
kkdata1=str2num(kkdata1);
ppdata1=[];
for i=1:len
    ppdata1=[ppdata1;str2num(pdata1{i})];
end
outputkinect1=[];
outputkinect2=[];
outputkinect3=[];
outputkinect4=[];
outputkinect5=[];
for i=1:len%遍历的是探针
    for j=1:llen%遍历的是kinect
        if(kkdata1(j)>ppdata1(i))%可以先不找相等的值，先找大于该值的值，
            if(j-1>0)
                if(kkdata1(j-1)==ppdata1(i))
                    outputkinect1=[outputkinect1;kkdata1(j-1)];
                    outputkinect2=[outputkinect2;kkdata2(j-1)];
                    outputkinect3=[outputkinect3;kkdata3(j-1)];
                    outputkinect4=[outputkinect4;kkdata4(j-1)];
                    outputkinect5=[outputkinect5;kkdata5(j-1)];
                    break;
                else  %要找到时间相近的距离的均值，而且要有时间距离的权值，不能是简单平均
                    d1=kkdata1(j)-ppdata1(i);
                    d2=ppdata1(i)-kkdata1(j-1);
                    rd1=d1/(d1+d2);
                    rd2=d2/(d1+d2);
                    outputkinect1=[outputkinect1;ppdata1(i)];
                    outputkinect2=[outputkinect2;rd1*kkdata2(j)+rd2*kkdata2(j-1)];
                    outputkinect3=[outputkinect3;rd1*kkdata3(j)+rd2*kkdata3(j-1)];
                    outputkinect4=[outputkinect4;rd1*kkdata4(j)+rd2*kkdata4(j-1)];
                    outputkinect5=[outputkinect5;rd1*kkdata5(j)+rd2*kkdata5(j-1)];
                    break;
                end
            else
                outputkinect1=[outputkinect1;ppdata1(i)];
                outputkinect2=[outputkinect2;kkdata2(j)];
                outputkinect3=[outputkinect3;kkdata3(j)];
                outputkinect4=[outputkinect4;kkdata4(j)];
                outputkinect5=[outputkinect5;kkdata5(j)];
            end
        end
    end
end
%以上已经获得对应的序列，下面要开始真正的算法权值计算
%,其实就是因为无法用RSSI获得较为精确的值才导致之前的距离被破产，导致只能采用变化的方法更有效果，才使用的自己现在的方法
%数据转换框架 满分为100分
%将数据的间隔转换成四个序列，每个序列分别计算，得到相关的距离标识-1 0 1，其中要通过阈值来进行判断是否是保持不变
%要输出的序列
x=[];y=[];
xdata=[];ydata=[];
range1=find(pdata3);%得到范围
range2=find(pdata4);
range3=find(pdata5);
range4=find(pdata6);
num1=length(range1);%得到数目
num2=length(range2);
num3=length(range3);
num4=length(range4);
%进行序列的变换  
for i=1:num1-1
    %计算探针的数据
    if((pdata3(range1(i+1))-pdata3(range1(i)))>3)
        x=[x,1];
        xdata=[xdata,(pdata3(range1(i+1))-pdata3(range1(i)))];
    elseif((pdata3(range1(i+1))-pdata3(range1(i))<-3))
        x=[x,-1];
        xdata=[xdata,(pdata3(range1(i+1))-pdata3(range1(i)))];
    else
        x=[x,0];
        xdata=[xdata,(pdata3(range1(i+1))-pdata3(range1(i)))];
    end
    %计算kinect的数据
   if((outputkinect2(range1(i+1))-outputkinect2(range1(i)))>0.2)
        y=[y,-1];
        ydata=[ydata,(outputkinect2(range1(i+1))-outputkinect2(range1(i)))];
    elseif((outputkinect2(range1(i+1))-outputkinect2(range1(i)))<-0.2)
        y=[y,1];
        ydata=[ydata,(outputkinect2(range1(i+1))-outputkinect2(range1(i)))];
    else
        y=[y,0];
        ydata=[ydata,(outputkinect2(range1(i+1))-outputkinect2(range1(i)))];
    end
end
for i=1:num2-1
    %计算探针的数据
    if((pdata4(range2(i+1))-pdata4(range2(i)))>3)
        x=[x,1];
        xdata=[xdata,(pdata4(range2(i+1))-pdata4(range2(i)))];
    elseif((pdata4(range2(i+1))-pdata4(range2(i))<-3))
        x=[x,-1];
        xdata=[xdata,(pdata4(range2(i+1))-pdata4(range2(i)))];
    else
        x=[x,0];
        xdata=[xdata,(pdata4(range2(i+1))-pdata4(range2(i)))];
    end
    %计算kinect的数据
   if((outputkinect3(range2(i+1))-outputkinect3(range2(i)))>0.2)
        y=[y,-1];
        ydata=[ydata,(outputkinect3(range2(i+1))-outputkinect3(range2(i)))];
    elseif((outputkinect3(range2(i+1))-outputkinect3(range2(i)))<-0.2)
        y=[y,1];
        ydata=[ydata,(outputkinect3(range2(i+1))-outputkinect3(range2(i)))];
    else
        y=[y,0];
        ydata=[ydata,(outputkinect3(range2(i+1))-outputkinect3(range2(i)))];
    end
end
for i=1:num3-1
    %计算探针的数据
    if((pdata5(range3(i+1))-pdata5(range3(i)))>3)
        x=[x,1];
        xdata=[xdata,(pdata5(range3(i+1))-pdata5(range3(i)))];
    elseif((pdata5(range3(i+1))-pdata5(range3(i)))<-3)
        x=[x,-1];
        xdata=[xdata,(pdata5(range3(i+1))-pdata5(range3(i)))];
    else
        x=[x,0];
        xdata=[xdata,(pdata5(range3(i+1))-pdata5(range3(i)))];
    end
    %计算kinect的数据
   if((outputkinect4(range3(i+1))-outputkinect4(range3(i)))>0.2)
        y=[y,-1];
        ydata=[ydata,(outputkinect4(range3(i+1))-outputkinect4(range3(i)))];
    elseif((outputkinect4(range3(i+1))-outputkinect4(range3(i)))<-0.2)
        y=[y,1];
        ydata=[ydata,(outputkinect4(range3(i+1))-outputkinect4(range3(i)))];
    else
        y=[y,0];
        ydata=[ydata,(outputkinect4(range3(i+1))-outputkinect4(range3(i)))];
    end
end
for i=1:num4-1
    %计算探针的数据
    if((pdata6(range4(i+1))-pdata6(range4(i)))>3)
        x=[x,1];
        xdata=[xdata,(pdata6(range4(i+1))-pdata6(range4(i)))];
    elseif((pdata6(range4(i+1))-pdata6(range4(i)))<-3)
        x=[x,-1];
        xdata=[xdata,(pdata6(range4(i+1))-pdata6(range4(i)))];
    else
        x=[x,0];
        xdata=[xdata,(pdata6(range4(i+1))-pdata6(range4(i)))];
    end
    %计算kinect的数据
   if((outputkinect5(range4(i+1))-outputkinect5(range4(i)))>0.2)
        y=[y,-1];
        ydata=[ydata,(outputkinect5(range4(i+1))-outputkinect5(range4(i)))];
    elseif((outputkinect5(range4(i+1))-outputkinect5(range4(i)))<-0.2)
        y=[y,1];
        ydata=[ydata,(outputkinect5(range4(i+1))-outputkinect5(range4(i)))];
    else
        y=[y,0];
        ydata=[ydata,(outputkinect5(range4(i+1))-outputkinect5(range4(i)))];
    end
end
r1=(num1-1)/(num1+num2+num3+num4-4);%计算因子
r2=(num2-1)/(num1+num2+num3+num4-4);
r3=(num3-1)/(num1+num2+num3+num4-4);
r4=(num4-1)/(num1+num2+num3+num4-4);
r=[r1,r2,r3,r4];
%序列比较框架 在编写C++要这么写
index=[num1-1,num2-1,num3-1,num4-1];
z=abs(x-y);
z(z==1)=0.3;%权值替换
z(z==0)=1;
z(z==2)=0;
%构建索引
score=0;
up=0;
down=0;
for i=1:4
    up=up+1;
    down=down+index(i);
    score=score+(sum(z(up:down))/index(i)*r(i)*100);
    up=down;
end

%四个探针的权值。不能均分，再根据每个探针中非零数的间隔再对数据进行分割，
%从而得到数目的序列，然后对数目序列在进行一个双层模糊逻辑的判断,距离映射给经验值，高斯序列不怎么样
