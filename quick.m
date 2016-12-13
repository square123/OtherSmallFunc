output_max=zeros(9,4);%用最大方法得到的
output_norm=zeros(9,4);%用高斯方法得到的
fileForm = 'C:\Users\正爱上方\Desktop\其他验证测试集 - 副本\jin_';%可以修改的路径
a=cell(1,9);
for i=1:9
    fileName=strcat(strcat(fileForm,num2str(i)),'.txt');
    a{i}=importdata(fileName);
    Mac1=[];%'F0:25:B7:C1:07:97'
    Mac2=[];%'B0:E2:35:2B:DA:E0'
    Mac3=[];%'00:EE:BD:00:03:F1'
    Mac4=[];%'D0:E1:40:CD:6E:3E'
    for j=1:size(a{i},1)
        if(a{i}{j}(17:33)=='F0:25:B7:C1:07:97')
            Mac1=[Mac1 str2double(a{i}{j}(13:15))];
        elseif(a{i}{j}(17:33)=='B0:E2:35:2B:DA:E0')
            Mac2=[Mac2 str2double(a{i}{j}(13:15))];
        elseif(a{i}{j}(17:33)=='00:EE:BD:00:03:F1')
            Mac3=[Mac3 str2double(a{i}{j}(13:15))];
        elseif(a{i}{j}(17:33)=='D0:E1:40:CD:6E:3E')
            Mac4=[Mac4 str2double(a{i}{j}(13:15))];
        end
    end
    output_max(i,1)=selRSSI(Mac1);
    output_norm(i,1)=NormSelRSSI(Mac1);
    output_max(i,2)=selRSSI(Mac2);
    output_norm(i,2)=NormSelRSSI(Mac2);
    output_max(i,3)=selRSSI(Mac3);
    output_norm(i,3)=NormSelRSSI(Mac3);
    output_max(i,4)=selRSSI(Mac4);
    output_norm(i,4)=NormSelRSSI(Mac4);
end








