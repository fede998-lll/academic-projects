% function [Bij,Bi0,P0,pm]=DiffKinematics(R0,r0,rL,e,g,robot)
% Computes the differential kinematics of the multibody system.
%
% [Bij,Bi0,P0,pm]=DiffKinematics(R0,r0,rL,e,g,robot)
% 
% :parameters:
%   * R0 -- Rotation matrix from the base-link CCS to the inertial CCS -- [3x3].
%   * r0 -- Position of the base-link center-of-mass with respect to the origin of the inertial frame, projected in the inertial CCS -- [3x1].
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * e -- Joint rotation/sliding axes, projected in the inertial CCS -- as a [3xn] matrix.
%   * g -- Vector from the origin of the ith joint CCS to the origin of the ith link CCS, projected in the inertial CCS -- as a [3xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return:
%   * Bij -- Twist-propagation matrix (for manipulator i>0 and j>0) -- as a [6x6xn] matrix.
%   * Bi0 -- Twist-propagation matrix (for i>0 and j=0) -- as a [6x6xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%
% Use :func:`src.kinematics_dynamics.Kinematics` to compute ``rL,e``, and ``g``.
%
% See also: :func:`src.kinematics_dynamics.Kinematics` and :func:`src.kinematics_dynamics.Jacob`. 