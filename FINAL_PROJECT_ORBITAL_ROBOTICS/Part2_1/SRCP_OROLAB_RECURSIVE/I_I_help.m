% function [I0,Im]=I_I(R0,RL,robot)
% Projects the link inertias in the inertial CCS.
%
% [I0,Im]=I_I(R0,RL,robot)
%
% :parameters: 
%   * R0 -- Rotation matrix from the base-link CCS to the inertial CCS -- [3x3].
%   * RL -- Links CCS 3x3 rotation matrices with respect to the inertial CCS -- as a [3x3xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * I0 -- Base-link inertia matrix, projected in the inertial CCS -- as a [3x3] matrix.
%   * Im -- Links inertia matrices, projected in the inertial CCS -- as a [3x3xn] matrix.
%
% See also: :func:`src.kinematics_dynamics.MCB`. 
