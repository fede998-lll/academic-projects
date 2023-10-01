
disp('0: Fixed Joint')
disp('1: Revolute Joint')
disp('2: Prismatic Joint')
Joint=input('Please, insert the desired option: ');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                           %% INPUT DATA %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m0=100; %Kg
l0=0.45; %m
m1=15; %Kg
l1=0.3; %m
m2=15;
l2=0.3; %m
m3=15;
l3=0.3;
m4=15;
l4=0.3;
m5=15;
l5=0.3;
s1=0.02; %width of manipulator (hp: parallelepiped box)
base_side_L0=2*l0;
man_side_L1=2*l1;
man_side_L2=2*l2;
man_side_L3=2*l3;
man_side_L4=2*l4;
man_side_L5=2*l5;
man_width=s1;
%Number of joints
data.n=5;
data.base.mass=m0;
data.base.I=diag([1,1,data.base.mass/6*(base_side_L0^2)]);
data.base.T_L0_J1=[eye(3),[+base_side_L0/2;0;0];zeros(1,3),1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         %% JOINT SELECTION %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Joint==0
    data.man(1).type=0; % Fixed Joint
    data.man(2).type=0;
    data.man(3).type=0;
    data.man(4).type=0;
    data.man(5).type=0;
end
if Joint==1
    data.man(1).type=1; % Revolute Joint
    data.man(2).type=1;
    data.man(3).type=1;
    data.man(4).type=1;
    data.man(5).type=1;
end
if Joint==2
    data.man(1).type=2; % Prismatic Joint
    data.man(2).type=2;
    data.man(3).type=2;
    data.man(4).type=2;
    data.man(5).type=2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %% ROBOT STRUCTURE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                         
% displacement/translation along z-axis
data.man(1).DH.d=0;
data.man(2).DH.d=0;
data.man(3).DH.d=0;
data.man(4).DH.d=0;
data.man(5).DH.d=0;
% Angular velocity along the z-axis
data.man(1).DH.alpha=0;
data.man(2).DH.alpha=0;
data.man(3).DH.alpha=0;
data.man(4).DH.alpha=0;
data.man(5).DH.alpha=0;
% manipulators' lengths
data.man(1).DH.a=man_side_L1;
data.man(2).DH.a=man_side_L2;
data.man(3).DH.a=man_side_L3;
data.man(4).DH.a=man_side_L4;
data.man(5).DH.a=man_side_L5;
% Initial angle of rotation around z-axis
data.man(1).DH.theta=0;
data.man(2).DH.theta=0;
data.man(3).DH.theta=0;
data.man(4).DH.theta=0;
data.man(5).DH.theta=0;
data.man(1).b=[data.man(1).DH.a/2;0;0];
data.man(2).b=[data.man(2).DH.a/2;0;0];
data.man(3).b=[data.man(3).DH.a/2;0;0];
data.man(4).b=[data.man(4).DH.a/2;0;0];
data.man(5).b=[data.man(5).DH.a/2;0;0];
data.man(1).mass=m1;
data.man(2).mass=m2;
data.man(3).mass=m3;
data.man(4).mass=m4;
data.man(5).mass=m5;
data.man(1).I=diag([1,1,data.man(1).mass/12*(data.man(1).DH.a^2+man_width^2)]);
data.man(2).I=diag([1,1,data.man(2).mass/12*(data.man(2).DH.a^2+man_width^2)]);
data.man(3).I=diag([1,1,data.man(3).mass/12*(data.man(3).DH.a^2+man_width^2)]);
data.man(4).I=diag([1,1,data.man(4).mass/12*(data.man(4).DH.a^2+man_width^2)]);
data.man(5).I=diag([1,1,data.man(5).mass/12*(data.man(5).DH.a^2+man_width^2)]);
%End-Effector initial conditions
data.EE.theta=0; %Rotation around z-axis
data.EE.d=0; %Translation along z-axis
%--- Create robot structure ---%
[robot,TEE_Ln]=DH_Serial2robot(data);



















