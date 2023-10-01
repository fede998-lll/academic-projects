% function [H0, H0m, Hm] = GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot)

% Computes the Generalized Inertia Matrix (GIM) H of the multibody vehicle.
%
% This function uses a recursive algorithm.
%
% [H0, H0m, Hm] = GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot)
%
% :parameters: 
%   * M0_tilde -- Base-link mass composite body matrix -- as a [6x6] matrix .
%   * Mm_tilde -- Manipulator mass composite body matrix -- as a [6x6xn] matrix.
%   * Bij -- Twist-propagation matrix (for manipulator i>0 and j>0) -- as a [6x6xn] matrix.
%   * Bi0 -- Twist-propagation matrix (for i>0 and j=0) -- as a [6x6xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * H0 -- Base-link inertia matrix -- as a [6x6] matrix.
%   * H0m -- Base-link -- manipulator coupling inertia matrix -- as a [6xn_q] matrix.
%   * Hm -- Manipulator inertia matrix -- as a [n_qxn_q] matrix.
%   
% To obtain the full generalized inertia matrix H:
%
% .. code-block:: matlab
%   
%   %Compute H
%   [H0, H0m, Hm] = GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot);
%   H=[H0,H0m;H0m';Hm];
%
% See also: :func:`src.kinematics_dynamics.CIM`.