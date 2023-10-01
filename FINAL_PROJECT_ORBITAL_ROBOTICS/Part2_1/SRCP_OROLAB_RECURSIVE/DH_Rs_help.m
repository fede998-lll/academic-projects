% function [R,s] = DH_Rs(DH,qm,type) %#codegen
% This function computes the rotation matrix R and the translation vector s
% between two joints given their Denavit-Hartenber (DH) parameters.
%
% Inputs:
%   DH -> Denavit-Hartenberg parameters.
%       DH.d -> Distance between joint origins along the joint z-axis.
%       DH.theta -> Rotation between x-axis along the joint z-axis.
%       DH.alpha -> Rotation between z-axis along the x-axis.
%       DH.a -> Distance between the common normal between the z-axis.
%   qm -> Joint variable.
%   type -> type==0 for revolute joint or type==1 for prismatic joints.
%
% Outputs:
%   R -> Rotation 3x3 matrix.
%   s -> Translation 3x1 vector.