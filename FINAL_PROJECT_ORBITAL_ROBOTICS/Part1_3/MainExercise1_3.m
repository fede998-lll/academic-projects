clear all
clc
close all
colordef black
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                           %% INPUT BLOCK %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Inputs:
%       1) We have decided to let the user capable of choicing the initial
%       conditions related to Deputy's positions [m] and velocities [m/s];
%       These ones will be showed into the command window and they will
%       be verified to be numerical, so please insert them correctly!
%       2) Deputy's mass, inserted directly below as 'm_SC' [Kg];
%       3) System's height 'h'(CHIEF + DEPUTY). This a consequence by 
%       using the HCW equations of motion, so what about their 
%       main two hypothesis [Km];
% Outputs: 
%       1) DeltaVs related to the initial and final impulses [m/s];
%       2) Optimized traiectory among the previous two DeltaVs and other 4
%       not-optimized curves related to generic couplings. These last paths
%       have been shown to give the user the sense of the optimed solution, 
%       but to accomplish the statement they aren't necessary!
h=500*10^3;
m_SC=200;
numInput=6;
string={'Please, insert x_0 value','Please, insert y_0 value','Please, insert z_0 value','Please, insert dot_x_0 value','Please, insert dot_y_0 value','Please, insert dot_z_0 value'};
X0=zeros(6,1);
for i=1:numInput
    fprintf('\n')
    disp(string(i))
    value=input('Insert the relative option: ');
    if isnumeric(value)
        X0(i)=value;
    else
        fprintf('\n')
        disp('Error, insert only numerical constants!')
        disp('Please, run again the code and pay attention to its format!')
        return
    end
end
%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %% FUNCTION ELABORATION %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[deltaV_first_Impulse,deltaV_second_Impulse]=function_Min_DeltaV_maneuvers(X0(1),X0(2),X0(3),X0(4),X0(5),X0(6),h,m_SC);

