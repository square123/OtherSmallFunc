[m,n]=size(X);%m������ݣ�n����ָ�����
%��һ�� ��׼��
Y=zeros(m,n);%YΪ��׼���������
minX=min(X);
maxX=max(X);
delX=maxX-minX;
for i=1:m
    for j=1:n
        Y(i,j)=0.1+0.9*((X(i,j)-minX(j))/delX(j));
    end
end
%�ڶ��� ���㲻ָͬ���Ӱ��̶�
r=zeros(n,n);
for i=1:n%�������ϵ��r
    for j=1:n
        temp=corrcoef(Y(:,i),Y(:,j));
        r(i,j)=temp(1,2);
    end
end
sTemp=sum(Y,2);
s=zeros(m,n);%����S
for k=1:m
    for j=1:n
        s(k,j)=Y(k,j)/sTemp(k);
    end
end
b=zeros(m,n);
for k=1:m
    for j=1:n
        for i=1:n
            if(i~=j)
                 b(k,j)=b(k,j)+r(j,i)*s(k,i);
            end
        end
    end
end
%������ ����Эͬ��
c=zeros(m,n);
cTemp=sum(b,2);
for k=1:m
    for j=1:n
        c(k,j)=b(k,j)/cTemp(k);
    end
end


