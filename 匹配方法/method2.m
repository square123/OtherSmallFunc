function [score, num] = method2(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4)
%   ���ڶ�����ϵƥ��ĺ���
%   

%������ �ĸ����зֱ��� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����������ת���ɾ���� ���Ѿ�ת����������
%�����һ��
    indexFor1 = find(rTabR1);
    rFor1 = rTabR1(indexFor1);
    kFor1 = kTabD1(indexFor1); %ѡ�����ж�

    %������Ϣ
    if length(rFor1)>2 %�߽��ж� ����Ҫ������ֵ ��Ȼ�򲻼�¼����
        dRFor1=diff(rFor1); %�Ȱ�RSSI��ּ������
        lgKFor1=log10(kFor1+0.000001);%����һ����С��ֵ��ֹ���ָ�����
        dlgKFor1=diff(lgKFor1);%ȡ��������Ĳ��
    else
        dRFor1=[]; %�޹��� ��Ϊ�޷����㶨����ϵ
        dlgKFor1=[];
    end
    
    %����RSSI��ֵ�ȺͶ��������ֵ��
    if ~isempty(dRFor1)
    %����������0 ��Ϊ0.01 ��ֹ��0��Ϊ��ĸ������ 
    dRFor1=dRFor1+0.01;
    dlgKFor1=dlgKFor1+0.01;
    %��λ ��ʱ����������������� ���ֵ Ϊ�˷��㣬��ÿ�����鶼���ظ����ã�����ֻ���������ݵ�����ᱻ��������
    shiftRFor1=[dRFor1(2:end); dRFor1(1)];
    shiftKFor1=[dlgKFor1(2:end); dlgKFor1(1)];
    ratioRFor1=dRFor1./shiftRFor1;
    ratioKFor1=dlgKFor1./shiftKFor1;
    else
        ratioRFor1=[];
        ratioKFor1=[];
    end
    
%����ڶ���
    indexFor2 = find(rTabR2);
    rFor2 = rTabR2(indexFor2);
    kFor2 = kTabD2(indexFor2); %ѡ�����ж�

    %������Ϣ
    if length(rFor2)>2 %�߽��ж� ����Ҫ������ֵ ��Ȼ�򲻼�¼����
        dRFor2=diff(rFor2); %�Ȱ�RSSI��ּ������
        lgKFor2=log10(kFor2+0.000001);%����һ����С��ֵ��ֹ���ָ�����
        dlgKFor2=diff(lgKFor2);%ȡ��������Ĳ��
    else
        dRFor2=[]; %�޹��� ��Ϊ�޷����㶨����ϵ
        dlgKFor2=[];
    end
    
    %����RSSI��ֵ�ȺͶ��������ֵ��
    if ~isempty(dRFor2)
    %����������0 ��Ϊ0.01 ��ֹ��0��Ϊ��ĸ������ 
    dRFor2=dRFor2+0.01;
    dlgKFor2=dlgKFor2+0.01;
    %��λ ��ʱ����������������� ���ֵ Ϊ�˷��㣬��ÿ�����鶼���ظ����ã�����ֻ���������ݵ�����ᱻ��������
    shiftRFor2=[dRFor2(2:end); dRFor2(1)];
    shiftKFor2=[dlgKFor2(2:end); dlgKFor2(1)];
    ratioRFor2=dRFor2./shiftRFor2;
    ratioKFor2=dlgKFor2./shiftKFor2;
    else
        ratioRFor2=[];
        ratioKFor2=[];
    end

%���������
    indexFor3 = find(rTabR3);
    rFor3 = rTabR3(indexFor3);
    kFor3 = kTabD3(indexFor3); %ѡ�����ж�

    %������Ϣ
    if length(rFor3)>2 %�߽��ж� ����Ҫ������ֵ ��Ȼ�򲻼�¼����
        dRFor3=diff(rFor3); %�Ȱ�RSSI��ּ������
        lgKFor3=log10(kFor3+0.000001);%����һ����С��ֵ��ֹ���ָ�����
        dlgKFor3=diff(lgKFor3);%ȡ��������Ĳ��
    else
        dRFor3=[]; %�޹��� ��Ϊ�޷����㶨����ϵ
        dlgKFor3=[];
    end
    
    %����RSSI��ֵ�ȺͶ��������ֵ��
    if ~isempty(dRFor3)
    %����������0 ��Ϊ0.01 ��ֹ��0��Ϊ��ĸ������ 
    dRFor3=dRFor3+0.01;
    dlgKFor3=dlgKFor3+0.01;
    %��λ ��ʱ����������������� ���ֵ Ϊ�˷��㣬��ÿ�����鶼���ظ����ã�����ֻ���������ݵ�����ᱻ��������
    shiftRFor3=[dRFor3(2:end) ;dRFor3(1)];
    shiftKFor3=[dlgKFor3(2:end); dlgKFor3(1)];
    ratioRFor3=dRFor3./shiftRFor3;
    ratioKFor3=dlgKFor3./shiftKFor3;
    else
        ratioRFor3=[];
        ratioKFor3=[];
    end
    
%������ĸ�
    indexFor4 = find(rTabR4);
    rFor4 = rTabR4(indexFor4);
    kFor4 = kTabD4(indexFor4); %ѡ�����ж�

    %������Ϣ
    if length(rFor4)>2 %�߽��ж� ����Ҫ������ֵ ��Ȼ�򲻼�¼����
        dRFor4=diff(rFor4); %�Ȱ�RSSI��ּ������
        lgKFor4=log10(kFor4+0.000001);%����һ����С��ֵ��ֹ���ָ�����
        dlgKFor4=diff(lgKFor4);%ȡ��������Ĳ��
    else
        dRFor4=[]; %�޹��� ��Ϊ�޷����㶨����ϵ
        dlgKFor4=[];
    end
    
    %����RSSI��ֵ�ȺͶ��������ֵ��
    if ~isempty(dRFor4)
    %����������0 ��Ϊ0.01 ��ֹ��0��Ϊ��ĸ������ 
    dRFor4=dRFor4+0.01;
    dlgKFor4=dlgKFor4+0.01;
    %��λ ��ʱ����������������� ���ֵ Ϊ�˷��㣬��ÿ�����鶼���ظ����ã�����ֻ���������ݵ�����ᱻ��������
    shiftRFor4=[dRFor4(2:end) ;dRFor4(1)];
    shiftKFor4=[dlgKFor4(2:end) ;dlgKFor4(1)];
    ratioRFor4=dRFor4./shiftRFor4;
    ratioKFor4=dlgKFor4./shiftKFor4;
    else
        ratioRFor4=[];
        ratioKFor4=[];
    end
    
%������в��������Ҿ��� ������Ӧ����100�� ��Ϊ���ڸ�ֵ
    ratioR=[ratioRFor1 ;ratioRFor2; ratioRFor3 ;ratioRFor4];
    ratioK=[ratioKFor1; ratioKFor2 ;ratioKFor3; ratioKFor4];
    ratioR=double(ratioR);
    ratioK=double(ratioK);
    
    num = length(ratioR);
    if num~=0
        score = dot(ratioR,ratioK)/(norm(ratioR)*norm(ratioK));
    else
        score = 0;
    end
end

