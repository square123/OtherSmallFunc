function [score, num] = method1(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4)
%   基于变化趋势进行匹配的函数
%   注意要进行分组比较，对于组内数据个数只有一个时，将值记为0
%   此时输入的距离数据 是没有经过与0操作的

%参数设置
kThd = 0.05; %阈值
rThd = 3;
quanZhi = 0.25; %当状态不变时所做的贡献

%笨方法 四个序列分别处理 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%将分组的数据转换成距离对 且已经转换成了特征
%处理第一个
    indexFor1 = find(rTabR1);
    rFor1 = rTabR1(indexFor1);
    kFor1 = kTabD1(indexFor1);

    %求差分信息
    if length(rFor1)>1
        dRFor1=diff(rFor1); 
        dKFor1=diff(kFor1);
    else
        dRFor1=0; %如果只有一个数据或没有数据
        dKFor1=0;
    end
    
    %转换差分信息
    %转换RSSI
    dRFor1(dRFor1>rThd)=rThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dRFor1(dRFor1<=rThd & dRFor1>=-rThd)=0;
    dRFor1(dRFor1<-rThd)=-1;
    dRFor1(dRFor1 == rThd+1)=1;%这里修改回来 与论文保持一致
    %转换距离 注意和RSSI是反方向的
    dKFor1(dKFor1>kThd)=kThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dKFor1(dKFor1<=kThd & dKFor1>=-kThd)=0;
    dKFor1(dKFor1<-kThd)=1;
    dKFor1(dKFor1 == kThd+1)=-1;%这里修改回来 与论文保持一致 需要测试

%处理第二个
    indexFor2 = find(rTabR2);
    rFor2 = rTabR2(indexFor2);
    kFor2 = kTabD2(indexFor2);

    %求差分信息
    if length(rFor2)>1
        dRFor2=diff(rFor2); 
        dKFor2=diff(kFor2);
    else
        dRFor2=0; %如果只有一个数据或没有数据
        dKFor2=0;
    end
    
    %转换差分信息
    %转换RSSI
    dRFor2(dRFor2>rThd)=rThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dRFor2(dRFor2<=rThd & dRFor2>=-rThd)=0;
    dRFor2(dRFor2<-rThd)=-1;
    dRFor2(dRFor2 == rThd+1)=1;%这里修改回来 与论文保持一致
    %转换距离 注意和RSSI是反方向的
    dKFor2(dKFor2>kThd)=kThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dKFor2(dKFor2<=kThd & dKFor2>=-kThd)=0;
    dKFor2(dKFor2<-kThd)=1;
    dKFor2(dKFor2 == kThd+1)=-1;%这里修改回来 与论文保持一致 需要测试
    
%处理第三个
    indexFor3 = find(rTabR3);
    rFor3 = rTabR3(indexFor3);
    kFor3 = kTabD3(indexFor3);

    %求差分信息
    if length(rFor3)>1
        dRFor3=diff(rFor3); 
        dKFor3=diff(kFor3);
    else
        dRFor3=0; %如果只有一个数据或没有数据
        dKFor3=0;
    end
    
    %转换差分信息
    %转换RSSI
    dRFor3(dRFor3>rThd)=rThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dRFor3(dRFor3<=rThd & dRFor3>=-rThd)=0;
    dRFor3(dRFor3<-rThd)=-1;
    dRFor3(dRFor3 == rThd+1)=1;%这里修改回来 与论文保持一致
    %转换距离 注意和RSSI是反方向的
    dKFor3(dKFor3>kThd)=kThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dKFor3(dKFor3<=kThd & dKFor3>=-kThd)=0;
    dKFor3(dKFor3<-kThd)=1;
    dKFor3(dKFor3 == kThd+1)=-1;%这里修改回来 与论文保持一致 需要测试
    
%处理第四个
    indexFor4 = find(rTabR4);
    rFor4 = rTabR4(indexFor4);
    kFor4 = kTabD4(indexFor4);

    %求差分信息
    if length(rFor4)>1
        dRFor4=diff(rFor4); 
        dKFor4=diff(kFor4);
    else
        dRFor4=0; %如果只有一个数据或没有数据
        dKFor4=0;
    end
    
    %转换差分信息
    %转换RSSI
    dRFor4(dRFor4>rThd)=rThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dRFor4(dRFor4<=rThd & dRFor4>=-rThd)=0;
    dRFor4(dRFor4<-rThd)=-1;
    dRFor4(dRFor4 == rThd+1)=1;%这里修改回来 与论文保持一致
    %转换距离 注意和RSSI是反方向的
    dKFor4(dKFor4>kThd)=kThd+1; %如果改成1则会出现混乱 这是工程实现与论文的区别
    dKFor4(dKFor4<=kThd & dKFor4>=-kThd)=0;
    dKFor4(dKFor4<-kThd)=1;
    dKFor4(dKFor4 == kThd+1)=-1;%这里修改回来 与论文保持一致 需要测试
   
%将序列的数值改成权值
    dR=[dRFor1;dRFor2; dRFor3; dRFor4]; %将四组数据组合
    dK=[dKFor1; dKFor2; dKFor3; dKFor4];
    
    distForRK = double(dR)-double(dK); %距离只有可能出现 0相同 +-1 距离差1  +-2 距离完全不同 只有可能有这三类值
    distForRK(distForRK == 1 | distForRK == -1)=quanZhi; %距离为1 贡献权值
    distForRK(distForRK == 0)=1; % 距离为1 贡献为1
    distForRK(distForRK == 2 |distForRK == -2)=0; % 距离为2 贡献为0

%输出长度和权值
    num = length(distForRK);
    score=sum(distForRK)/num*100;
end

