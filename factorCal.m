function [ w ] = factorCal(X)%����ľ�Ϊ����ָ��ľ���
[m,n]=size(X);%m������ݣ�n����ָ�����
%��һ�� ��׼��
Y=zeros(m,n);
minX=min(X);
maxX=max(X);
delX=maxX-minX;
for i=1:m
    for j=1:n
        Y(i,j)=0.1+0.9*((X(i,j)-minX(j))/delX(j));
    end
end
%�ڶ�����ȷ��Ȩֵ
%(1)
sumY=sum(Y);
SumY=1./sumY;
f=diag(SumY);
P=Y*f;
%(2)
logP=log(P);
ff=logP.*P;
E=-(1/log(m))*sum(ff,1);
%(3)
w=(1-E)./sum(1-E);
end

