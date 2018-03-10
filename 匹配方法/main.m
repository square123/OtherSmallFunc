%重写方法

%清空操作
clear;
clc;

%输入参数
dataLength = 14;%要循环的文件次数
knowedMac = 'B0:E2:35:2B:DA:E0';%要匹配的MAC地址

%处理后数据展示（在已知MAC地址的情况下），只展示出现的位置
finallyResult = zeros(dataLength,1);

%大循环处理
for dataForI = 1:dataLength
   
    %导入数据
    kincetName = fopen(strcat(strcat('C:\Users\Administrator\Desktop\9月5日数据清洗\单人\',num2str(dataForI)),'\kinectdata.csv'));
    probeName = fopen(strcat(strcat('C:\Users\Administrator\Desktop\9月5日数据清洗\单人\',num2str(dataForI)),'\probeGet.csv'));
    kdata = textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');%kinect数据
    pdata = textscan(probeName,'%s %s %d %d %d %d','delimiter', ',');%探针数据
    
    %取差集 避免错误 
    delSet = setdiff(pdata{1},kdata{1});
    delSetIndex=[];
    for ii = 1:length(delSet)
        delSetIndex = [delSetIndex;find(strcmp(pdata{1},delSet(ii)))];
    end
    %剔除差集数据
    pdata{1}(delSetIndex,:)=[];pdata{2}(delSetIndex,:)=[];pdata{3}(delSetIndex,:)=[];pdata{4}(delSetIndex,:)=[];pdata{5}(delSetIndex,:)=[];pdata{6}(delSetIndex,:)=[];
    
    %构建MAC地址索引 用于最后的MAC地址识别
    MacName = unique(pdata{2});
    %得到此数据中RSSI序列的个数
    MacNumber = length(MacName);
    %预设MAC地址的表格数据 score num
    MacTable = zeros(2,MacNumber);
    
    %小循环 一次循环完成选取两种特征，构建一个序列对，并计算分数
    for i = 1:MacNumber 
        
        %选出单个MAC的数据表格 表格形式 rTabTime rTabR1 rTabR2 rTabR3 rTabR4
        rTabTime=pdata{1}(strcmp(pdata{2},MacName(i)));
        rTabR1=pdata{3}(strcmp(pdata{2},MacName(i)));
        rTabR2=pdata{4}(strcmp(pdata{2},MacName(i)));
        rTabR3=pdata{5}(strcmp(pdata{2},MacName(i)));
        rTabR4=pdata{6}(strcmp(pdata{2},MacName(i)));
       
        %构建距离数据表格 选出存在时刻的MAC地址 不考虑取与操作 
        respondTimeIndex = [];
        for iii = 1:length(rTabTime)
            respondTimeIndex = [respondTimeIndex;find(strcmp(kdata{1},rTabTime(iii)))];
        end
        kTabTime=kdata{1}(respondTimeIndex);
        kTabD1=kdata{3}(respondTimeIndex);
        kTabD2=kdata{4}(respondTimeIndex);
        kTabD3=kdata{5}(respondTimeIndex);
        kTabD4=kdata{6}(respondTimeIndex);
    
        %小函数 输入表格数据 输出匹配分数  [score, num]=method1(rTabTime,rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            %方法1
            %[score, num]=method1(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            %方法2
            [score, num]=method2(rTabR1,rTabR2,rTabR3,rTabR4,kTabD1,kTabD2,kTabD3,kTabD4);
            
        %将MAC地址对应的分数和长度记录下
        MacTable(1,i) = score;MacTable(2,i) = num;
    end
    
    %可信度模型构建 
    maxNum = max(MacTable(2,:));
    beta = 0.5*maxNum;
    alpha = -(log(1/0.99 - 1))/(0.8*maxNum);
    weight = 1./(1+exp((-alpha).*(MacTable(2,:)-beta)));
    %重新计算分数
    finalScore = MacTable(1,:).*weight;
    % 论文里面没有的步骤 因为相关系数会出现负数，但负数实际上是比没有数据要更好的值，因此将没数据的序列直接置负数
    finalScore(MacTable(2,:)==0)=-10;
    %排序 记住是降序排列
    [ ~ ,scoreIndex] = sort(finalScore,'descend');
    sortMacName = MacName(scoreIndex);
    %测试正确MAC地址出现的位置并记录下来
    finallyResult(dataForI) = find(strcmp(sortMacName,knowedMac));
    fclose(kincetName);%关闭文件
    fclose(probeName); %关闭文件
end

