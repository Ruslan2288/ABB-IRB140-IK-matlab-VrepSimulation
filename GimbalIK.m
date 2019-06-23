function th = GimbalIK(x,y,z)
%% DH param
b=[75,60,0]/1000;%b3-variable
a=[40,40,0]/1000;
alpha=[pi/2,-pi/2,0];
q=[-pi/2,0,0];
%% main
r=sqrt(x^2+y^2);
d=z-b(1);
b(3)=sqrt(d^2+r^2-(sin(alpha(2))*b(2))^2-(a(2)+a(3))^2)-cos(alpha(2))*b(2);

fi=atan2(y,x);
h=b(2)+cos(alpha(2))*b(3);
beta=atan2(h,sqrt(r^2-h^2));
th11=fi+beta;
th12=fi-beta+pi;
f=sqrt(r^2-h^2)-a(1);

v=atan2(d,f);
s=atan2(sin(alpha(2))*b(3),a(2)+a(3));
th21=s+v;
th22=s-v-pi;

%% Sol
th(1)=th11+q(1)+pi;
th(2)=th21+q(2)+pi/2;
th(3)=0;

%%
function out= constrain(param,min,max)
    if param<min*pi/180
        out=min;
    elseif param>max*pi/180
        out=max;
    else
        out=param;
    end   
    
end
end

