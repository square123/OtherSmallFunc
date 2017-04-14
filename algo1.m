clear;
clc;
kincetName='I:\wifiProject\location\location\location\kinectdata.csv';
probeName='I:\wifiProject\location\location\location\probeGet.csv';
[kdata1,kdata2,kdata3,kdata4,kdata5,kdata6]=textread(kincetName,'%s%d%f%f%f%f','delimiter', ',');
[pdata1,pdata2,pdata3,pdata4,pdata5,pdata6]=textread(probeName,'%s%s%d%d%d%d','delimiter', ',');
%�������ݲ�������Ժ��ٿ���

% sel=[size(pdata1,1),size(pdata2,1),size(pdata3,1),size(pdata4,1),size(pdata5,1),size(pdata6,1)];
% len=max(sel);
len=size(pdata2,1);
%�޳������Ԫ�أ�ֻ�����˸�MAC�������
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

llen=size(kdata1,1);%��kinectֵ����ѹ��
tempstr='';%������ͬʱ���
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
%ͨ�����ϳ����Ѿ��������ʱ��ĺϲ�
%���Ժ��ڴ�������ʱ��Ӧ�����������ʱ�����ͬʱ�̵ı�д�����Բο��Լ�֮ǰ��̽����ʹ�õķ��������߿��Կ��Ǽ���Kalaman�㷨��ֻҪʱ�䲻�ϼ��ɣ����߿����¿������˲��Ƿ��ʺϲ������Ĺ켣��
len=size(pdata2,1);
llen=size(kkdata1,1);
%��Ҫ�����Ӧrssiʱ�̵�kinect���
%���ַ�ת��������
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
for i=1:len%��������̽��
    for j=1:llen%��������kinect
        if(kkdata1(j)>ppdata1(i))%�����Ȳ�����ȵ�ֵ�����Ҵ��ڸ�ֵ��ֵ��
            if(j-1>0)
                if(kkdata1(j-1)==ppdata1(i))
                    outputkinect1=[outputkinect1;kkdata1(j-1)];
                    outputkinect2=[outputkinect2;kkdata2(j-1)];
                    outputkinect3=[outputkinect3;kkdata3(j-1)];
                    outputkinect4=[outputkinect4;kkdata4(j-1)];
                    outputkinect5=[outputkinect5;kkdata5(j-1)];
                    break;
                else  %Ҫ�ҵ�ʱ������ľ���ľ�ֵ������Ҫ��ʱ������Ȩֵ�������Ǽ�ƽ��
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
%�����Ѿ���ö�Ӧ�����У�����Ҫ��ʼ�������㷨Ȩֵ����
%,��ʵ������Ϊ�޷���RSSI��ý�Ϊ��ȷ��ֵ�ŵ���֮ǰ�ľ��뱻�Ʋ�������ֻ�ܲ��ñ仯�ķ�������Ч������ʹ�õ��Լ����ڵķ���
%����ת����� ����Ϊ100��
%�����ݵļ��ת�����ĸ����У�ÿ�����зֱ���㣬�õ���صľ����ʶ-1 0 1������Ҫͨ����ֵ�������ж��Ƿ��Ǳ��ֲ���
%Ҫ���������
x=[];y=[];
xdata=[];ydata=[];
range1=find(pdata3);%�õ���Χ
range2=find(pdata4);
range3=find(pdata5);
range4=find(pdata6);
num1=length(range1);%�õ���Ŀ
num2=length(range2);
num3=length(range3);
num4=length(range4);
%�������еı任  
for i=1:num1-1
    %����̽�������
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
    %����kinect������
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
    %����̽�������
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
    %����kinect������
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
    %����̽�������
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
    %����kinect������
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
    %����̽�������
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
    %����kinect������
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
r1=(num1-1)/(num1+num2+num3+num4-4);%��������
r2=(num2-1)/(num1+num2+num3+num4-4);
r3=(num3-1)/(num1+num2+num3+num4-4);
r4=(num4-1)/(num1+num2+num3+num4-4);
r=[r1,r2,r3,r4];
%���бȽϿ�� �ڱ�дC++Ҫ��ôд
index=[num1-1,num2-1,num3-1,num4-1];
z=abs(x-y);
z(z==1)=0.3;%Ȩֵ�滻
z(z==0)=1;
z(z==2)=0;
%��������
score=0;
up=0;
down=0;
for i=1:4
    up=up+1;
    down=down+index(i);
    score=score+(sum(z(up:down))/index(i)*r(i)*100);
    up=down;
end

%�ĸ�̽���Ȩֵ�����ܾ��֣��ٸ���ÿ��̽���з������ļ���ٶ����ݽ��зָ
%�Ӷ��õ���Ŀ�����У�Ȼ�����Ŀ�����ڽ���һ��˫��ģ���߼����ж�,����ӳ�������ֵ����˹���в���ô��
