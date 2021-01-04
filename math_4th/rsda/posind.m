function [p,q]=posind(c,d,x)% 
qq=ind(d,x); pp=ind(c,x); [p,q]=pospq(pp,qq);
