% function [M0_tilde,Mm_tilde]=MCB(I0,Im,Bij,Bi0,robot)
% Computes the Mass Composite Body Matrix (MCB) of the multibody system.
%
% [M0_tilde,Mm_tilde]=MCB(I0,Im,Bij,Bi0,robot)
%
% :parameters: 
%   * I0 -- Base-link inertia matrix, projected in the inertial CCS -- as a [3x3] matrix.
%   * Im -- Links inertia matrices, projected in the inertial CCS -- as a [3x3xn] matrix.
%   * Bij -- Twist-propagation matrix (for manipulator i>0 and j>0) -- as a [6x6xn] matrix.
%   * Bi0 -- Twist-propagation matrix (for i>0 and j=0) -- as a [6x6xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * M0_tilde -- Base-link mass composite body matrix -- as a [6x6] matrix .
%   * Mm_tilde -- Manipulator mass composite body matrix -- as a [6x6xn] matrix.
%
% See also: :func:`src.kinematics_dynamics.I_I`. 
