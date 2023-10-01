%function [EulerAxis, EulerAngle] = DCM2EulAxAngl_V2(DCM_BA)

% DyCoSSLab
% (c) Dr. Marcello Romano: written on 2019-04-16
% modified on 2023-05-01
% Ref: 3815 Unit 2 Slides, Marcello Romano, 2019
%
% INPUTS
% DCM_BA = [3,3 matrix in SO(3)]= Direction Cosine Matrix from CCS A to
% CCS B = Rotation Matrix from CCS B to CCS A
% 
% OUTPUTS
% EulerAxis = [3,1 matrix of real numbers] = COMPONENTS of the
% Euler axis unit vector of relative orientation of CCS B w.r.t. CCS A ALONG 
% either CCS A or CCS B (they are the same!)
% EulerAngle = [1 real number] = Euler angle in radians of the relative 
% orientation of CCS B w.r.t. CCS A  

% NOTICE: This Function gives in output the Euler Axis and Angle having
% |EulerAngle|<=pi
%
% NOTICE 2: the output is conventionally set to 0 in case of
% input quaternion being [0;0;0;1]
% Rigorously it should contains NaN (3,1) matrix for EulerAxis and NaN scalar for EulerAngle in case of
% input quaternion being [0;0;0;1] corresponding to the fact that the
% EulerAxis and EulerAngle are NOT defined in this case of superimposed Triads B and A
