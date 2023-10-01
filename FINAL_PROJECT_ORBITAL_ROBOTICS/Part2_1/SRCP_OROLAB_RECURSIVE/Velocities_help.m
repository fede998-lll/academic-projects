% function [t0,tL]=Velocities(Bij,Bi0,P0,pm,u0,um,robot)
% Computes the operational-space velocities of the multibody system.
%
% [t0,tL]=Velocities(Bij,Bi0,P0,pm,u0,um,robot)
%
% :parameters:
%   * Bij -- Twist-propagation matrix (for manipulator i>0 and j>0) -- as a [6x6xn] matrix.
%   * Bi0 -- Twist-propagation matrix (for i>0 and j=0) -- as a [6x6xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * u0 -- Base-link velocities [\omega,rdot]. The angular velocity is projected in the body-fixed CCS, while the linear velocity is projected in the inertial CCS -- [6x1].
%   * um -- Joint velocities -- [n_qx1].
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return:
%   * t0 -- Base-link twist [\omega,rdot], projected in the inertial CCS -- as a [6x1] matrix.
%   * tL -- Manipulator twist [\omega,rdot], projected in the inertial CCS -- as a [6xn] matrix.
%
% Use :func:`src.kinematics_dynamics.DiffKinematics` to compute ``Bij``, ``Bi0``, ``P0``, and ``pm``.
%
% See also: :func:`src.kinematics_dynamics.Jacob`