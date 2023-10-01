clear all
close all
clc
format long

fprintf('\n\nDr. MARCELLO ROMANO: Orbital Robotics & Distributed Space Systems Lab\n\n')
fprintf('Software provided as is, for educational purpose only\n\n')

pathstr = fileparts(mfilename('fullpath'));
addpath(sprintf('%s/SRCP',pathstr));
addpath(sprintf('%s/SCRIPTS',pathstr));
addpath(sprintf('%s/SRCP_OROLAB_LAGRANGE',pathstr));
addpath(sprintf('%s/SCRIPTS/CASE1_FF_P_2L_1R',pathstr));
addpath(sprintf('%s/SCRIPTS/CASE1_OPT2_FF_P_2L_1R',pathstr));
addpath(sprintf('%s/SCRIPTS/CASE1_OPT2_FF_P_2L_1R_RA',pathstr));
addpath(sprintf('%s/SCRIPTS/CASE2_FF_P_3L_2R',pathstr));
addpath(sprintf('%s/SRCP_OROLAB_RECURSIVE',pathstr));

addpath(sprintf('%s/USER_FUN',pathstr));
savepath;


cd(pathstr);