function kinectLocation( angle,height )
%����Kinect��ƫת�ǶȺ͸߶ȣ��������kinect�ӽ��£��ܿ����ŵ�������룬���ܼ�⵽׼ȷ��ȵ���Զ���룬�Լ���Ӧǰ���������µ�������ȡ�
maxDis=cos(angle/180*pi)*4.5;
maxWid=2*maxDis*tan(35/180*pi);
minDis=height*tan((60-angle)/180*pi);
minWid=2*minDis*tan(35/180*pi);
fprintf('�����������룬�����ȣ���Զ���룬��Զ��ȷֱ�Ϊ��')
minDis
minWid
maxDis
maxWid
end

