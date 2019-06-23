function q = IK_IRB140(x,y,z,alpha,beta,gama) 
% x=0.3;
% y=0.3;
% z=0.2;
% alpha=0;
% beta=0;
% gama=0;

d1 = 0.352;
a1 = 0.070;
a2 = 0.360;
d4 = 0.380;
d6=0.065;

NOSOLUTION=1000;

R60 = [cos(alpha).*cos(beta), (cos(alpha).*sin(beta).*sin(gama))- sin(alpha).*cos(gama),(cos(alpha).*sin(beta).*cos(gama)) + sin(alpha).*sin(gama) ;
 sin(alpha).*cos(beta), (sin(alpha).*sin(beta).*sin(gama)) + cos(alpha).*cos(gama),(sin(alpha).*sin(beta).*cos(gama)) - cos(alpha).*sin(gama) ;
 - sin(beta), cos(beta).*sin(gama), cos(beta).*sin(gama)];

p06=[x,y,z];
p04=p06-transpose(d6*R60*[0;0;1]);

x=p04(1);
y=p04(2);
z=p04(3);



Q1= atan2 (y,x);
Q11= pi + Q1;


s = z - d1;
r = sqrt((x - a1*cos (Q1))^2 +(y - a1*sin(Q1))^2);
czeta = (r^2 + s^2 - (a2)^2 - (d4 + d6)^2)/(2 * a2 *(d4 + d6));
    szeta = sqrt(1-(czeta)^2);
    szeta1 = -szeta;
    zeta= atan2(szeta,czeta);
    zeta1= atan2(szeta1,czeta);
if (abs(czeta) <= 1)
  
    Q3 =  -(pi/2+zeta);
    Q33 = -(pi/2 + zeta1);
    Q3 = conversion( Q3,50,-230);
    Q33 = conversion( Q33,50,-230);
else
    Q3 = NOSOLUTION; 
    Q33= NOSOLUTION;
end


s = (z - d1);
r = sqrt((x - a1*cos (Q11))^2 +(y - a1*sin(Q11))^2);
czetai = (r^2 + s^2 - (a2)^2 - (d4 + d6)^2)/(2 * a2 *(d4 + d6));
    
    szetai = sqrt(1-(czetai)^2);
    szeta1i = -szetai;
    zetai= atan2(szetai,czetai);
    zeta1i= atan2(szeta1i,czetai);
if (abs(czetai) <= 1)
   
    Q3i = -(pi/2 + zetai);
    Q33i = -(pi/2 + zeta1i);
    Q3i = conversion( Q3i,50,-230);
    Q33i = conversion( Q33i,50,-230);
else
    Q3i=NOSOLUTION;
    Q33i=NOSOLUTION; 
end




if (Q3 == NOSOLUTION)
    Q2 = NOSOLUTION;
    Q22 = NOSOLUTION;
else
    Q2 = THE2(x,y,z,Q1,zeta);
    Q22 = THE2COMP(x,y,z,Q1,zeta);
    Q2 = conversion( Q2,110,-90);
    Q22 = conversion( Q22,110,-90);
end



if (Q33 == NOSOLUTION)
    Q2i = NOSOLUTION;
    Q22i = NOSOLUTION;
else
    Q2i = THE2(x,y,z,Q1,zeta1);
    Q22i = THE2COMP(x,y,z,Q1,zeta1);
    Q2i = conversion( Q2i,110,-90);
    Q22i = conversion( Q22i,110,-90);
end

if (Q3i == NOSOLUTION)
    Q2j = NOSOLUTION;
    Q22j = NOSOLUTION;
else
    Q2j = THE2(x,y,z,Q11,zetai); 
    Q22j = THE2COMP(x,y,z,Q11,zetai);
    Q2j = conversion( Q2j,100,-90);
    Q22j = conversion( Q22j,100,-90);
end



if (Q33i == NOSOLUTION)
    Q2k = NOSOLUTION;
    Q22k = NOSOLUTION;
else
    Q2k = THE2(x,y,z,Q11,zeta1i);
    Q22k = THE2COMP(x,y,z,Q11,zeta1i);
    Q2k = conversion( Q2k,110,-90);
    Q22k = conversion( Q22k,110,-90);
end


SOL1 =[ Q1, Q2, Q3];
SOL2 =[ Q1, Q22,Q3];
SOL3 =[ Q1, Q2i, Q33];
SOL4 =[ Q1, Q22i, Q33];
SOL5 =[ Q11, Q2j, Q3i];
SOL6 =[ Q11, Q22j, Q3i];
SOL7 =[ Q11, Q2k, Q33i];
SOL8 =[ Q11, Q22k, Q33i];

SOLUTION=[SOL1;SOL2;SOL3;SOL4;SOL5;SOL6;SOL7;SOL8];

% for i=1:length(SOLUTION)
%     if max(SOLUTION(i,1:end))~=NOSOLUTION
%     q1=SOLUTION(i,1);
%     q2=SOLUTION(i,2);
%     q3=SOLUTION(i,3);
%     break
%     end
%     disp('No solutions1');
% end
   q1=SOL1(1);
   q2=SOL1(2);
   q3=SOL1(3);

R30 = [cos(q1).*cos(q2+q3), -cos(q1).*sin(q2+q3), sin(q1);
 sin(q1).*cos(q2+q3), -sin(q1).*sin(q2+q3), cos(q1);
 -sin(q2+q3), -cos(q2+q3), 0 ] ;
 
RT30= transpose (R30);
R63 = RT30 * R60 ;
g11 = R63 (1,1);
g12 = R63 (1,2);
g23 = R63 (2,3);
g31 = R63 (3,1);
g32 = R63 (3,2);
g33 = R63 (3,3);


Q5 = atan2 ( sqrt((g31)^2 +(g32)^2), g33);
if(Q5 == 0)
    q4= 0;
    q5= 0;
    q6 = atan2 (-g12, g11);
elseif (Q5 == pi)
    q4= 0;
    q5= 0;
    q6 = atan2 (g12,-g11);
else
    Q4 = atan2 (g32/ sin (Q5), - g31/ sin (Q5));
    Q6 = atan2 (g23/ sin (Q5), g31/ sin (Q5));
    Q4= conversion( Q4,200,-200);
    Q5= conversion( Q5,115,-115);
    Q6= conversion( Q6,400,-400);


    Q44 = Q4 + pi;
    Q55 = -Q5;
    Q66 = Q6+pi;
    Q44= conversion( Q44,200,-200);
    Q55= conversion( Q55,115,-115);
    Q66= conversion( Q66,400,-400);

    Solution1 = [Q4,Q5,Q6];
    Solution2 = [Q44,Q55,Q66];
    
    SOLUTION2=[Solution1;Solution2];
    
%     for i=1:2
%         if max(SOLUTION2(i,1:end))~=NOSOLUTION
%             q4=SOLUTION2(i,1);
%             q5=SOLUTION2(i,2);
%             q6=SOLUTION2(i,3);
%             break
%         end
%         disp('No solutions2');
%     end
 q4=Solution1(1);
 q5=Solution1(2);
 q6=Solution1(3);
end

q=zeros(1,6);

q(1)=q1;
q(2)=q2;
q(3)=pi-q3;
q(4)=q4;
q(5)=q5;
q(6)=q6;



function RES = THE2(xtip,ytip,ztip,theta1,zeta)
    s = (ztip - d1);
    r = sqrt((xtip - a1*cos (theta1))^2 +(ytip - a1*sin(theta1))^2);
    omega = atan2 (s, r);
    lenda = atan2 (( d4+d6) * sin (zeta) , a2+( d4+d6)* cos (zeta));
    RES = - ((omega - lenda)- ( pi/2)) ;
end


function RES1 = THE2COMP(xtip,ytip,ztip,theta1,zeta)
    s = (ztip - d1);
    r = - sqrt((xtip - a1*cos (theta1))^2 +(ytip - a1*sin(theta1))^2);
    omega = atan2 (s, r);
    lenda = atan2 (( d4+d6) * sin (zeta) , a2+( d4+d6)* cos (zeta));
    RES1 = - ((omega - lenda) - ( pi/2));
end

function OUT = conversion( theta,upperlimit,lowerlimit)
    upperlimit = upperlimit * pi / 180;
    lowerlimit = lowerlimit * pi / 180;
    if (theta > upperlimit)
        OUT = NOSOLUTION;
    elseif (theta < lowerlimit)
        OUT = NOSOLUTION;
    else
        OUT = theta;
    end
end
end
