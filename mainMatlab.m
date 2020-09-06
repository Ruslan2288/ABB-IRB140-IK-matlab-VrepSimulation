
    % vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
    vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    vrep.simxFinish(-1); % just in case, close all opened connections
    clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
    while clientID <=-1
 
    disp('Failed connecting to remote API server');
    pause(1);
    clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

    end
     disp('Connected to remote API server');
% vrep.simxSynchronous(clientID, true);
        objs=zeros(1,6);

        [res objs(1)]=vrep.simxGetObjectHandle(clientID,'R1',vrep.simx_opmode_oneshot_wait);
        [res objs(2)]=vrep.simxGetObjectHandle(clientID,'R2',vrep.simx_opmode_oneshot_wait);
        [res,objs(3)]=vrep.simxGetObjectHandle(clientID,'R3',vrep.simx_opmode_oneshot_wait);
        [res objs(4)]=vrep.simxGetObjectHandle(clientID,'R4',vrep.simx_opmode_oneshot_wait);
        [res objs(5)]=vrep.simxGetObjectHandle(clientID,'R5',vrep.simx_opmode_oneshot_wait);
        [res objs(6)]=vrep.simxGetObjectHandle(clientID,'R6',vrep.simx_opmode_oneshot_wait);

        q=zeros(1,6);
        pos=zeros(1,6);
        f=zeros(1,6);
        p=[0.55,0.5,0.33];

   
   t=0;
   while t<=3600
        
        x=0.2*cos(t)+0.6;
        y=0.2*sin(t);
        z=0.4;
        
        q=IK(x,y,z,0,0,0);
%      x=0.5;
%      y=0;
%      z=0.7;

    for i=1:5

        f(i)=vrep.simxSetJointPosition(clientID,objs(i),q(i),vrep.simx_opmode_oneshot);

    end
    pause(h);
   t=t+h;
  
 end

   
   