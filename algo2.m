clear;%�ýű����ǵ��ǵ��˵��㷨�����Ҫ���Ƕ��˵Ľű�������Ҫ��kdata{2}���з���,
%����֮�⣬��ϵͳ�У����δ��WiFi���أ���Ҳ�޷�ƥ�䵽��Ӧ��Mac��ַ�������п��ܻ����������������ƥ��������ƥ�����ͺ������ˣ��ͽ�����һֱ������ȥ
%��Ϊ��ϵͳ�������������޷�֪�����Ƿ��WiFi������
clc;
kincetName=fopen('H:\MAC��ַ�ɼ�\˫�˲�������\test\1.csv');
probeName=fopen('H:\MAC��ַ�ɼ�\˫�˲�������\test\probeGet.csv');
kdata=textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');
pdata=textscan(probeName,'%s %s %d %d %d %d','delimiter', ',');
%��ö��Mac��ַ����
temp=pdata{:,2};
%��洢�ĸ�ʽ�����������ģ���ÿ��Mac��������ҵ���������������
%mac1   mac2    ����
%1      5
%2      6
%3      7
%9      8
%10     0
utemp=unique(temp);%�ҵ����ĺ�����Ҫ��֮ǰ�ĳ������һ���Ż�
maxNum=0;
for i=1:length(utemp)%�ҵ����ֵ
    if(length(find(strcmp(pdata{:,2},utemp(i))))>=maxNum)
        maxNum=length(find(strcmp(pdata{:,2},utemp(i))));
    end
end
indexData=zeros(maxNum,length(utemp));%��취�洢�������䳤���Ǳ䳤��
for i=1:length(utemp)
    lin=zeros(1,maxNum-length(find(strcmp(pdata{:,2},utemp(i)))));
     indexData(:,i)=[find(strcmp(pdata{:,2},utemp(i)));lin'];
end
kdataTime=[];%�õ����ʱ��
pdataTime=[];
for i=1:length(kdata{1,1})
    kdataTime=[kdataTime; str2double(kdata{1,1}{i})];
end
for i=1:length(pdata{1,1})
    pdataTime=[pdataTime;str2double(pdata{1,1}{i})];
end
%���������ʽ�� ���б�����������->Ȩֵ,������ӦMac��ַ
output=zeros(length(utemp),2);
%��ʼ����
for k=1:length(utemp)%��������
    %��������
    outputRSSITime=pdataTime(indexData(1:length(find(indexData(:,k))),k));%�洢��ʱ��
    outputRSSI1=pdata{3}(indexData(1:length(find(indexData(:,k))),k));%�洢��RSSI1��Ϣ
    outputRSSI2=pdata{4}(indexData(1:length(find(indexData(:,k))),k));%�洢��RSSI2��Ϣ
    outputRSSI3=pdata{5}(indexData(1:length(find(indexData(:,k))),k));%�洢��RSSI3��Ϣ
    outputRSSI4=pdata{6}(indexData(1:length(find(indexData(:,k))),k));%�洢��RSSI4��Ϣ
    %�����ҵ��˶�ӦĳMac�µ�ʱ���RSSI��Ӧ��
    %����Ҫ�Ҷ�ӦMac��Kinect��Ϣ
    outputkinectTime=[];
    outputkinect1=[];
    outputkinect2=[];
    outputkinect3=[];
    outputkinect4=[];
    for i=1:length(find(indexData(:,k)))%��������̽��
        for j=1:length(kdata{1})%��������kinect
            if(kdataTime(j)>outputRSSITime(i))%�����Ȳ�����ȵ�ֵ�����Ҵ��ڸ�ֵ��ֵ��
                if(j-1>0)
                    if(kdataTime(j-1)==outputRSSITime(i))
                        outputkinectTime=[outputkinectTime;outputRSSITime(i)];
                        outputkinect1=[outputkinect1;kdata{3}(j-1)];
                        outputkinect2=[outputkinect2;kdata{4}(j-1)];
                        outputkinect3=[outputkinect3;kdata{5}(j-1)];
                        outputkinect4=[outputkinect4;kdata{6}(j-1)];
                        break;
                    else  %Ҫ�ҵ�ʱ������ľ���ľ�ֵ������Ҫ��ʱ������Ȩֵ�������Ǽ�ƽ��
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
    %�����ҵ���Mac��ַƥ��Ķ�Ӧ�ԣ������ܻ��������û�ж�������
    t1=length(outputkinectTime);
    t2=length(outputRSSITime);
    if(t1~=t2)%������û�е������ÿ�
    outputRSSITime(t1+1:t2)=[];
    outputRSSI1(t1+1:t2)=[];
    outputRSSI2(t1+1:t2)=[];
    outputRSSI3(t1+1:t2)=[];
    outputRSSI4(t1+1:t2)=[];
    end
    %������������ݵĶ�������Ҫ��ʼ�������㷨Ȩֵ����
    %����ת����� ����Ϊ100��
    %�����ݵļ��ת�����ĸ����У�ÿ�����зֱ���㣬�õ���صľ����ʶ-1 0 1������Ҫͨ����ֵ�������ж��Ƿ��Ǳ��ֲ���
    %Ҫ��������У���Ϊ���ø��ֱ��̫�����ˣ���������д��һ��������
    [score,num,x,y]=CompareKR(outputRSSI1,outputRSSI2,outputRSSI3,outputRSSI4,outputkinect1,outputkinect2,outputkinect3,outputkinect4);
    %���ϵó������ݵ������ʽ�����濪ʼ���ݵĵ�Ȩֵ���
    output(k,1)=score;
    output(k,2)=num;
end
%���ϵõ��˵��˵�Mac��ַ����Ӧ�����ݱ������Ƕ������ٽ��п���
maxs=max(output(:,2));
a=pi/maxs;
weight=0.5-0.5*cos(a*output(:,2));
optoutput=output(:,1).*weight;
[ss,ii]=max(optoutput);
disp('����ƥ�䵽��MAC��ַ��')
utemp{ii}
disp('������')
ss
