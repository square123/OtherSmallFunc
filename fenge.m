kincetName=fopen('C:\Users\Administrator\Desktop\529\1-\cc.csv');
kdata=textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');
temp=kdata{:,1};
utemp=unique(temp);
filename1 = 'C:\Users\Administrator\Desktop\529\1-\1jh.csv';
filename2 = 'C:\Users\Administrator\Desktop\529\1-\2man.csv';
fid1 = fopen(filename1, 'w');
fid2 = fopen(filename2, 'w');
for i=1:length(utemp)%肯定只有两个标号了，所以可以直接删掉，当然之前还需要在再检查下
    
    uu=find(strcmp(temp,utemp(i))==1);
    if(kdata{1,3}(uu(1))>=kdata{1,3}(uu(2)))
        fprintf(fid1, ['%s', ',', '%d', ',', '%d', ',', '%d', ',', '%d', ',', '%d', '\n'],  kdata{1,1}{uu(1)},kdata{1,2}(uu(1)),kdata{1,3}(uu(1)),kdata{1,4}(uu(1)),kdata{1,5}(uu(1)),kdata{1,6}(uu(1)));
        fprintf(fid2, ['%s', ',', '%d', ',', '%d', ',', '%d', ',', '%d', ',', '%d', '\n'],  kdata{1,1}{uu(2)},kdata{1,2}(uu(2)),kdata{1,3}(uu(2)),kdata{1,4}(uu(2)),kdata{1,5}(uu(2)),kdata{1,6}(uu(2)));
    else
        fprintf(fid2, ['%s', ',', '%d', ',', '%d', ',', '%d', ',', '%d', ',', '%d', '\n'],  kdata{1,1}{uu(1)},kdata{1,2}(uu(1)),kdata{1,3}(uu(1)),kdata{1,4}(uu(1)),kdata{1,5}(uu(1)),kdata{1,6}(uu(1)));
        fprintf(fid1, ['%s', ',', '%d', ',', '%d', ',', '%d', ',', '%d', ',', '%d', '\n'],  kdata{1,1}{uu(2)},kdata{1,2}(uu(2)),kdata{1,3}(uu(2)),kdata{1,4}(uu(2)),kdata{1,5}(uu(2)),kdata{1,6}(uu(2)));
    end
end





fclose(fid1);
fclose(fid2);