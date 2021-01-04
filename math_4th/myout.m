function stop=myout(x,optimValues,state), stop=false;
switch state %开关结构，监视中间结果
   case 'init', hold on %初始化响应：设置坐标系保护
   case 'iter', plot(x(1),x(2),'o'), %迭代响应：将中间结果用圆圈表示
      text(x(1)+0.1,x(2),int2str(optimValues.iteration)); %在图上标出迭代步数
   case 'done', hold off %结束监控过程：取消坐标系保护
end