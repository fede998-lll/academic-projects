function r_com = Center_of_Mass(r0,rL,robot)
% Computes the center-of-mass (CoM) of the system.
%
% r_com = Center_of_Mass(r0,rL,robot)
%
% :parameters: 
%   * r0 -- Position of the base-link, projected in the inertial CCS -- [3x1].
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return:
%   * r_com -- Location of the center-of-mass, projected in the inertial CCS  -- [3x1].
%
% Use :func:`src.kinematics_dynamics.Kinematics` to compute ``rL``.
%
% This function can also be used to compute the velocity/acceleration of the center-of-mass.
% To do it use as paremeters the velocities ``r0dot,rLdot`` or acceleration ``r0ddot,rLddot`` and you will get the CoM  velocity ``rcomdot`` or acceleration ``rcomddot``.
%
% See also: :func:`src.kinematics_dynamics.Kinematics`