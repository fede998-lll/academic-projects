% function [RJ,RL,rJ,rL,e,g]=Kinematics(R0,r0,qm,robot)
% Computes the kinematics -- positions and orientations -- of the multibody system.
%
% [RJ,RL,rJ,rL,e,g]=Kinematics(R0,r0,qm,robot)
%
% :parameters: 
%   * R0 -- Rotation matrix from the base-link CCS to the inertial CCS -- [3x3].
%   * r0 -- Position of the base-link center-of-mass with respect to the origin of the inertial frame, projected in the inertial CCS -- [3x1].
%   * qm -- Displacements of the active joints -- [n_qx1].
%   * robot -- Robot model (see :doc:`/Tutorial_Robot`).
%
% :return: 
%   * RJ -- Joints CCS 3x3 rotation matrices with respect to the inertial CCS  -- as a [3x3xn] matrix.
%   * RL -- Links CCS 3x3 rotation matrices with respect to the inertial CCS -- as a [3x3xn] matrix.
%   * rJ -- Positions of the joints, projected in the inertial CCS -- as a [3xn] matrix.
%   * rL -- Positions of the links, projected in the inertial CCS -- as a [3xn] matrix.
%   * e -- Joint rotation/sliding axes, projected in the inertial CCS -- as a [3xn] matrix.
%   * g -- Vector from the origin of the ith joint CCS to the origin of the ith link CCS, projected in the inertial CCS -- as a [3xn] matrix.
%
% Remember that all the ouput magnitudes are projected in the **inertial frame**.
%
% Examples on how to retrieve the results from a specific link/joint:
%
%   To retrieve the position of the ith link: ``rL(1:3,i)``.
%
%   To retrieve the rotation matrix of the ith joint: ``RJ(1:3,1:3,i)``.   
%
% See also: :func:`src.robot_model.urdf2robot` and :func:`src.robot_model.DH_Serial2robot`.
