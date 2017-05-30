kincetName=fopen('C:\Users\Administrator\Desktop\529\1-\cameradata.csv');
kdata=textscan(kincetName,'%s %d %f %f %f %f','delimiter', ',');
temp=kdata{:,1};
utemp=unique(temp);
for i=length(utemp):-1:1
    if( length(find(strcmp(temp,utemp(i))==1))~=2)%ÌÞ³ý²»ÊÇ2µÄ
        uu=find(strcmp(temp,utemp(i))==1)
        for j=length(uu):-1:1
        kdata{1,1}(uu(j))=[];
        kdata{1,2}(uu(j))=[];
        kdata{1,3}(uu(j))=[];
        kdata{1,4}(uu(j))=[];
        kdata{1,5}(uu(j))=[];
        kdata{1,6}(uu(j))=[];
        end
    end
end
length(kdata{1,1})
filename = 'C:\Users\Administrator\Desktop\529\1-\cc.csv';
fid = fopen(filename, 'w');
for row=1:length(kdata{1,1})
    fprintf(fid, ['%s', ',', '%d', ',', '%d', ',', '%d', ',', '%d', ',', '%d', '\n'],  kdata{1,1}{row},kdata{1,2}(row),kdata{1,3}(row),kdata{1,4}(row),kdata{1,5}(row),kdata{1,6}(row));
end
fclose(fid);