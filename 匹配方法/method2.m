function [score, num] = method2(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4)
%   基于定量关系匹配的函数
%   

%笨方法 四个序列分别处理 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%将分组的数据转换成距离对 且已经转换成了特征
%处理第一个
    indexFor1 = find(rTabR1);
    rFor1 = rTabR1(indexFor1);
    kFor1 = kTabD1(indexFor1); %选出序列对

    %求差分信息
    if length(rFor1)>2 %边界判断 必须要有三个值 不然则不记录数据
        dRFor1=diff(rFor1); %先把RSSI差分计算出来
        lgKFor1=log10(kFor1+0.000001);%加入一个极小的值防止出现负无穷
        dlgKFor1=diff(lgKFor1);%取对数距离的差分
    else
        dRFor1=[]; %无贡献 因为无法计算定量关系
        dlgKFor1=[];
    end
    
    %计算RSSI差值比和对数距离差值比
    if ~isempty(dRFor1)
    %差分中如果有0 置为0.01 防止以0作为分母出问题 
    dRFor1=dRFor1+0.01;
    dlgKFor1=dlgKFor1+0.01;
    %移位 此时差分数组至少有两个 求比值 为了方便，让每个数组都能重复利用，对于只有两个数据的数组会被利用两次
    shiftRFor1=[dRFor1(2:end); dRFor1(1)];
    shiftKFor1=[dlgKFor1(2:end); dlgKFor1(1)];
    ratioRFor1=dRFor1./shiftRFor1;
    ratioKFor1=dlgKFor1./shiftKFor1;
    else
        ratioRFor1=[];
        ratioKFor1=[];
    end
    
%处理第二个
    indexFor2 = find(rTabR2);
    rFor2 = rTabR2(indexFor2);
    kFor2 = kTabD2(indexFor2); %选出序列对

    %求差分信息
    if length(rFor2)>2 %边界判断 必须要有三个值 不然则不记录数据
        dRFor2=diff(rFor2); %先把RSSI差分计算出来
        lgKFor2=log10(kFor2+0.000001);%加入一个极小的值防止出现负无穷
        dlgKFor2=diff(lgKFor2);%取对数距离的差分
    else
        dRFor2=[]; %无贡献 因为无法计算定量关系
        dlgKFor2=[];
    end
    
    %计算RSSI差值比和对数距离差值比
    if ~isempty(dRFor2)
    %差分中如果有0 置为0.01 防止以0作为分母出问题 
    dRFor2=dRFor2+0.01;
    dlgKFor2=dlgKFor2+0.01;
    %移位 此时差分数组至少有两个 求比值 为了方便，让每个数组都能重复利用，对于只有两个数据的数组会被利用两次
    shiftRFor2=[dRFor2(2:end); dRFor2(1)];
    shiftKFor2=[dlgKFor2(2:end); dlgKFor2(1)];
    ratioRFor2=dRFor2./shiftRFor2;
    ratioKFor2=dlgKFor2./shiftKFor2;
    else
        ratioRFor2=[];
        ratioKFor2=[];
    end

%处理第三个
    indexFor3 = find(rTabR3);
    rFor3 = rTabR3(indexFor3);
    kFor3 = kTabD3(indexFor3); %选出序列对

    %求差分信息
    if length(rFor3)>2 %边界判断 必须要有三个值 不然则不记录数据
        dRFor3=diff(rFor3); %先把RSSI差分计算出来
        lgKFor3=log10(kFor3+0.000001);%加入一个极小的值防止出现负无穷
        dlgKFor3=diff(lgKFor3);%取对数距离的差分
    else
        dRFor3=[]; %无贡献 因为无法计算定量关系
        dlgKFor3=[];
    end
    
    %计算RSSI差值比和对数距离差值比
    if ~isempty(dRFor3)
    %差分中如果有0 置为0.01 防止以0作为分母出问题 
    dRFor3=dRFor3+0.01;
    dlgKFor3=dlgKFor3+0.01;
    %移位 此时差分数组至少有两个 求比值 为了方便，让每个数组都能重复利用，对于只有两个数据的数组会被利用两次
    shiftRFor3=[dRFor3(2:end) ;dRFor3(1)];
    shiftKFor3=[dlgKFor3(2:end); dlgKFor3(1)];
    ratioRFor3=dRFor3./shiftRFor3;
    ratioKFor3=dlgKFor3./shiftKFor3;
    else
        ratioRFor3=[];
        ratioKFor3=[];
    end
    
%处理第四个
    indexFor4 = find(rTabR4);
    rFor4 = rTabR4(indexFor4);
    kFor4 = kTabD4(indexFor4); %选出序列对

    %求差分信息
    if length(rFor4)>2 %边界判断 必须要有三个值 不然则不记录数据
        dRFor4=diff(rFor4); %先把RSSI差分计算出来
        lgKFor4=log10(kFor4+0.000001);%加入一个极小的值防止出现负无穷
        dlgKFor4=diff(lgKFor4);%取对数距离的差分
    else
        dRFor4=[]; %无贡献 因为无法计算定量关系
        dlgKFor4=[];
    end
    
    %计算RSSI差值比和对数距离差值比
    if ~isempty(dRFor4)
    %差分中如果有0 置为0.01 防止以0作为分母出问题 
    dRFor4=dRFor4+0.01;
    dlgKFor4=dlgKFor4+0.01;
    %移位 此时差分数组至少有两个 求比值 为了方便，让每个数组都能重复利用，对于只有两个数据的数组会被利用两次
    shiftRFor4=[dRFor4(2:end) ;dRFor4(1)];
    shiftKFor4=[dlgKFor4(2:end) ;dlgKFor4(1)];
    ratioRFor4=dRFor4./shiftRFor4;
    ratioKFor4=dlgKFor4./shiftKFor4;
    else
        ratioRFor4=[];
        ratioKFor4=[];
    end
    
%组合序列并计算余弦距离 分数不应该是100分 因为存在负值
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

