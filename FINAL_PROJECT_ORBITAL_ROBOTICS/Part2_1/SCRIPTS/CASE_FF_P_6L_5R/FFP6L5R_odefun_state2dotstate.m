function dot_state = odefun_state_2_dotstate(t, state,  ControlActions,robot,k,data)
R_T=6371*10^3;
mu=3.98600*10^14;
height=500*10^3+R_T;
m=15;
m0=100;
% CONFIGURATION AT TIME t, provided by the numerical integrator  
% state(i,1)     q_IB(1) at t
% state(i,2)     q_IB(2) at t
% state(i,3)     q_IB(3) at t 
% state(i,4)     q_IB(4) at t    
% state(i,5)     I_r_B(1) at t 
% state(i,6)     I_r_B(2) at t
% state(i,7)     I_r_B(3) at t  
% state(i,8)     qm_1 at t  
% state(i,9)     qm_2 at t 
% state(i,10)    qm_3 at t  
% state(i,11)    qm_4 at t 
% state(i,12)    qm_5 at t  
%
% VELOCITY AT TIME t_out(i,1), provided by the numerical integrator    
% state(i,13)    I_Omega_BI(1) at t  
% state(i,14)    I_Omega_BI(2) at t   
% state(i,15)    I_Omega_BI(3) at t   
% state(i,16)    I_dot_r_B(1) at t  
% state(i,17)    I_dot_r_B(2) at t  
% state(i,18)    I_dot_r_B(3)at t  
% state(i,19)    dot_qm_1 at t  
% state(i,20)    dot_qm_2 at t 
% state(i,21)    dot_qm_3 at t  
% state(i,22)    dot_qm_4 at t 
% state(i,23)    dot_qm_5 at t  
% Recover Current Configuration
q_IB=state(1:4);%/norm(state(1:4));
C_IB=quat_DCM(q_IB);
I_r_B=state(5:7);
qm=state(8:12);
% Recover Current Velocity
uB=state(13:18);
um=state(19:23);
% Compute kinematics
[RJ,RL,rJ,I_r_L,e,g]=Kinematics(C_IB,I_r_B,qm,robot);
r_com=Center_of_Mass(I_r_B,I_r_L,robot);
%Inertias in inertial frames
[IB,Im]=I_I(C_IB,RL,robot);
% Compute differential kinematics
[Bij,Bi0,P0,pm]=DiffKinematics(C_IB,I_r_B,I_r_L,e,g,robot);
%Operational Velocities
[tB,tm]=Velocities(Bij,Bi0,P0,pm,uB,um,robot);
%Forward Dynamics
tau_control_B=ControlActions(1:6);
tau_control_joint=ControlActions(7:11);
CoM = Center_of_Mass(I_r_B,I_r_L,robot) ;
% HILL of CoM wrt CCS
h1=CoM/norm(CoM); 
% link
for i=1:5
    C(:,i)=I_r_L(1:3,i);
    f_man(:,i)=-mu*m*h1/(norm(CoM)^2)-...
        mu*(m)*(-CoM+C(:,i))/(norm(CoM)^3)+...
        3*mu*m^2*(h1*dot(h1,(-CoM+C(:,i))))/(norm(CoM))^3;
    
    g_man(:,i)=3*mu*VectProdMatrix(h1)*data.man(i).I*h1/(norm(CoM))^3;
end
% base
C_base=I_r_B(1:3); 
f_base=-mu*m0*h1/(norm(CoM)^2)-...
    mu*(m0)^2*(-CoM+C_base)/(norm(CoM)^3)+...
    3*mu*m0^2*(h1*dot(h1,(-CoM+C_base)))/(norm(CoM))^3;
g_base=3*mu*VectProdMatrix(h1)*data.base.I*h1/(norm(CoM))^3;

wFB=[g_base;f_base];
wF1=[g_man(:,1);f_man(:,1)]; % non-control wrench link 1
wF2=[g_man(:,2);f_man(:,2)]; % non-control wrench link 2
wF3=[g_man(:,3);f_man(:,3)]; % non-control wrench link 3
wF4=[g_man(:,4);f_man(:,4)]; % non-control wrench link 4
wF5=[g_man(:,5);f_man(:,5)]; % non-control wrench link 5
wFm=[wF1,wF2,wF3,wF4,wF5]; % non-control wrench of the manipulator (6x5)

NonControlWrenches = [wFB,wFm];

WB=NonControlWrenches(:, 1);
Wm=NonControlWrenches(:, 2:6);
% WB=zeros(6,1);
% Wm_f=[zeros(6,1),zeros(6,1),zeros(6,1),zeros(6,1),zeros(6,1)];
[uBdot,umdot]=FD(tau_control_B,tau_control_joint,WB,Wm,tB,tm,P0,pm,IB,Im,Bij,Bi0,uB,um,robot);
I_Omega_BI=uB(1:3);
q1=q_IB(1);
q2=q_IB(2);
q3=q_IB(3);
q4=q_IB(4);
dot_q_IB=0.5*[q4,-q3,q2,q1; q3, q4,-q1,q2; -q2, q1,q4,q3; -q1, -q2,-q3,q4]*[-I_Omega_BI(1);-I_Omega_BI(2);-I_Omega_BI(3);0];
% The code finally outputs a matrix of 17 columns, which also corresponds
% to the columns of the state matrix. The propagation is described using a
% formula which we saw during the lessons about quaternions a and
% Differential Kinematics equations.
dot_state=[dot_q_IB;uB(4:6);um;uBdot;umdot];
end









