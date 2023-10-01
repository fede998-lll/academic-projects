
clc
clear all
close all
colordef black
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
                     %% SIMULATOR PROGRAM RDV-CMFF %%
                   % RenDez-Vous From Deputy to Chief %
% (CMFF stands for Christian-Matteo-Federico-Federico, so the initial
                            % capital letters)
                              % made-up by %
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    %% BELLINAZZI CHRISTIAN %%                 %%%
%%%                      %% CAVALLO FEDERICO %%                   %%%
%%%                      %% BISCEGLIA MATTEO %%                   %%%
%%%                  %% COCUZZA SANTUCCIO FEDERICO %%             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %% INPUT SELECTION BLOCK %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------
% The user has the possibility to choice:
% 1) A pre-loaded set of initial coditions. In this case the user has only
% to impose the button-press during the animation and seeing the paths
% changing and referring them to these impulses;
% These initial conditions are written as [m] and [m/s];
% 2) It's been decided to give the user the possibility to choice all
% initial conditions related to positions and velocities. After he/she 
% decides to stop the animation, the user should insert newer values of
% velocities and the code will run automatically the path's response to
% that variations. To understand better how it works, please go to read
% carefully the next section named 'VIDEO ELABORATION OUTPUTS', described
% below.
% Also in this case, initial conditions have to be written as [m] and 
% [m/s].
disp('1: Visualized example results')
disp('2: Visualized the user s input')
choice=input('Please, select what do you want to do, inserting 1 or 2: ');
if choice==1
    X0=[1000 459 10000 0.8 -0.6 0.9]';
    dot_X0_case_1=[0.7 0.2 -0.4]';
    dot_X0_case_2=[-0.8 0.01 0.6]';
    dot_X0_case_3=[0.9 -0.6 -0.1]';
end
if choice==2
    prompt={'Position x1','Position y1','Position z1',' Velocity x1','Velocity y1','Velocity z1'};
    dlgtitle='Initial Deputy s positions and velocities';
    dims=[1 45];
    definput={'','','','','',''};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    X0=str2double(answer);
end
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% GENERAL INPUTS OF THE PROBLEM %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
intervals=80;
Height=500*10^3;
Earth_radius=6371*10^3;
G=6.67259*10^-11;
M_earth=5.972*10^24;
m_Deputy=200;
mu=G*(M_earth+m_Deputy);
r=Earth_radius+Height;
Period=2*pi*sqrt(r^3/mu);
Max_orbital_period=Period/2;
Angular_velocity=sqrt(mu/r^3);
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% GENERAL VARIABLES AND FIRST OPTIMIZED IMPULSE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
State_matrix=[
    0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    3*Angular_velocity^2 0 0 0 2*Angular_velocity 0;
    0 0 0 -2*Angular_velocity 0 0;
    0 0 -Angular_velocity^2 0 0 0;
];
phi=@(t) expm(State_matrix*t);
X=@(t,X0) phi(t)*X0;
t=linspace(1,Max_orbital_period,intervals);
deltaV_i_sec=zeros(length(t),1);
deltaV_project_1_final=zeros(length(t),1);
deltaV_tot_project=zeros(length(t),1);
deltaV_i_components=zeros(length(t),3);
deltaV_project_1_final_components=zeros(length(t),3);
for i=1:length(t)
    X0_new=X(t(i),X0);
    position0=X0_new(1:3);
    velocity0=X0_new(4:6);
    phi_i_sec=phi(t(i));
    Velocity_needed_i_sec=phi_i_sec(1:3,4:6)\([0 0 0]'-phi_i_sec(1:3,1:3)*position0);
    deltaV_i=Velocity_needed_i_sec-velocity0;
    deltaV_i_components(i,1)=deltaV_i(1);
    deltaV_i_components(i,2)=deltaV_i(2);
    deltaV_i_components(i,3)=deltaV_i(3);
    deltaV_i_sec(i)=sqrt(deltaV_i(1)^2 + deltaV_i(2)^2 + deltaV_i(3)^2);
    X0_rdv_project_1=[position0;Velocity_needed_i_sec];
    X_t_rdv_project=zeros(length(X0),length(t));
    for j=1:length(t)
        X_t_rdv_project(:,j)=X(t(j),X0_rdv_project_1);
    end
    deltaV_project_1_final_components(i,1)=X_t_rdv_project(4,end);
    deltaV_project_1_final_components(i,2)=X_t_rdv_project(5,end);
    deltaV_project_1_final_components(i,3)=X_t_rdv_project(6,end);
    deltaV_project_1_final(i)=sqrt(X_t_rdv_project(4,end)^2 + X_t_rdv_project(5,end)^2 + X_t_rdv_project(6,end)^2);
    deltaV_tot_project(i)=deltaV_i_sec(i)+deltaV_project_1_final(i);
    if i>1 && deltaV_tot_project(i)<deltaV_tot_project(i-1)
        index=i;
    end
end
disp('First optimized Impulse')
deltaV_i_components(4:6,1)
phi_project=phi(t(index));
Velocity_needed_project=phi_project(1:3,4:6)\([0 0 0]'-phi_project(1:3,1:3)*position0);
deltaV_project=Velocity_needed_project-velocity0;
X0_rdv_project=[position0;Velocity_needed_project];
X_t_rdv_project=zeros(length(X0),length(t));
for i=1:index
    X_t_rdv_project(:,i)=X(t(i),X0_rdv_project);
end
Positions_rdv_project=zeros(length(X_t_rdv_project),1);
for i=1:length(X_t_rdv_project)
    Positions_rdv_project(i)=sqrt(X_t_rdv_project(1,i)^2 + X_t_rdv_project(2,i)^2 + X_t_rdv_project(3,i)^2);
end
XF_rdv_project=X(t(index),X0_rdv_project);
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       %% SPACE DEBRIS SIMULATION %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numDebris=40; % Numero di detriti spaziali
minPos=-2*max(X0); % Posizione minima
maxPos=2*max(X0); % Posizione massima
x=minPos+(maxPos-minPos)*rand(numDebris,1); 
y=minPos+(maxPos-minPos)*rand(numDebris,1); 
z=minPos+(maxPos-minPos)*rand(numDebris,1); 
minSize=0.5;
maxSize=10; 
size=minSize+(maxSize-minSize)*rand(numDebris,1); 
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% DEFINITION OF 3D ARROW DIMENSIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Height_coord=X0(1)/10;
width=15;
width_2=30;
ar_X=[0, 0, 0];
ar_X_f=ar_X+[(abs(X0(1))+abs(X0(2))+abs(X0(3)))/2,0,0];
ar_Y=[0, 0, 0];
ar_Y_f=ar_Y+[0,(abs(X0(1))+abs(X0(2))+abs(X0(3)))/2,0];
ar_Z=[0,0,0];
ar_Z_f=ar_Z+[0,0,(abs(X0(1))+abs(X0(2))+abs(X0(3)))/2];
ar_X_first_point_impulse=[position0(1),position0(2),position0(3)];
Delta_x_1=X_t_rdv_project(1,3)-X_t_rdv_project(1,1);
Delta_y_1=X_t_rdv_project(2,3)-X_t_rdv_project(2,1);
Delta_z_1=X_t_rdv_project(3,3)-X_t_rdv_project(3,1);
ar_X_second_point_impulse=[X0(1)/10, X0(2)/10, X0(3)/10];
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %% AUDIO FILE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
audioFile='Interstellar_sound.MP3';
[audio,fs]=audioread(audioFile);
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %% VIDEO ELABORATION OUTPUTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We have decided to insert this part in order to help the user learning as
% best as possible the code written below. The pause between the writing,
% deleting and again of the Marker has been chosen equal to 0.0001, so very
% fast. This assumption provide us a faster elaboration of the plot!

%-----------------------------------------------------------------------
% 1) Plot first optimized traiectory, considering valid the model related
% to the previous exercise 1.3
%                --> First optimized Impulse
%-----------------------------------------------------------------------
% 2) Press button 'Q': Newer velocities, initial conditions and
%   traiectories depending on the firsts.
%                --> Second Impulse --> Traiectory change
%-----------------------------------------------------------------------

% OPTION 1

        %-----------------------------------------------------------------------
        %-----------------------------------------------------------------------
        %       2-bis) Press button 'R': Initial conditions refer to last previous outputs
        %            found for the blocked traiectory.
        %              --> Third Impulse to Recover the CHIEF's position                 
        %-----------------------------------------------------------------------
        %-----------------------------------------------------------------------


%-----------------------------------------------------------------------
% 4) Press button 'W': Let's go to apply newer intial condition requested
%   by the user him/her selves.
%                --> Third Impulse --> Traiectory change
%-----------------------------------------------------------------------

% OPTION 2

        %-----------------------------------------------------------------------
        %-----------------------------------------------------------------------
        %       4-bis) Press button 'R': Initial conditions refer to last previous outputs
        %           found for the blocked traiectory.
        %             --> Fourth Impulse to Recover the CHIEF's position
        %-----------------------------------------------------------------------
        %-----------------------------------------------------------------------


%-----------------------------------------------------------------------
% 5) Press button 'E: We are changing the path for the last time and the
%   logical process will be always the same.
%                --> Last Impulse --> Traiectory change
%-----------------------------------------------------------------------
% 6) After that the user won't be even more capable to modify the
% traiectory, so he/she will be obliged to see the marker position arriving
% to define its last approaching point relative to that of the CHIEF.
%-----------------------------------------------------------------------
% 7) Automatically the code will establish and show the last 2-DeltaV optimized 
% impulse in order to bring Deputy's position to that of the CHIEF. The
% game could be considered itself as finished.
%-----------------------------------------------------------------------

% Notice that 'bis' passages, if computed, bring us to not compute the
% logical conditions among them. The code will run the resulting optimized
% path and then the game will end. We have imagined to let the user capable
% to stop the simulation whenever he/she wants between the first two impulses.
% This play has been thought to be as easier as possible to understand in
% order to help the user interacting with it as well as possible. 
%-----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %% INPUTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) Initial conditions about the Deputy position w.r.t. that of the CHIEF.
% These variable are resumed in the vector 'X0' [m];
% 2) The three vectors containing velocities' variations in all the
% possible space-directions. These ones are imposed by pressing specific
% button directly from the keyboard, saved into 'dot_X0_case_i' [m/s];
% 3) Obviously all results will depend on Deputy's height and relative
% mass, which have been imposed initially.
% 4) An other important parameter needed to make a quicker or slower
% analysis is the variable 'intervals', which affects the maximum run
% length shown in the cycles to draw each of the paths at a specific input
% decided by the user.
% 5) We can decide also animation's frame-rate, quality and at last the
% figure's sizes, in which these last ones have been decided maybe a bit
% high to help the user observing correctly each path's change. We remember
% that if you tried to increase the figure's size during the animation, the
% code will give you an error and the simulation shall be stopped. So this
% sizing input has been thought also to consider this intrinsic problem
% due to MATLAB itself.
% 6) In this cose it's been decided to simulate the RDV maneuvers through a
% generic sound taken from one of the most famous films about space,
% Interstellar. It's possible to change it by choicing on the website the
% desired sound-track, downloading and saving it in the same box containing
% this code. It's been suggested to put an higher background sound-level to perform 
% as well as possible this particular choice!
%-----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %% OUTPUTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) DeltaV required to compute the maneuvers requested by the user;
% 2) The code will show a figure, in which it will be given to the user the
% possibility to interact through the command window. The code will be
% re-loaded automatically after the button-press.
%-----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          %% FIGURE PLOT %%
                         % Animation block %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
rotate3d on
grid minor
hold on
scatter3(x, y, z, size, 'filled', 'MarkerFaceColor', 'w');
MyVideo=VideoWriter('Video.mp4','MPEG-4');
MyVideo.Quality=100;
MyVideo.FrameRate=10;
figure_size=[100,100,1000,900];  % [left, bottom, width, height]
set(gcf,'Position',figure_size);
open(MyVideo)
for i=1:index
    % 1) PLOT of the first optimized traiectory, axis and DeltaV arrow related
    % to it. At each cycle of iteration, the code writes, shows and delete
    % the marker representing the actual position of Deputy w.r.t. the
    % CHIEF. To provide a simple schematization of the model, we have
    % decided to not consider older points touched by this marker, in order
    % to help MATLAB for a quicker execution, letting it to be computationally precise.
    b=plot3(X_t_rdv_project(1,:),X_t_rdv_project(2,:),X_t_rdv_project(3,:),'m-',LineWidth=1);
    hold on
    plot3(X_t_rdv_project(1,1),X_t_rdv_project(2,1),X_t_rdv_project(3,1),'*',LineWidth=2,Color='g')
    hold on
    a=plot3(X_t_rdv_project(1,i),X_t_rdv_project(2,i),X_t_rdv_project(3,i),'y.','Marker','*','MarkerSize',10,LineWidth=2);
    hold on
    plot3(X_t_rdv_project(1,end),X_t_rdv_project(2,end),X_t_rdv_project(3,end),'*',LineWidth=2,Color='r')
    xlabel('X [m]','Interpreter','latex')
    ylabel('Y [m]','Interpreter','latex')
    zlabel('Z [m]','Interpreter','latex')
    view(55,20)
    axis equal
    title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec\nRelative Positions: %0.3f m\nRelative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$', t(i),Positions_rdv_project(i),X_t_rdv_project(4,i),X_t_rdv_project(5,i),X_t_rdv_project(6,i)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',15)
    mArrow3(ar_X,ar_X_f,'color','[0.7010 0.7450 0.6330]','stemWidth',(abs(X0(1))+abs(X0(2))+abs(X0(3)))/100);
    mArrow3(ar_Y,ar_Y_f,'color','[0.7010 0.7450 0.6330]','stemWidth',(abs(X0(1))+abs(X0(2))+abs(X0(3)))/100);
    mArrow3(ar_Z,ar_Z_f,'color','[0.7010 0.7450 0.6330]','stemWidth',(abs(X0(1))+abs(X0(2))+abs(X0(3)))/100);
    text(0,ar_X_f(1)+width*(max(X0)/mean(X0)),0,'h_1')
    text(0,0,ar_Y_f(2)+width*(max(X0)/mean(X0)),'h_2')
    text(ar_Z_f(3)+width*(max(X0)/mean(X0)),0,0,'h_3')
    text(X_t_rdv_project(1,end),X_t_rdv_project(2,end),X_t_rdv_project(3,end),'\leftarrow Final CHIEF desired position','LineWidth',2,Color='r')
    text(X_t_rdv_project(1,1),X_t_rdv_project(2,1),X_t_rdv_project(3,1),'\leftarrow Intial velocity and position',LineWidth=2,Color='g')
    frame=getframe(gcf);
    writeVideo(MyVideo,frame);
    pause(0.001)
    delete(a)
    delete(b)
    T_project=t(i);
    sound(audio,fs);
    % 2) As an input, after the user has pressed letter 'Q' through the
    % keyboard, after have asked to insert the Velocity variations needed
    % for the traiectory change, the code takes in input as newer
    % conditions positions and velocities related to the last point touched
    % by the previous curve. After that the usual phase of inserting all the
    % variables and plotting the resulting curves.
    if strcmp(get(gcf,'CurrentCharacter'),'q')
        if choice==2
            prompt={'Velocity variation x1','Velocity variation y1','Velocity variation z1'};
            dlgtitle='Input DeltaVs';
            dims=[1 45];
            definput={'','',''};
            answer=inputdlg(prompt,dlgtitle,dims,definput);
            dot_X0_case_1=str2double(answer);
        end
        delete(a)
        position0_case_1=X_t_rdv_project(1:3,i);
        Velocity0_case_1=X_t_rdv_project(4:6,i);
        phi_case_1=phi(Max_orbital_period/2);
        Velocity_needed_case_1=(phi_case_1(1:3,4:6)\([0 0 0]'-phi_case_1(1:3,1:3)*position0_case_1))+dot_X0_case_1;
        deltaV_case_1=Velocity_needed_case_1-Velocity0_case_1;
        disp('Second generic Impulse')
        deltaV_case_1
        X0_rdv_case_1=[position0_case_1;Velocity_needed_case_1];
        t=linspace(1,Max_orbital_period/2,intervals);
        X_t_rdv_case_1=zeros(6,length(t));
        for k=1:intervals
            X_t_rdv_case_1(:,k)=X(t(k),X0_rdv_case_1);
        end
        XF_rdv_case_1=X(Max_orbital_period/2,X0_rdv_case_1);
        Positions_rdv_case_1=zeros(length(X_t_rdv_case_1),1);
        for iii=1:length(X_t_rdv_case_1)
            Positions_rdv_case_1(iii)=sqrt(X_t_rdv_case_1(1,iii)^2 + X_t_rdv_case_1(2,iii)^2 + X_t_rdv_case_1(3,iii)^2);
        end
        XF_rdv_project=X(t(index),X0_rdv_project);
        plot3(X_t_rdv_project(1,1:i),X_t_rdv_project(2,1:i),X_t_rdv_project(3,1:i),'m-',LineWidth=2)
        hold on
        plot3(X_t_rdv_project(1,i:length(X_t_rdv_project)),X_t_rdv_project(2,i:length(X_t_rdv_project)),X_t_rdv_project(3,i:length(X_t_rdv_project)),'m--',LineWidth=2)
        hold on
        e=plot3(X_t_rdv_case_1(1,:),X_t_rdv_case_1(2,:),X_t_rdv_case_1(3,:),'w-',LineWidth=2);
        ar_X_first_point_impulse_case_1=[position0_case_1(1),position0_case_1(2),position0_case_1(3)];
        Delta_x_2=-X_t_rdv_case_1(1,3)+X_t_rdv_case_1(1,1);
        Delta_y_2=-X_t_rdv_case_1(2,3)+X_t_rdv_case_1(2,1);
        Delta_z_2=-X_t_rdv_case_1(3,3)+X_t_rdv_case_1(3,1);
        ar_X_second_point_impulse_case_1=[X_t_rdv_case_1(1,1)+width_2*(max(position0_case_1)/mean(position0_case_1))*Delta_x_2, X_t_rdv_case_1(2,1)+width_2*(max(position0_case_1)/mean(position0_case_1))*Delta_y_2, X_t_rdv_case_1(3,1)+width_2*(max(position0_case_1)/mean(position0_case_1))*Delta_z_2];
        for j=1:intervals
            c=plot3(X_t_rdv_case_1(1,j),X_t_rdv_case_1(2,j),X_t_rdv_case_1(3,j),'y.','Marker','*','MarkerSize',10,LineWidth=2);
            hold on
            plot3(X_t_rdv_case_1(1,1),X_t_rdv_case_1(2,1),X_t_rdv_case_1(3,1),'*',LineWidth=2,Color='c')
            mArrow3(ar_X_first_point_impulse_case_1,ar_X_second_point_impulse_case_1,'color','[0.9290 0.6940 0.1250]','stemWidth',width*(max(X0)/mean(X0)));
            text(X_t_rdv_case_1(1,1),X_t_rdv_case_1(2,1),X_t_rdv_case_1(3,1),'\leftarrow Second Inpulse',LineWidth=2,Color='c')
            title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec,Time: %0.3f sec\nRelative Poitions: %0.3f m\nRelative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$', T_project,t(j),Positions_rdv_case_1(j),X_t_rdv_case_1(4,j),X_t_rdv_case_1(5,j),X_t_rdv_case_1(6,j)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
            frame=getframe(gcf);
            writeVideo(MyVideo,frame);
            pause(0.0001)
            delete(c)
            T_case_1=t(j);
            index_j=j;
            % As we saw previously, the code gives us the possibility to
            % recover, whenever you want, the actual Deputy position to
            % that of the CHIEF, by elaborating automatically an optimized
            % 2-DeltaV traiectory, the same made for the first optimized
            % impulse. In this way the user is capable to block at each
            % instant of time the simulation and to close the video. The
            % button 'R' stands obviously for 'Recovery'.
            if strcmp(get(gcf,'CurrentCharacter'),'r')
                delete(e)
                position0_case_interrupt_1=[X_t_rdv_case_1(1,j);X_t_rdv_case_1(2,j);X_t_rdv_case_1(3,j)];
                Velocity0_case_interrupt_1=[X_t_rdv_case_1(4,j);X_t_rdv_case_1(5,j);X_t_rdv_case_1(6,j)];
                deltaV_i_sec_interrupt=zeros(length(t),1);
                deltaV_project_1_interrupt=zeros(length(t),1);
                deltaV_tot_interrupt=zeros(length(t),1);
                for iiii=1:length(t)
                    X0_new=X(t(iiii),X0);
                    position0_interrupt_1=X0_new(1:3);
                    velocity0_interrupt_1=X0_new(4:6);
                    phi_i_sec=phi(t(iiii));
                    Velocity_needed_i_sec=phi_i_sec(1:3,4:6)\([0 0 0]'-phi_i_sec(1:3,1:3)*position0_interrupt_1);
                    deltaV_i=Velocity_needed_i_sec-velocity0_interrupt_1;
                    deltaV_i_sec_interrupt(iiii)=sqrt(deltaV_i(1)^2 + deltaV_i(2)^2 + deltaV_i(3)^2);
                    X0_rdv_interrupt_1=[position0_interrupt_1;Velocity_needed_i_sec];
                    X_t_rdv_interrupt_1=zeros(length(X0_rdv_interrupt_1),length(t));
                    for jjj=1:length(t)
                        X_t_rdv_interrupt_1(:,jjj)=X(t(jjj),X0_rdv_interrupt_1);
                    end
                    deltaV_project_1_interrupt(iiii)=sqrt(X_t_rdv_interrupt_1(4,end)^2 + X_t_rdv_interrupt_1(5,end)^2 + X_t_rdv_interrupt_1(6,end)^2);
                    deltaV_tot_interrupt(iiii)=deltaV_i_sec_interrupt(iiii)+deltaV_project_1_interrupt(iiii);
                    if iiii>1 && deltaV_tot_interrupt(iiii)<deltaV_tot_interrupt(iiii-1)
                        index_rdv_interrupt_1=iiii;
                    end
                end
                phi_rdv_interrupt_1=phi(t(index_rdv_interrupt_1));
                Velocity_needed_rdv_interrupt_1=phi_rdv_interrupt_1(1:3,4:6)\([0 0 0]'-phi_rdv_interrupt_1(1:3,1:3)*position0_case_interrupt_1);
                disp('DeltaV required to apply the recovering maneuver')
                deltaV_rdv_interrupt_1=Velocity_needed_rdv_interrupt_1-Velocity0_case_interrupt_1
                X0_rdv_rdv_interrupt_1=[position0_case_interrupt_1;Velocity_needed_rdv_interrupt_1];
                X_t_rdv_interrupt_1=zeros(length(X0_new),length(t));
                for q=1:index_rdv_interrupt_1
                    X_t_rdv_interrupt_1(:,q)=X(t(q),X0_rdv_rdv_interrupt_1);
                end
                Positions_rdv_interrupt_1=zeros(length(X_t_rdv_interrupt_1),1);
                for iii=1:length(X_t_rdv_interrupt_1)
                    Positions_rdv_interrupt_1(iii)=sqrt(X_t_rdv_interrupt_1(1,iii)^2 + X_t_rdv_interrupt_1(2,iii)^2 + X_t_rdv_interrupt_1(3,iii)^2);
                end
                XF_rdv_interrupt_1=X(t(index_rdv_interrupt_1),X0_rdv_rdv_interrupt_1);
                T_rdv_interrupt_1=t(index_rdv_interrupt_1);
                hold on
                plot3(X_t_rdv_interrupt_1(1,:),X_t_rdv_interrupt_1(2,:),X_t_rdv_interrupt_1(3,:),'b',LineWidth=2)
                hold on
                plot3(X_t_rdv_case_1(1,1:index_j),X_t_rdv_case_1(2,1:index_j),X_t_rdv_case_1(3,1:index_j),'w-',LineWidth=2);
                hold on
                plot3(X_t_rdv_case_1(1,index_j:intervals),X_t_rdv_case_1(2,index_j:intervals),X_t_rdv_case_1(3,index_j:intervals),'w--',LineWidth=2);
                ar_X_first_point_impulse=[position0_case_interrupt_1(1),position0_case_interrupt_1(2),position0_case_interrupt_1(3)];
                Delta_x_1=X_t_rdv_interrupt_1(1,3)-X_t_rdv_interrupt_1(1,1);
                Delta_y_1=X_t_rdv_interrupt_1(2,3)-X_t_rdv_interrupt_1(2,1);
                Delta_z_1=X_t_rdv_interrupt_1(3,3)-X_t_rdv_interrupt_1(3,1);
                ar_X_second_point_impulse=[X_t_rdv_interrupt_1(1,1)+width_2*(max(position0_case_interrupt_1)/mean(position0_case_interrupt_1))*Delta_x_1, X_t_rdv_interrupt_1(2,1)+width_2*(max(position0_case_interrupt_1)/mean(position0_case_interrupt_1))*Delta_y_1, X_t_rdv_interrupt_1(3,1)+width_2*(max(position0_case_interrupt_1)/mean(position0_case_interrupt_1))*Delta_z_1];
                mArrow3(ar_X_first_point_impulse,ar_X_second_point_impulse,'color','[0.9290 0.6940 0.1250]','stemWidth',width*(max(X0)/mean(X0)));
                hold on
                plot3(X_t_rdv_interrupt_1(1,1),X_t_rdv_interrupt_1(2,1),X_t_rdv_interrupt_1(3,1),'*',LineWidth=2,Color='c')
                text(X_t_rdv_interrupt_1(1,1),X_t_rdv_interrupt_1(2,1),X_t_rdv_interrupt_1(3,1),'\leftarrow Third Impulse',LineWidth=2,Color='c')
                for tt=1:index_rdv_interrupt_1
                    interr_1=plot3(X_t_rdv_interrupt_1(1,tt),X_t_rdv_interrupt_1(2,tt),X_t_rdv_interrupt_1(3,tt),'y.','Marker','*','MarkerSize',10,LineWidth=2);
                    hold on
                    title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec,Time: %0.3f sec\nTime: %0.3f sec\n Relative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$ \nRelative Distances: %0.3f m', T_project,T_case_1,t(tt),X_t_rdv_interrupt_1(4,tt),X_t_rdv_interrupt_1(5,tt),X_t_rdv_interrupt_1(6,tt),Positions_rdv_interrupt_1(tt)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
                    frame=getframe(gcf);
                    writeVideo(MyVideo,frame);
                    pause(0.0001)
                    delete(interr_1)
                    if abs(X_t_rdv_interrupt_1(1,tt))<0.1 && abs(X_t_rdv_interrupt_1(2,tt))<0.1 && abs(X_t_rdv_interrupt_1(3,tt))<0.1
                        return
                    end
                end
            end
            % All of the following steps are a copy of what has been
            % described until now, so we will not to mention them, but
            % re-arranging all the inputs, plots and texts, we are able to
            % complete this game!
            if strcmp(get(gcf,'CurrentCharacter'),'w')
                if choice==2
                    prompt={'Velocity variation x1','Velocity variation y1','Velocity variation z1'};
                    dlgtitle='Input DeltaVs';
                    dims=[1 45];
                    definput={'','',''};
                    answer=inputdlg(prompt,dlgtitle,dims,definput);
                    dot_X0_case_2=str2double(answer);
                end
                delete(e)
                position0_case_2=X_t_rdv_case_1(1:3,index_j);
                Velocity0_case_2=X_t_rdv_case_1(4:6,index_j);
                phi_project_case_2=phi(Max_orbital_period/2);
                Velocity_needed_case_2=(phi_project_case_2(1:3,4:6)\([0 0 0]'-phi_project_case_2(1:3,1:3)*position0_case_2))+dot_X0_case_2;
                deltaV_case_2=Velocity_needed_case_2-Velocity0_case_2;
                disp('Third generic Impulse')
                deltaV_case_2
                X0_rdv_case_2=[position0_case_2;Velocity_needed_case_2];
                t=linspace(1,Max_orbital_period/2,intervals);
                X_t_rdv_case_2=zeros(6,length(t));
                for k=1:intervals
                    X_t_rdv_case_2(:,k)=X(t(k),X0_rdv_case_2);
                end
                Positions_rdv_case_2=zeros(length(X_t_rdv_case_2),1);
                for iii=1:length(X_t_rdv_case_2)
                    Positions_rdv_case_2(iii)=sqrt(X_t_rdv_case_2(1,iii)^2 + X_t_rdv_case_2(2,iii)^2 + X_t_rdv_case_2(3,iii)^2);
                end
                XF_rdv_case_2=X(Max_orbital_period/2,X0_rdv_case_2);
                f=plot3(X_t_rdv_case_1(1,1:index_j),X_t_rdv_case_1(2,1:index_j),X_t_rdv_case_1(3,1:index_j),'w-',LineWidth=2);
                hold on
                plot3(X_t_rdv_project(1,i:length(X_t_rdv_project)),X_t_rdv_project(2,i:length(X_t_rdv_project)),X_t_rdv_project(3,i:length(X_t_rdv_project)),'m--',LineWidth=2)
                hold on
                g=plot3(X_t_rdv_case_2(1,:),X_t_rdv_case_2(2,:),X_t_rdv_case_2(3,:),LineWidth=2,Color='m');
                hold on
                ar_X_first_point_impulse_case_2=[position0_case_2(1),position0_case_2(2),position0_case_2(3)];
                Delta_x_3=-X_t_rdv_case_2(1,3)+X_t_rdv_case_2(1,1);
                Delta_y_3=-X_t_rdv_case_2(2,3)+X_t_rdv_case_2(2,1);
                Delta_z_3=-X_t_rdv_case_2(3,3)+X_t_rdv_case_2(3,1);
                ar_X_second_point_impulse_case_2=[X_t_rdv_case_2(1,1)+width_2*(max(position0_case_2)/mean(position0_case_2))*Delta_x_3, X_t_rdv_case_2(2,1)+width_2*(max(position0_case_2)/mean(position0_case_2))*Delta_y_3, X_t_rdv_case_2(3,1)+width_2*(max(position0_case_2)/mean(position0_case_2))*Delta_z_3];
                for u=1:intervals
                    d=plot3(X_t_rdv_case_2(1,u),X_t_rdv_case_2(2,u),X_t_rdv_case_2(3,u),'y.','Marker','*','MarkerSize',10,LineWidth=2);
                    hold on
                    plot3(X_t_rdv_case_1(1,1:index_j),X_t_rdv_case_1(2,1:index_j),X_t_rdv_case_1(3,1:index_j),'w-',LineWidth=2)
                    hold on
                    plot3(X_t_rdv_case_1(1,index_j:intervals),X_t_rdv_case_1(2,index_j:intervals),X_t_rdv_case_1(3,index_j:intervals),'w--',LineWidth=2)
                    hold on
                    plot3(X_t_rdv_case_2(1,1),X_t_rdv_case_2(2,1),X_t_rdv_case_2(3,1),'*',LineWidth=2,Color='c')
                    mArrow3(ar_X_first_point_impulse_case_2,ar_X_second_point_impulse_case_2,'color','[0.9290 0.6940 0.1250]','stemWidth',width*(max(X0)/mean(X0)));
                    text(X_t_rdv_case_2(1,1),X_t_rdv_case_2(2,1),X_t_rdv_case_2(3,1),'\leftarrow Third Impulse',LineWidth=2,Color='c')
                    T_case_2=t(u);
                    title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec,Time: %0.3f sec,Time: %0.3f sec\nRelative Positions: %0.3f m\nRelative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$', T_project,T_case_1,T_case_2,Positions_rdv_case_2(u),X_t_rdv_case_2(4,u),X_t_rdv_case_2(5,u),X_t_rdv_case_2(6,u)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
                    frame=getframe(gcf);
                    writeVideo(MyVideo,frame);
                    pause(0.0001)
                    delete(d)
                    if strcmp(get(gcf,'CurrentCharacter'),'r')
                        position0_case_interrupt_2=[X_t_rdv_case_2(1,u);X_t_rdv_case_2(2,u);X_t_rdv_case_2(3,u)];
                        Velocity0_case_interrupt_2=[X_t_rdv_case_2(4,u);X_t_rdv_case_2(5,u);X_t_rdv_case_2(6,u)];
                        deltaV_i_sec_interrupt=zeros(length(t),1);
                        deltaV_project_2_interrupt=zeros(length(t),1);
                        deltaV_tot_interrupt=zeros(length(t),1);
                        for iiii=1:length(t)
                            X0_new=X(t(iiii),X0);
                            position0_interrupt_2=X0_new(1:3);
                            velocity0_interrupt_2=X0_new(4:6);
                            phi_i_sec=phi(t(iiii));
                            Velocity_needed_i_sec=phi_i_sec(1:3,4:6)\([0 0 0]'-phi_i_sec(1:3,1:3)*position0_interrupt_2);
                            deltaV_i=Velocity_needed_i_sec-velocity0_interrupt_2;
                            deltaV_i_sec_interrupt(iiii)=sqrt(deltaV_i(1)^2 + deltaV_i(2)^2 + deltaV_i(3)^2);
                            X0_rdv_interrupt_2=[position0_interrupt_2;Velocity_needed_i_sec];
                            X_t_rdv_interrupt_2=zeros(length(X0_rdv_interrupt_2),length(t));
                            for jjj=1:length(t)
                                X_t_rdv_interrupt_2(:,jjj)=X(t(jjj),X0_rdv_interrupt_2);
                            end
                            deltaV_project_2_interrupt(iiii)=sqrt(X_t_rdv_interrupt_2(4,end)^2 + X_t_rdv_interrupt_2(5,end)^2 + X_t_rdv_interrupt_2(6,end)^2);
                            deltaV_tot_interrupt(iiii)=deltaV_i_sec_interrupt(iiii)+deltaV_project_2_interrupt(iiii);
                            if iiii>1 && deltaV_tot_interrupt(iiii)<deltaV_tot_interrupt(iiii-1)
                                index_rdv_interrupt_2=iiii;
                            end
                        end
                        phi_rdv_interrupt_2=phi(t(index_rdv_interrupt_2));
                        Velocity_needed_rdv_interrupt_2=phi_rdv_interrupt_2(1:3,4:6)\([0 0 0]'-phi_rdv_interrupt_2(1:3,1:3)*position0_case_interrupt_2);
                        disp('DeltaV required to apply the recovering maneuver')
                        deltaV_rdv_interrupt_2=Velocity_needed_rdv_interrupt_2-Velocity0_case_interrupt_2
                        X0_rdv_rdv_interrupt_2=[position0_case_interrupt_2;Velocity_needed_rdv_interrupt_2];
                        X_t_rdv_interrupt_2=zeros(length(X0_new),length(t));
                        for q=1:index_rdv_interrupt_2
                            X_t_rdv_interrupt_2(:,q)=X(t(q),X0_rdv_rdv_interrupt_2);
                        end
                        Positions_rdv_interrupt_2=zeros(length(X_t_rdv_interrupt_2),1);
                        for iii=1:length(X_t_rdv_interrupt_2)
                            Positions_rdv_interrupt_2(iii)=sqrt(X_t_rdv_interrupt_2(1,iii)^2 + X_t_rdv_interrupt_2(2,iii)^2 + X_t_rdv_interrupt_2(3,iii)^2);
                        end
                        XF_rdv_interrupt_2=X(t(index_rdv_interrupt_2),X0_rdv_rdv_interrupt_2);
                        T_rdv_interrupt_2=t(index_rdv_interrupt_2);
                        hold on
                        plot3(X_t_rdv_interrupt_2(1,:),X_t_rdv_interrupt_2(2,:),X_t_rdv_interrupt_2(3,:),'b',LineWidth=2)
                        hold on
                        ar_X_first_point_impulse=[position0_case_interrupt_2(1),position0_case_interrupt_2(2),position0_case_interrupt_2(3)];
                        Delta_x_1=X_t_rdv_interrupt_2(1,3)-X_t_rdv_interrupt_2(1,1);
                        Delta_y_1=X_t_rdv_interrupt_2(2,3)-X_t_rdv_interrupt_2(2,1);
                        Delta_z_1=X_t_rdv_interrupt_2(3,3)-X_t_rdv_interrupt_2(3,1);
                        ar_X_second_point_impulse=[X_t_rdv_interrupt_2(1,1)+width_2*(max(position0_case_interrupt_2)/mean(position0_case_interrupt_2))*Delta_x_1, X_t_rdv_interrupt_2(2,1)+width_2*(max(position0_case_interrupt_2)/mean(position0_case_interrupt_2))*Delta_y_1, X_t_rdv_interrupt_2(3,1)+width_2*(max(position0_case_interrupt_2)/mean(position0_case_interrupt_2))*Delta_z_1];
                        mArrow3(ar_X_first_point_impulse,ar_X_second_point_impulse,'color','[0.9290 0.6940 0.1250]','stemWidth',width*(max(X0)/mean(X0)));
                        hold on
                        plot3(X_t_rdv_interrupt_2(1,1),X_t_rdv_interrupt_2(2,1),X_t_rdv_interrupt_2(3,1),'*',LineWidth=2,Color='c')
                        text(X_t_rdv_interrupt_2(1,1),X_t_rdv_interrupt_2(2,1),X_t_rdv_interrupt_2(3,1),'\leftarrow Fourth Impulse',LineWidth=2,Color='c')
                        for tt=1:index_rdv_interrupt_2
                            interr_2=plot3(X_t_rdv_interrupt_2(1,tt),X_t_rdv_interrupt_2(2,tt),X_t_rdv_interrupt_2(3,tt),'y.','Marker','*','MarkerSize',10,LineWidth=2);
                            hold on
                            title(sprintf('3D space game-like animation with space-debris\n    Time: %0.3f sec,   Time: %0.3f sec\n, Time: %0.3f sec, Time: %0.3f sec\n Relative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$ \nRelative Distances: %0.3f m', T_project,T_case_1,T_case_2,t(tt),X_t_rdv_interrupt_2(4,tt),X_t_rdv_interrupt_2(5,tt),X_t_rdv_interrupt_2(6,tt),Positions_rdv_interrupt_2(tt)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
                            frame=getframe(gcf);
                            writeVideo(MyVideo,frame);
                            pause(0.0001)
                            delete(interr_2)
                            if abs(X_t_rdv_interrupt_2(1,tt))<0.1 && abs(X_t_rdv_interrupt_2(2,tt))<0.1 && abs(X_t_rdv_interrupt_2(3,tt))<0.1
                                return
                            end
                        end
                    end
                    if strcmp(get(gcf,'CurrentCharacter'),'e')
                        if choice==2
                            prompt={'Velocity variation x1','Velocity variation y1','Velocity variation z1'};
                            dlgtitle='Input DeltaVs';
                            dims=[1 45];
                            definput={'','',''};
                            answer=inputdlg(prompt,dlgtitle,dims,definput);
                            dot_X0_case_3=str2double(answer);
                        end
                        delete(g)
                        position0_case_3=X_t_rdv_case_2(1:3,u);
                        Velocity0_case_3=X_t_rdv_case_2(4:6,u);
                        phi_project_case_3=phi(Max_orbital_period/2);
                        Velocity_needed_case_3=(phi_project_case_3(1:3,4:6)\([0 0 0]'-phi_project_case_3(1:3,1:3)*position0_case_3))+dot_X0_case_3;
                        deltaV_case_3=Velocity_needed_case_3-Velocity0_case_3;
                        disp('Fourth generic Impulse')
                        deltaV_case_3
                        X0_rdv_case_3=[position0_case_3;Velocity_needed_case_3];
                        t=linspace(1,Max_orbital_period/2,intervals);
                        X_t_rdv_case_3=zeros(6,length(t));
                        for k=1:intervals
                            X_t_rdv_case_3(:,k)=X(t(k),X0_rdv_case_3);
                        end
                        Positions_rdv_case_3=zeros(length(X_t_rdv_case_3),1);
                        for iii=1:length(X_t_rdv_case_3)
                            Positions_rdv_case_3(iii)=sqrt(X_t_rdv_case_3(1,iii)^2 + X_t_rdv_case_3(2,iii)^2 + X_t_rdv_case_3(3,iii)^2);
                        end
                        T_case_3=t(intervals);
                        hold on
                        plot3(X_t_rdv_project(1,i:length(X_t_rdv_project)),X_t_rdv_project(2,i:length(X_t_rdv_project)),X_t_rdv_project(3,i:length(X_t_rdv_project)),'m--',LineWidth=2)
                        hold on
                        plot3(X_t_rdv_case_2(1,1:u),X_t_rdv_case_2(2,1:u),X_t_rdv_case_2(3,1:u),LineWidth=2,Color='m')
                        hold on
                        plot3(X_t_rdv_case_2(1,u:intervals),X_t_rdv_case_2(2,u:intervals),X_t_rdv_case_2(3,u:intervals),'m--',LineWidth=2)
                        hold on
                        plot3(X_t_rdv_case_3(1,:),X_t_rdv_case_3(2,:),X_t_rdv_case_3(3,:),LineWidth=2,Color='w')
                        ar_X_first_point_impulse_case_3=[position0_case_3(1),position0_case_3(2),position0_case_3(3)];
                        Delta_x_4=X_t_rdv_case_3(1,3)-X_t_rdv_case_3(1,1);
                        Delta_y_4=X_t_rdv_case_3(2,3)-X_t_rdv_case_3(2,1);
                        Delta_z_4=X_t_rdv_case_3(3,3)-X_t_rdv_case_3(3,1);
                        ar_X_second_point_impulse_case_3=[X_t_rdv_case_3(1,1)+width_2*(max(position0_case_3)/mean(position0_case_3))*Delta_x_4, X_t_rdv_case_3(2,1)+width_2*(max(position0_case_3)/mean(position0_case_3))*Delta_y_4, X_t_rdv_case_3(3,1)+width_2*(max(position0_case_3)/mean(position0_case_3))*Delta_z_4];
                        mArrow3(ar_X_first_point_impulse_case_3,ar_X_second_point_impulse_case_3,'color','[0.9290 0.6940 0.1250]','stemWidth',width*(max(X0)/mean(X0)));
                        for l=1:intervals
                            d=plot3(X_t_rdv_case_3(1,l),X_t_rdv_case_3(2,l),X_t_rdv_case_3(3,l),'y.','Marker','*','MarkerSize',10,LineWidth=2);
                            hold on
                            plot3(X_t_rdv_case_1(1,1:index_j),X_t_rdv_case_1(2,1:index_j),X_t_rdv_case_1(3,1:index_j),'w-',LineWidth=2)
                            hold on
                            plot3(X_t_rdv_case_1(1,index_j:intervals),X_t_rdv_case_1(2,index_j:intervals),X_t_rdv_case_1(3,index_j:intervals),'w--',LineWidth=2)
                            hold on
                            plot3(X_t_rdv_case_3(1,1),X_t_rdv_case_3(2,1),X_t_rdv_case_3(3,1),'*',LineWidth=2,Color='c')
                            text(X_t_rdv_case_3(1,1),X_t_rdv_case_3(2,1),X_t_rdv_case_3(3,1),'\leftarrow Fourth Impulse',LineWidth=2,Color='c')
                            title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec,Time: %0.3f sec,Time: %0.3f sec\nTime: %0.3f sec\nRelative Positions: %0.3f m\nRelative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$', T_project,t(j),t(u),t(l),Positions_rdv_case_3(l),X_t_rdv_case_3(4,l),X_t_rdv_case_3(5,l),X_t_rdv_case_3(6,l)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
                            frame=getframe(gcf);
                            writeVideo(MyVideo,frame);
                            pause(0.0001)
                            delete(d)
                        end
                        if l==intervals
                            hold on
                            plot3(X_t_rdv_case_3(1,end),X_t_rdv_case_3(2,end),X_t_rdv_case_3(3,end),'*',LineWidth=2,Color='c')
                            text(X_t_rdv_case_3(1,end),X_t_rdv_case_3(2,end),X_t_rdv_case_3(3,end),'\leftarrow Final Impulse',LineWidth=2,Color='c')
                            position0_case_4=[X_t_rdv_case_3(1,end);X_t_rdv_case_3(2,end);X_t_rdv_case_3(3,end)];
                            Velocity0_case_4=[X_t_rdv_case_3(4,end);X_t_rdv_case_3(5,end);X_t_rdv_case_3(6,end)];
                            deltaV_i_sec=zeros(length(t),1);
                            deltaV_project_1_final=zeros(length(t),1);
                            deltaV_tot_final=zeros(length(t),1);
                            deltaV_i_components_2=zeros(length(t),3);
                            for iiii=1:length(t)
                                X0_new=X(t(iiii),X0);
                                position0=X0_new(1:3);
                                velocity0=X0_new(4:6);
                                phi_i_sec=phi(t(iiii));
                                Velocity_needed_i_sec=phi_i_sec(1:3,4:6)\([0 0 0]'-phi_i_sec(1:3,1:3)*position0);
                                deltaV_i=Velocity_needed_i_sec-velocity0;                                
                                deltaV_i_components_2(iiii,1)=deltaV_i(1);
                                deltaV_i_components_2(iiii,2)=deltaV_i(2);
                                deltaV_i_components_2(iiii,3)=deltaV_i(3);
                                deltaV_i_sec(iiii)=sqrt(deltaV_i(1)^2 + deltaV_i(2)^2 + deltaV_i(3)^2);
                                X0_rdv_project_1=[position0;Velocity_needed_i_sec];
                                X_t_rdv_project=zeros(length(X0),length(t));
                                for jjj=1:length(t)
                                    X_t_rdv_project(:,jjj)=X(t(jjj),X0_rdv_project_1);
                                end
                                deltaV_project_1_final(iiii)=sqrt(X_t_rdv_project(4,end)^2 + X_t_rdv_project(5,end)^2 + X_t_rdv_project(6,end)^2);
                                deltaV_tot_final(iiii)=deltaV_i_sec(iiii)+deltaV_project_1_final(iiii);
                                if iiii>1 && deltaV_tot_final(iiii)<deltaV_tot_final(iiii-1)
                                    index_rdv_final=iiii;
                                end
                            end
                            phi_rdv_final=phi(t(index_rdv_final));
                            Velocity_needed_rdv_final=phi_rdv_final(1:3,4:6)\([0 0 0]'-phi_rdv_final(1:3,1:3)*position0_case_4);
                            deltaV_rdv_final=Velocity_needed_rdv_final-Velocity0_case_4;
                            X0_rdv_rdv_final=[position0_case_4;Velocity_needed_rdv_final];
                            X_t_rdv_final=zeros(length(X0),length(t));
                            for q=1:index_rdv_final
                                X_t_rdv_final(:,q)=X(t(q),X0_rdv_rdv_final);
                            end
                            disp('Final RDV optimized Impulse')
                            X_t_rdv_final(4:6,1)
                            disp('Final RDV target approaching (opposite sense)')
                            -X_t_rdv_final(4:6,index_rdv_final)
                            Positions_rdv_final=zeros(length(X_t_rdv_final),1);
                            for iii=1:length(X_t_rdv_final)
                                Positions_rdv_final(iii)=sqrt(X_t_rdv_final(1,iii)^2 + X_t_rdv_final(2,iii)^2 + X_t_rdv_final(3,iii)^2);
                            end
                            XF_rdv_final=X(t(index_rdv_final),X0_rdv_rdv_final);
                            T_rdv_final=t(index_rdv_final);
                            for z=1:index_rdv_final
                                g=plot3(X_t_rdv_final(1,z),X_t_rdv_final(2,z),X_t_rdv_final(3,z),'y.','Marker','*','MarkerSize',10,LineWidth=2);
                                hold on
                                plot3(X_t_rdv_final(1,:),X_t_rdv_final(2,:),X_t_rdv_final(3,:),LineWidth=2,Color='b')
                                title(sprintf('3D space game-like animation with space-debris\nTime: %0.3f sec,Time: %0.3f sec,Time: %0.3f sec\nTime: %0.3f sec,Time: %0.3f sec\nRelative Positions: %0.3f m\nRelative Velocities: [%0.3f,%0.3f,%0.3f] $m/s$', T_project,t(j),t(u),t(l),t(z),Positions_rdv_final(z),X_t_rdv_final(4,z),X_t_rdv_final(5,z),X_t_rdv_final(6,z)),'Interpreter','latex','Color','[0.9290 0.6940 0.1250]','FontSize',12)
                                frame=getframe(gcf);
                                writeVideo(MyVideo,frame);
                                pause(0.0001)
                                delete(g)
                            end
                            close(MyVideo)
                            return
                        end
                    end
                end 
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%













