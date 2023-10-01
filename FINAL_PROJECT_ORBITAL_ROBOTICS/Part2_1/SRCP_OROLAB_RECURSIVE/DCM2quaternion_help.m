% function [quaternion_BA, normdeviation] = DCM2quaternion(DCM_BA)

% DyCoSSLab
% (c) Dr. Marcello Romano: written on 2019-04-14
% Ref: 3815 Unit 2 Slides, Marcello Romano, 2019
%
% INPUTS
% DCM_BA = [3,3 matrix in SO(3)]= Direction Cosine Matrix from CCS A to
% CCS B = Rotation Matrix from CCS B to CCS A
% 
% OUTPUTS
% Quaternion_BA = [4,1 matrix of real numbers satifying constraint norm(Quaternion_BA)=1]
% with 4th element (scalar element) >=0, i.e. "short angle" quaternion
% among the two possible orientation quaternions corresponding to the same
% DCM_BA
%
% normdeviation = 1- norm(quaternion_BA);

%detaccuracy = 10*eps;

% if isnumeric(DCM_BA)
% 
%     if norm(1-det(DCM_BA)) > detaccuracy
%         error('A matrix in SO(3) is expected as input')
%     end
% 
%     if size(DCM_BA,1)~=3 || size(DCM_BA,2)~=3 
%         error('A matrix in SO(3) is expected as input')
%     end
% end