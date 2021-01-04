function [sol,y]=c10mga1(sol,options)
x=sol(1); y=x.*sin(10*pi*x)+2; %为本例编写的目标函数计算函数