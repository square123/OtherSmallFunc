function [ A ] = rotateMat( angle1,angle2,angle3 )
% ����X,Y,Z����ת�Ƕȣ�������������ת����
AA=[1 0 0;0 cos(angle1/180*pi) sin(angle1/180*pi);0 -1*sin(angle1/180*pi) cos(angle1/180*pi)];
BB=[cos(angle2/180*pi) 0 -1*sin(angle2/180*pi);0 1 0;sin(angle2/180*pi) 0 cos(angle2/180*pi)];
CC=[cos(angle3/180*pi) sin(angle3/180*pi) 0;-1*sin(angle3/180*pi) cos(angle3/180*pi) 0;0 0 1];
A=AA*BB*CC;
end

