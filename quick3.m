%quick3
%������ݷ�����ʽ 
%                                           ����                      40����     48����     c8����     94����   88����  
%                      ��˹�˲���ľ�ֵ�����ֵ����Сֵ�����ֵ������
%����  *  4״̬  00 
%               01
%               10
%               11
clear;
clc;
output=[];%��״̬�ֿ����������
outputInt=[];%��״̬�ϲ��Ծ���Ϊ���������ݴ���
fileForm='C:\Users\Administrator\Desktop\��̽��\wifiTest\ץ���ʺ����жȲ���\';
status={'00','01','10','11'};
for range=0.5:0.5:5.5   %ȷ������
    outputtempInt=zeros(1,5);
    data3333=[];%������Ϻ������
    for stat=1:4
        outputtemp=zeros(1,30);
        fileName=strcat(strcat(strcat(strcat(fileForm,num2str(range,'%1.1f')),'_'),status{stat}),'.csv');
        [data1,data2,data3,data4]=textread(fileName,'%s%s%d%s','delimiter', ',');%data1 ʱ��,data2 Mac��ַ,data3 Rssi,data4 ����
        %�޳������Ԫ�أ�ֻ�����˸�MAC�������
        len=size(data1,1);
        for i=len:-1:1
            if(~strcmp(data2{i},'B0:E2:35:2B:DA:E0'))
                data1(i)=[];
                data2(i)=[];
                data3(i)=[];
                data4(i)=[];
            end
        end
        %��һ��ɸѡ��ȥ��ʱ����ͬ��������źŸ�ʽһ��������
        len=size(data1,1);
        for i=len:-1:2
            if((abs(str2double(data1{i})-str2double(data1{i-1}))<=1)&&(strcmp(data4{i},data4{i-1})))
                if(data3(i)>data3(i-1))%��Ҫ�޳�ʱ�����ϴ��ֵ
                    data3(i-1)=data3(i);
                end
                data1(i)=[];
                data2(i)=[];
                data3(i)=[];
                data4(i)=[];
            end
        end
        rssi94=[];
        rssi48=[];
        rssic8=[];
        rssi88=[];
        rssi40=[];
        len=size(data1,1);
        if(~(isempty(data4)))
            for i=1:len %���𽫻�ȡ���źŽ��з���
                switch(data4{i})
                    case '40'
                        rssi40=[rssi40,data3(i)];
                    case '48'
                        rssi48=[rssi48,data3(i)];
                    case 'c8'
                        rssic8=[rssic8,data3(i)];
                    case '94'
                        rssi94=[rssi94,data3(i)];
                    case '88'
                        rssi88=[rssi88,data3(i)];
                    otherwise
                        data4{i}%�����������������������͵�
                        fileName
                end
            end
        end
        [ outputtemp(1), outputtemp(2), outputtemp(3), outputtemp(4), outputtemp(5) ] = NormSelRSSI(data3);
        [ outputtemp(6), outputtemp(7), outputtemp(8), outputtemp(9), outputtemp(10) ] = NormSelRSSI(rssi40);
        [ outputtemp(11), outputtemp(12), outputtemp(13), outputtemp(14), outputtemp(15) ] = NormSelRSSI(rssi48);
        [ outputtemp(16), outputtemp(17), outputtemp(18), outputtemp(19), outputtemp(20) ] = NormSelRSSI(rssic8);
        [ outputtemp(21), outputtemp(22), outputtemp(23), outputtemp(24), outputtemp(25) ] = NormSelRSSI(rssi94);
        [ outputtemp(26), outputtemp(27), outputtemp(28), outputtemp(29), outputtemp(30) ] = NormSelRSSI(rssi88);
        output=[output;outputtemp];
        data3333=[data3333;data3];
    end
    [ outputtempInt(1), outputtempInt(2), outputtempInt(3), outputtempInt(4), outputtempInt(5) ] = NormSelRSSI(data3333);
    outputInt=[outputInt;outputtempInt];
end
outputed=[output(:,5),output(:,10),output(:,15),output(:,20),output(:,25),output(:,30)];%������״̬�´��ڵ����ݷֲ�
rssied=[output(:,1),output(:,6),output(:,11),output(:,16),output(:,21),output(:,26)];%������״̬��RSSIֵ�Ĳ��