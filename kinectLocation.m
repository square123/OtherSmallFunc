function kinectLocation( angle,height )
%输入Kinect的偏转角度和高度，输出距离kinect视角下，能看到脚的最近距离，可能检测到准确深度的最远距离，以及对应前两个距离下的两个宽度。
maxDis=cos(angle/180*pi)*4.5;
maxWid=2*maxDis*tan(35/180*pi);
minDis=height*tan((60-angle)/180*pi);
minWid=2*minDis*tan(35/180*pi);
fprintf('输出的最近距离，最近宽度，最远距离，最远宽度分别为：')
minDis
minWid
maxDis
maxWid
end

