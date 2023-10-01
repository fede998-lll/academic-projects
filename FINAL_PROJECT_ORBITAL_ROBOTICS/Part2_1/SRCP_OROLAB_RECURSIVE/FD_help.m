% function [u0dot,umdot] = FD(tau0,taum,wF0,wFm,t0,tm,P0,pm,I0,Im,Bij,Bi0,u0,um,robot)
% This function solves the forward dynamics (FD) problem (it obtains the
% acceleration from  forces).
%
% [u0dot,umdot] = FD(tau0,taum,wF0,wFm,t0,tm,P0,pm,I0,Im,Bij,Bi0,u0,um,robot)
%
% :parameters: 
%   * tau0 -- CONTROL Base-link forces [n,f]. The torque n is projected in the body-fixed CCS, while the force f is projected in the inertial CCS -- [6x1].
%   * taum -- CONTROL Joint forces/torques -- as a [n_qx1] matrix.
%   * wF0 -- ENVIRONMENTAL Wrench acting on the base-link center-of-mass [n,f], projected in the inertial CCS -- as a [6x1] matrix.
%   * wFm -- ENVIRONMENTAL Wrench acting on the links center-of-mass  [n,f], projected in the inertial CCS -- as a [6xn] matrix.
%   * t0 -- Base-link twist [\omega,rdot], projected in the inertial CCS -- as a [6x1] matrix.
%   * tm -- Manipulator twist [\omega,rdot], projected in the inertial CCS -- as a [6xn] matrix.
%   * P0 -- Base-link twist-propagation "vector" -- as a [6x6] matrix.
%   * pm -- Manipulator twist-propagation "vector" -- as a [6xn] matrix.
%   * I0 -- Base-link inertia matrix, projected in the inertial CCS -- as a [3x3] matrix.
%   * Im -- Links inertia matrices, projected in the inertial CCS -- as a [3x3xn] matrix.
%   * Bij -- Twist-propagation matrix (for manipulator i>0 and j>0) -- as a [6x6xn] matrix.
%   * Bi0 -- Twist-propagation matrix (for i>0 and j=0) -- as a [6x6xn] matrix.
%   * u0 -- Base-link velocities [\omega,rdot]. The angular velocity is projected in the body-fixed CCS, while the linear velocity is projected in the inertial CCS -- [6x1].
%   * um -- Joint velocities -- [n_qx1].
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * u0dot -- Base-link accelerations [\omegadot,rddot]. The angular acceleration is projected in a body-fixed CCS, while the linear acceleration is projected in the inertial CCS -- [6x1].
%   * umdot -- Manipulator joint accelerations -- [n_qx1].
%
% See also: :func:`src.kinematics_dynamics.ID` and :func:`src.kinematics_dynamics.I_I`. 