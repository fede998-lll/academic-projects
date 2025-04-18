function DCM = Angles123_DCM(Angles) %#codegen
% Convert the Euler angles (123 sequence), x-phi, y-theta, z-psi to DCM.
%
% DCM = Angles123_DCM(Angles)
%
% :parameters: 
%   * Angles -- Euler angles [x-phi, y-theta, z-psi] -- [3x1].
%
% :return: 
%   * DCM -- Direction Cosine Matrix -- [3x3].
%
% See also: :func:`src.attitude_transformations.Angles321_DCM` and :func:`src.attitude_transformations.DCM_Angles321`.