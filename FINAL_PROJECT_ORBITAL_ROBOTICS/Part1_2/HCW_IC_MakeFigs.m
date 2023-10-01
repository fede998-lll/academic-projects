clc
clear all
close all
colordef black
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                           %% INPUTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
% It's been given the user the choice to select the z-variation in order to
% visualize all final results over a 3D or 2D final path.
choice=input('Please, insert z variation: ');
q=1;
h=500*10^3;
R_T=6371*10^3;
mu=398600*10^9;
r=R_T+h;
omega=sqrt(mu/r^3);
A=[
    0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    3*omega^2 0 0 0 2*omega 0;
    0 0 0 -2*omega 0 0;
    0 0 -omega^2 0 0 0;
];
% It's been considered the unforced case, so considering always the effect
% of the state transition matrix A and not that of Convolution B, which is 
% instead referred to the control input.
phi=@(t) expm(A*t);
X=@(t,X0) phi(t)*X0;
T=2*pi*sqrt(r^3/mu);
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% MOTION OF THE INTERCEPTOR FOR VARIOUS x_0 DISPLACEMENTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% It's been decided to save all displacements' results in order to let the
% user visualizing the effects correlated to specific initial conditions.
% The time will be defined into different values and lengths in order to 
% obtain all the graphs shown in the slides.
t=linspace(0,2*T);
X0_1=[+5 0 choice 0 0 0]';
X0_2=[-5 0 choice 0 0 0]';
X0_3=[+10 0 choice 0 0 0]';
X0_4=[-10 0 choice 0 0 0]';
X0_5=[+50 0 choice 0 0 0]';
X0_6=[-50 0 choice 0 0 0]';
X0_7=[+100 0 choice 0 0 0]';
X0_8=[-100 0 choice 0 0 0]';
X0_9=[+500 0 choice 0 0 0]';
X0_10=[-500 0 choice 0 0 0]';
X_t_1=zeros(length(X0_1),length(t));
X_t_2=zeros(length(X0_2),length(t));
X_t_3=zeros(length(X0_3),length(t));
X_t_4=zeros(length(X0_4),length(t));
X_t_5=zeros(length(X0_5),length(t));
X_t_6=zeros(length(X0_6),length(t));
X_t_7=zeros(length(X0_7),length(t));
X_t_8=zeros(length(X0_8),length(t));
X_t_9=zeros(length(X0_9),length(t));
X_t_10=zeros(length(X0_10),length(t));
for i=1:length(t)
    X_t_1(:,i)=X(t(i),X0_1);
    X_t_2(:,i)=X(t(i),X0_2);
    X_t_3(:,i)=X(t(i),X0_3);
    X_t_4(:,i)=X(t(i),X0_4);
    X_t_5(:,i)=X(t(i),X0_5);
    X_t_6(:,i)=X(t(i),X0_6);
    X_t_7(:,i)=X(t(i),X0_7);
    X_t_8(:,i)=X(t(i),X0_8);
    X_t_9(:,i)=X(t(i),X0_9);
    X_t_10(:,i)=X(t(i),X0_10);
end
figure(q)
q=q+1;
plot3(X_t_1(2,:),X_t_1(1,:),X_t_1(3,:),'w-',LineWidth=2)
hold on
plot3(X_t_2(2,:),X_t_2(1,:),X_t_2(3,:),'w--',LineWidth=2)
hold on
plot3(X_t_3(2,:),X_t_3(1,:),X_t_3(3,:),'g-',LineWidth=2)
hold on
plot3(X_t_4(2,:),X_t_4(1,:),X_t_4(3,:),'g--',LineWidth=2)
hold on
plot3(X_t_5(2,:),X_t_5(1,:),X_t_5(3,:),'y-',LineWidth=2)
hold on
plot3(X_t_6(2,:),X_t_6(1,:),X_t_6(3,:),'y--',LineWidth=2)
hold on
plot3(X_t_7(2,:),X_t_7(1,:),X_t_7(3,:),'c-',LineWidth=2)
hold on
plot3(X_t_8(2,:),X_t_8(1,:),X_t_8(3,:),'c--',LineWidth=2)
hold on
plot3(X_t_9(2,:),X_t_9(1,:),X_t_9(3,:),'r-',LineWidth=2)
hold on
plot3(X_t_10(2,:),X_t_10(1,:),X_t_10(3,:),'r--',LineWidth=2)
grid minor
xlabel('Y [m]','Interpreter','latex')
ylabel('X [m]','Interpreter','latex')
zlabel('Z [m]','Interpreter','latex')
axis([-3000 +3000 -2000 +2000])
title('Motion for various $x_0$ displacements','Interpreter','latex')
legend('$x_0$ = +5','$x_0$ = -5','$x_0$ = +10','$x_0$ = -10','$x_0$ = +50','$x_0$ = -50','$x_0$ = +100','$x_0$ = -100','$x_0$ = +500','$x_0$ = -500','Interpreter','latex',Location='northeast')
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %% MOTION OF THE INTERCEPTOR FOR x_0_dot VARIATIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=linspace(0,T);
X0_11=[0 0 choice +0.5 0 0]';
X0_12=[0 0 choice -0.5 0 0]';
X0_13=[0 0 choice +1 0 0]';
X0_14=[0 0 choice -1 0 0]';
X0_15=[0 0 choice +5 0 0]';
X0_16=[0 0 choice -5 0 0]';
X0_17=[0 0 choice +10 0 0]';
X0_18=[0 0 choice -10 0 0]';
X0_19=[0 0 choice +50 0 0]';
X0_20=[0 0 choice -50 0 0]';
X_t_11=zeros(length(X0_11),length(t));
X_t_12=zeros(length(X0_12),length(t));
X_t_13=zeros(length(X0_13),length(t));
X_t_14=zeros(length(X0_14),length(t));
X_t_15=zeros(length(X0_15),length(t));
X_t_16=zeros(length(X0_16),length(t));
X_t_17=zeros(length(X0_17),length(t));
X_t_18=zeros(length(X0_18),length(t));
X_t_19=zeros(length(X0_19),length(t));
X_t_20=zeros(length(X0_20),length(t));
for i=1:length(t)
    X_t_11(:,i)=X(t(i),X0_11);
    X_t_12(:,i)=X(t(i),X0_12);
    X_t_13(:,i)=X(t(i),X0_13);
    X_t_14(:,i)=X(t(i),X0_14);
    X_t_15(:,i)=X(t(i),X0_15);
    X_t_16(:,i)=X(t(i),X0_16);
    X_t_17(:,i)=X(t(i),X0_17);
    X_t_18(:,i)=X(t(i),X0_18);
    X_t_19(:,i)=X(t(i),X0_19);
    X_t_20(:,i)=X(t(i),X0_20);
end
figure(q)
q=q+1;
plot3(X_t_11(2,:),X_t_11(1,:),X_t_11(3,:),'w-',LineWidth=2)
hold on
plot3(X_t_12(2,:),X_t_12(1,:),X_t_12(3,:),'w--',LineWidth=2)
hold on
plot3(X_t_13(2,:),X_t_13(1,:),X_t_13(3,:),'g-',LineWidth=2)
hold on
plot3(X_t_14(2,:),X_t_14(1,:),X_t_14(3,:),'g--',LineWidth=2)
hold on
plot3(X_t_15(2,:),X_t_15(1,:),X_t_15(3,:),'y-',LineWidth=2)
hold on
plot3(X_t_16(2,:),X_t_16(1,:),X_t_16(3,:),'y--',LineWidth=2)
hold on
plot3(X_t_17(2,:),X_t_17(1,:),X_t_17(3,:),'c-',LineWidth=2)
hold on
plot3(X_t_18(2,:),X_t_18(1,:),X_t_18(3,:),'c--',LineWidth=2)
hold on
plot3(X_t_19(2,:),X_t_19(1,:),X_t_19(3,:),'r-',LineWidth=2)
hold on
plot3(X_t_20(2,:),X_t_20(1,:),X_t_20(3,:),'r--',LineWidth=2)
grid minor
xlabel('Y [m]','Interpreter','latex')
ylabel('X [m]','Interpreter','latex')
zlabel('Z [m]','Interpreter','latex')
axis([-3000 +3000 -2000 +2000])
title('Motion for various $\dot{x_0}$ variations','Interpreter','latex')
legend('$x_0$ = +0.5','$x_0$ = -0.5','$x_0$ = +1','$x_0$ = -1','$x_0$ = +5','$x_0$ = -5','$x_0$ = +10','$x_0$ = -10','$x_0$ = +50','$x_0$ = -50','Interpreter','latex',Location='bestoutside')
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %% MOTION OF THE INTERCEPTOR FOR y_0_dot VARIATIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=linspace(0,1.4*T);
X0_21=[0 0 choice 0 0.113 0]';
X0_22=[0 0 choice 0 -0.113 0]';
X0_23=[0 0 choice 0 0.25 0]';
X0_24=[0 0 choice 0 -0.25 0]';
X0_25=[0 0 choice 0 0.5 0]';
X0_26=[0 0 choice 0 -0.5 0]';
X0_27=[0 0 choice 0 1 0]';
X0_28=[0 0 choice 0 -1 0]';
X0_29=[0 0 choice 0 5 0]';
X0_30=[0 0 choice 0 -5 0]';
X0_31=[0 0 choice 0 10 0]';
X0_32=[0 0 choice 0 -10 0]';
X0_33=[0 0 choice 0 50 0]';
X0_34=[0 0 choice 0 -50 0]';
X_t_21=zeros(length(X0_21),length(t));
X_t_22=zeros(length(X0_22),length(t));
X_t_23=zeros(length(X0_23),length(t));
X_t_24=zeros(length(X0_24),length(t));
X_t_25=zeros(length(X0_25),length(t));
X_t_26=zeros(length(X0_26),length(t));
X_t_27=zeros(length(X0_27),length(t));
X_t_28=zeros(length(X0_28),length(t));
X_t_29=zeros(length(X0_29),length(t));
X_t_30=zeros(length(X0_30),length(t));
X_t_31=zeros(length(X0_31),length(t));
X_t_32=zeros(length(X0_32),length(t));
X_t_33=zeros(length(X0_32),length(t));
X_t_34=zeros(length(X0_32),length(t));
for i=1:length(t)
    X_t_21(:,i)=X(t(i),X0_21);
    X_t_22(:,i)=X(t(i),X0_22);
    X_t_23(:,i)=X(t(i),X0_23);
    X_t_24(:,i)=X(t(i),X0_24);
    X_t_25(:,i)=X(t(i),X0_25);
    X_t_26(:,i)=X(t(i),X0_26);
    X_t_27(:,i)=X(t(i),X0_27);
    X_t_28(:,i)=X(t(i),X0_28);
    X_t_29(:,i)=X(t(i),X0_29);
    X_t_30(:,i)=X(t(i),X0_30);
    X_t_31(:,i)=X(t(i),X0_31);
    X_t_32(:,i)=X(t(i),X0_32);
    X_t_33(:,i)=X(t(i),X0_33);    
    X_t_34(:,i)=X(t(i),X0_34);
end
figure(q)
q=q+1;
plot3(X_t_21(2,:),X_t_21(1,:),X_t_21(3,:),'w-',LineWidth=2)
hold on
plot3(X_t_22(2,:),X_t_22(1,:),X_t_22(3,:),'w--',LineWidth=2)
hold on
plot3(X_t_23(2,:),X_t_23(1,:),X_t_23(3,:),'g-',LineWidth=2)
hold on
plot3(X_t_24(2,:),X_t_24(1,:),X_t_24(3,:),'g--',LineWidth=2)
hold on
plot3(X_t_25(2,:),X_t_25(1,:),X_t_25(3,:),'y-',LineWidth=2)
hold on
plot3(X_t_26(2,:),X_t_26(1,:),X_t_26(3,:),'y--',LineWidth=2)
hold on
plot3(X_t_27(2,:),X_t_27(1,:),X_t_27(3,:),'c-',LineWidth=2)
hold on
plot3(X_t_28(2,:),X_t_28(1,:),X_t_28(3,:),'c--',LineWidth=2)
hold on
plot3(X_t_29(2,:),X_t_29(1,:),X_t_29(3,:),'r-',LineWidth=2)
hold on
plot3(X_t_30(2,:),X_t_30(1,:),X_t_30(3,:),'r--',LineWidth=2)
hold on
plot3(X_t_31(2,:),X_t_31(1,:),X_t_31(3,:),'b-',LineWidth=2)
hold on
plot3(X_t_32(2,:),X_t_32(1,:),X_t_32(3,:),'b--',LineWidth=2)
hold on
plot3(X_t_33(2,:),X_t_33(1,:),X_t_33(3,:),'m-',LineWidth=2)
hold on
plot3(X_t_34(2,:),X_t_34(1,:),X_t_34(3,:),'m--',LineWidth=2)
grid minor
xlabel('Y [m]','Interpreter','latex')
ylabel('X [m]','Interpreter','latex')
zlabel('Z [m]','Interpreter','latex')
axis([-3000 +3000 -2000 +2000])
title('Motion for various $\dot{y_0}$ variations','Interpreter','latex')
legend('$x_0$ = +0.113','$x_0$ = -0.113','$x_0$ = +0.25','$x_0$ = -0.25','$x_0$ = +0.5','$x_0$ = -0.5','$x_0$ = +1','$x_0$ = -1','$x_0$ = +5','$x_0$ = -5','$x_0$ = 10','$x_0$ = -10','$x_0$ = 50','$x_0$ = -50','Interpreter','latex',Location='bestoutside')
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOTION OF THE INTERCEPTOR FOR x_0 DISPLACEMENTS AND x_0_dot VARIATIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=linspace(0,1.3*T);
X0_35=[50 0 choice 0 0 0]';
X0_36=[50 0 choice -0 0 0]';
X0_37=[50 0 choice 0.5 0 0]';
X0_38=[50 0 choice -0.5 0 0]';
X0_39=[50 0 choice 1 0 0]';
X0_40=[50 0 choice -1 0 0]';
X0_41=[50 0 choice 5 0 0]';
X0_42=[50 0 choice -5 0 0]';
X0_43=[50 0 choice 10 0 0]';
X0_44=[50 0 choice -10 0 0]';
X0_45=[50 0 choice 50 0 0]';
X0_46=[50 0 choice -50 0 0]';
X_t_35=zeros(length(X0_35),length(t));
X_t_36=zeros(length(X0_36),length(t));
X_t_37=zeros(length(X0_37),length(t));
X_t_38=zeros(length(X0_38),length(t));
X_t_39=zeros(length(X0_39),length(t));
X_t_40=zeros(length(X0_40),length(t));
X_t_41=zeros(length(X0_41),length(t));
X_t_42=zeros(length(X0_42),length(t));
X_t_43=zeros(length(X0_43),length(t));
X_t_44=zeros(length(X0_44),length(t));
X_t_45=zeros(length(X0_45),length(t));
X_t_46=zeros(length(X0_46),length(t));
for i=1:length(t)
    X_t_35(:,i)=X(t(i),X0_35);
    X_t_36(:,i)=X(t(i),X0_36);
    X_t_37(:,i)=X(t(i),X0_37);
    X_t_38(:,i)=X(t(i),X0_38);
    X_t_39(:,i)=X(t(i),X0_39);
    X_t_40(:,i)=X(t(i),X0_40);
    X_t_41(:,i)=X(t(i),X0_41);
    X_t_42(:,i)=X(t(i),X0_42);
    X_t_43(:,i)=X(t(i),X0_43);
    X_t_44(:,i)=X(t(i),X0_44);
    X_t_45(:,i)=X(t(i),X0_45);    
    X_t_46(:,i)=X(t(i),X0_46);
end
figure(q)
q=q+1;
plot3(X_t_35(2,:),X_t_35(1,:),X_t_35(3,:),'g-',LineWidth=2)
hold on
plot3(X_t_36(2,:),X_t_36(1,:),X_t_36(3,:),'g--',LineWidth=2)
hold on
plot3(X_t_37(2,:),X_t_37(1,:),X_t_37(3,:),'y-',LineWidth=2)
hold on
plot3(X_t_38(2,:),X_t_38(1,:),X_t_38(3,:),'y--',LineWidth=2)
hold on
plot3(X_t_39(2,:),X_t_39(1,:),X_t_39(3,:),'c-',LineWidth=2)
hold on
plot3(X_t_40(2,:),X_t_40(1,:),X_t_40(3,:),'c--',LineWidth=2)
hold on
plot3(X_t_41(2,:),X_t_41(1,:),X_t_41(3,:),'r-',LineWidth=2)
hold on
plot3(X_t_42(2,:),X_t_42(1,:),X_t_42(3,:),'r--',LineWidth=2)
hold on
plot3(X_t_43(2,:),X_t_43(1,:),X_t_43(3,:),'b-',LineWidth=2)
hold on
plot3(X_t_44(2,:),X_t_44(1,:),X_t_44(3,:),'b--',LineWidth=2)
hold on
plot3(X_t_45(2,:),X_t_45(1,:),X_t_45(3,:),'m-',LineWidth=2)
hold on
plot3(X_t_46(2,:),X_t_46(1,:),X_t_46(3,:),'m--',LineWidth=2)
grid minor
xlabel('Y [m]','Interpreter','latex')
ylabel('X [m]','Interpreter','latex')
zlabel('Z [m]','Interpreter','latex')
axis([-3000 +3000 -2000 +2000])
title('Motion for various $\dot{x_0}$ variations and fixed $x_0$ displacements','Interpreter','latex')
legend('$x_0$ = +0.0','$x_0$ = -0.0','$x_0$ = +0.5','$x_0$ = -0.5','$x_0$ = +1','$x_0$ = -1','$x_0$ = +5','$x_0$ = -5','$x_0$ = 10','$x_0$ = -10','$x_0$ = 50','$x_0$ = -50','Interpreter','latex',Location='bestoutside')
%---------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOTION OF THE INTERCEPTOR FOR x_0 DISPLACEMENTS AND y_0_dot VARIATIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=linspace(0,1.5*T);
X0_47=[50 0 choice 0 0.058 0]';
X0_48=[50 0 choice 0 -0.117 0]';
X0_49=[50 0 choice 0 -0.176 0]';
X0_50=[50 0 choice 0 1.05 0]';
X0_51=[50 0 choice 0 -1.3 0]';
X0_52=[50 0 choice 0 2.2 0]';
X0_53=[50 0 choice 0 -2.5 0]';
X0_54=[50 0 choice 0 12 0]';
X0_55=[50 0 choice 0 -12 0]';
X0_56=[50 0 choice -0 24 0]';
X0_57=[50 0 choice 0 -24 0]';
X_t_47=zeros(length(X0_47),length(t));
X_t_48=zeros(length(X0_48),length(t));
X_t_49=zeros(length(X0_49),length(t));
X_t_50=zeros(length(X0_50),length(t));
X_t_51=zeros(length(X0_51),length(t));
X_t_52=zeros(length(X0_52),length(t));
X_t_53=zeros(length(X0_53),length(t));
X_t_54=zeros(length(X0_54),length(t));
X_t_55=zeros(length(X0_55),length(t));
X_t_56=zeros(length(X0_56),length(t));
X_t_57=zeros(length(X0_57),length(t));
for i=1:length(t)
    X_t_47(:,i)=X(t(i),X0_47);
    X_t_48(:,i)=X(t(i),X0_48);
    X_t_49(:,i)=X(t(i),X0_49);
    X_t_50(:,i)=X(t(i),X0_50);
    X_t_51(:,i)=X(t(i),X0_51);
    X_t_52(:,i)=X(t(i),X0_52);
    X_t_53(:,i)=X(t(i),X0_53);
    X_t_54(:,i)=X(t(i),X0_54);
    X_t_55(:,i)=X(t(i),X0_55);
    X_t_56(:,i)=X(t(i),X0_56);    
    X_t_57(:,i)=X(t(i),X0_57);
end
figure(q)
q=q+1;
plot3(X_t_47(2,:),X_t_47(1,:),X_t_47(3,:),'g--',LineWidth=2)
hold on
plot3(X_t_48(2,:),X_t_48(1,:),X_t_48(3,:),'y-',LineWidth=2)
hold on
plot3(X_t_49(2,:),X_t_49(1,:),X_t_49(3,:),'y--',LineWidth=2)
hold on
plot3(X_t_50(2,:),X_t_50(1,:),X_t_50(3,:),'c-',LineWidth=2)
hold on
plot3(X_t_51(2,:),X_t_51(1,:),X_t_51(3,:),'c--',LineWidth=2)
hold on
plot3(X_t_52(2,:),X_t_52(1,:),X_t_52(3,:),'r-',LineWidth=2)
hold on
plot3(X_t_53(2,:),X_t_53(1,:),X_t_53(3,:),'r--',LineWidth=2)
hold on
plot3(X_t_54(2,:),X_t_54(1,:),X_t_54(3,:),'b-',LineWidth=2)
hold on
plot3(X_t_55(2,:),X_t_55(1,:),X_t_55(3,:),'b--',LineWidth=2)
hold on
plot3(X_t_56(2,:),X_t_56(1,:),X_t_56(3,:),'m-',LineWidth=2)
hold on
plot3(X_t_57(2,:),X_t_57(1,:),X_t_57(3,:),'m--',LineWidth=2)
grid minor
xlabel('Y [m]','Interpreter','latex')
ylabel('X [m]','Interpreter','latex')
zlabel('Z [m]','Interpreter','latex')
axis([-3000 +3000 -2000 +2000])
title('Motion for various $\dot{y_0}$ variations and fixed $x_0$ displacements','Interpreter','latex')
legend('$x_0$ = +0.058','$x_0$ = -0.117','$x_0$ = -0.176','$x_0$ = +1.05','$x_0$ = -1.3','$x_0$ = +2.2','$x_0$ = -2.5','$x_0$ = 12','$x_0$ = -12','$x_0$ = 24','$x_0$ = -24','Interpreter','latex',Location='bestoutside')







