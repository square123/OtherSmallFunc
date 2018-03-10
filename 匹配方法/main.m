%��д����

%��ղ���
clear;
clc;

%�������
dataLength = 14;%Ҫѭ�����ļ�����
knowedMac = 'B0:E2:35:2B:DA:E0';%Ҫƥ���MAC��ַ

%���������չʾ������֪MAC��ַ������£���ֻչʾ���ֵ�λ��
finallyResult = zeros(dataLength,1);

%��ѭ������
for dataForI = 1:dataLength
   
    %��������
    kincetName = fopen(strcat(strcat('C:\Users\Administrator\Desktop\9��5��������ϴ\����\',num2str(dataForI)),'\kinectdata.csv'));
    probeName = fopen(strcat(strcat('C:\Users\Administrator\Desktop\9��5��������ϴ\����\',num2str(dataForI)),'\probeGet.csv'));
    kdata = textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');%kinect����
    pdata = textscan(probeName,'%s %s %d %d %d %d','delimiter', ',');%̽������
    
    %ȡ� ������� 
    delSet = setdiff(pdata{1},kdata{1});
    delSetIndex=[];
    for ii = 1:length(delSet)
        delSetIndex = [delSetIndex;find(strcmp(pdata{1},delSet(ii)))];
    end
    %�޳������
    pdata{1}(delSetIndex,:)=[];pdata{2}(delSetIndex,:)=[];pdata{3}(delSetIndex,:)=[];pdata{4}(delSetIndex,:)=[];pdata{5}(delSetIndex,:)=[];pdata{6}(delSetIndex,:)=[];
    
    %����MAC��ַ���� ��������MAC��ַʶ��
    MacName = unique(pdata{2});
    %�õ���������RSSI���еĸ���
    MacNumber = length(MacName);
    %Ԥ��MAC��ַ�ı������ score num
    MacTable = zeros(2,MacNumber);
    
    %Сѭ�� һ��ѭ�����ѡȡ��������������һ�����жԣ����������
    for i = 1:MacNumber 
        
        %ѡ������MAC�����ݱ�� �����ʽ rTabTime rTabR1 rTabR2 rTabR3 rTabR4
        rTabTime=pdata{1}(strcmp(pdata{2},MacName(i)));
        rTabR1=pdata{3}(strcmp(pdata{2},MacName(i)));
        rTabR2=pdata{4}(strcmp(pdata{2},MacName(i)));
        rTabR3=pdata{5}(strcmp(pdata{2},MacName(i)));
        rTabR4=pdata{6}(strcmp(pdata{2},MacName(i)));
       
        %�����������ݱ�� ѡ������ʱ�̵�MAC��ַ ������ȡ����� 
        respondTimeIndex = [];
        for iii = 1:length(rTabTime)
            respondTimeIndex = [respondTimeIndex;find(strcmp(kdata{1},rTabTime(iii)))];
        end
        kTabTime=kdata{1}(respondTimeIndex);
        kTabD1=kdata{3}(respondTimeIndex);
        kTabD2=kdata{4}(respondTimeIndex);
        kTabD3=kdata{5}(respondTimeIndex);
        kTabD4=kdata{6}(respondTimeIndex);
    
        %С���� ���������� ���ƥ�����  [score, num]=method1(rTabTime,rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            %����1
            %[score, num]=method1(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            %����2
            [score, num]=method2(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            
        %��MAC��ַ��Ӧ�ķ����ͳ��ȼ�¼��
        MacTable(1,i) = score;MacTable(2,i) = num;
    end
    
    %���Ŷ�ģ�͹��� 
    maxNum = max(MacTable(2,:));
    beta = 0.5*maxNum;
    alpha = -(log(1/0.99 - 1))/(0.8*maxNum);
    weight = 1./(1+exp((-alpha).*(MacTable(2,:)-beta)));
    %���¼������
    finalScore = MacTable(1,:).*weight;
    % ��������û�еĲ��� ��Ϊ���ϵ������ָ�����������ʵ�����Ǳ�û������Ҫ���õ�ֵ����˽�û���ݵ�����ֱ���ø���
    finalScore(MacTable(2,:)==0)=-10;
    %���� ��ס�ǽ�������
    [ ~ ,scoreIndex] = sort(finalScore,'descend');
    sortMacName = MacName(scoreIndex);
    %������ȷMAC��ַ���ֵ�λ�ò���¼����
    finallyResult(dataForI) = find(strcmp(sortMacName,knowedMac));
    fclose(kincetName);%�ر��ļ�
    fclose(probeName); %�ر��ļ�
end

