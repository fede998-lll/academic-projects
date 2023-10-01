% function [robot,T_Ln_EE] = DH_Serial2robot(DH_data)

% Transforms a description of a multibody system, provided in Denavit-Hartenberg parameters, into a robot model sructure.
%
% [robot,T_Ln_EE] = DH_Serial2robot(DH_data)
%
% :parameters: 
%   * DH_data -- Structure containing the DH parameters. (see :doc:`/DH`).
%
% :return: 
%   * robot -- Robot model (see :doc: `/Tutorial_Robot`).doc 
%   * T_Ln_EE -- Homogeneous transformation matrix from end-effector to Last Link CCS --[4x4].
%
% **DH descriptions are only supported for serial configurations**.