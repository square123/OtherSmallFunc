function [score, num] = method1(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4)
%   ���ڱ仯���ƽ���ƥ��ĺ���
%   ע��Ҫ���з���Ƚϣ������������ݸ���ֻ��һ��ʱ����ֵ��Ϊ0
%   ��ʱ����ľ������� ��û�о�����0������

%��������
kThd = 0.05; %��ֵ
rThd = 3;
quanZhi = 0.25; %��״̬����ʱ�����Ĺ���

%������ �ĸ����зֱ��� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����������ת���ɾ���� ���Ѿ�ת����������
%�����һ��
    indexFor1 = find(rTabR1);
    rFor1 = rTabR1(indexFor1);
    kFor1 = kTabD1(indexFor1);

    %������Ϣ
    if length(rFor1)>1
        dRFor1=diff(rFor1); 
        dKFor1=diff(kFor1);
    else
        dRFor1=0; %���ֻ��һ�����ݻ�û������
        dKFor1=0;
    end
    
    %ת�������Ϣ
    %ת��RSSI
    dRFor1(dRFor1>rThd)=rThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dRFor1(dRFor1<=rThd & dRFor1>=-rThd)=0;
    dRFor1(dRFor1<-rThd)=-1;
    dRFor1(dRFor1 == rThd+1)=1;%�����޸Ļ��� �����ı���һ��
    %ת������ ע���RSSI�Ƿ������
    dKFor1(dKFor1>kThd)=kThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dKFor1(dKFor1<=kThd & dKFor1>=-kThd)=0;
    dKFor1(dKFor1<-kThd)=1;
    dKFor1(dKFor1 == kThd+1)=-1;%�����޸Ļ��� �����ı���һ�� ��Ҫ����

%����ڶ���
    indexFor2 = find(rTabR2);
    rFor2 = rTabR2(indexFor2);
    kFor2 = kTabD2(indexFor2);

    %������Ϣ
    if length(rFor2)>1
        dRFor2=diff(rFor2); 
        dKFor2=diff(kFor2);
    else
        dRFor2=0; %���ֻ��һ�����ݻ�û������
        dKFor2=0;
    end
    
    %ת�������Ϣ
    %ת��RSSI
    dRFor2(dRFor2>rThd)=rThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dRFor2(dRFor2<=rThd & dRFor2>=-rThd)=0;
    dRFor2(dRFor2<-rThd)=-1;
    dRFor2(dRFor2 == rThd+1)=1;%�����޸Ļ��� �����ı���һ��
    %ת������ ע���RSSI�Ƿ������
    dKFor2(dKFor2>kThd)=kThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dKFor2(dKFor2<=kThd & dKFor2>=-kThd)=0;
    dKFor2(dKFor2<-kThd)=1;
    dKFor2(dKFor2 == kThd+1)=-1;%�����޸Ļ��� �����ı���һ�� ��Ҫ����
    
%���������
    indexFor3 = find(rTabR3);
    rFor3 = rTabR3(indexFor3);
    kFor3 = kTabD3(indexFor3);

    %������Ϣ
    if length(rFor3)>1
        dRFor3=diff(rFor3); 
        dKFor3=diff(kFor3);
    else
        dRFor3=0; %���ֻ��һ�����ݻ�û������
        dKFor3=0;
    end
    
    %ת�������Ϣ
    %ת��RSSI
    dRFor3(dRFor3>rThd)=rThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dRFor3(dRFor3<=rThd & dRFor3>=-rThd)=0;
    dRFor3(dRFor3<-rThd)=-1;
    dRFor3(dRFor3 == rThd+1)=1;%�����޸Ļ��� �����ı���һ��
    %ת������ ע���RSSI�Ƿ������
    dKFor3(dKFor3>kThd)=kThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dKFor3(dKFor3<=kThd & dKFor3>=-kThd)=0;
    dKFor3(dKFor3<-kThd)=1;
    dKFor3(dKFor3 == kThd+1)=-1;%�����޸Ļ��� �����ı���һ�� ��Ҫ����
    
%������ĸ�
    indexFor4 = find(rTabR4);
    rFor4 = rTabR4(indexFor4);
    kFor4 = kTabD4(indexFor4);

    %������Ϣ
    if length(rFor4)>1
        dRFor4=diff(rFor4); 
        dKFor4=diff(kFor4);
    else
        dRFor4=0; %���ֻ��һ�����ݻ�û������
        dKFor4=0;
    end
    
    %ת�������Ϣ
    %ת��RSSI
    dRFor4(dRFor4>rThd)=rThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dRFor4(dRFor4<=rThd & dRFor4>=-rThd)=0;
    dRFor4(dRFor4<-rThd)=-1;
    dRFor4(dRFor4 == rThd+1)=1;%�����޸Ļ��� �����ı���һ��
    %ת������ ע���RSSI�Ƿ������
    dKFor4(dKFor4>kThd)=kThd+1; %����ĳ�1�����ֻ��� ���ǹ���ʵ�������ĵ�����
    dKFor4(dKFor4<=kThd & dKFor4>=-kThd)=0;
    dKFor4(dKFor4<-kThd)=1;
    dKFor4(dKFor4 == kThd+1)=-1;%�����޸Ļ��� �����ı���һ�� ��Ҫ����
   
%�����е���ֵ�ĳ�Ȩֵ
    dR=[dRFor1;dRFor2; dRFor3; dRFor4]; %�������������
    dK=[dKFor1; dKFor2; dKFor3; dKFor4];
    
    distForRK = double(dR)-double(dK); %����ֻ�п��ܳ��� 0��ͬ +-1 �����1  +-2 ������ȫ��ͬ ֻ�п�����������ֵ
    distForRK(distForRK == 1 | distForRK == -1)=quanZhi; %����Ϊ1 ����Ȩֵ
    distForRK(distForRK == 0)=1; % ����Ϊ1 ����Ϊ1
    distForRK(distForRK == 2 |distForRK == -2)=0; % ����Ϊ2 ����Ϊ0

%������Ⱥ�Ȩֵ
    num = length(distForRK);
    score=sum(distForRK)/num*100;
end

