The softwares implemented are the following:
	1.2) Relatively to the first part, so 'HCW_Figures.m', needs to be passed by an initial condition for the z-variation in the third direction, while
	the other two directions have been calculated directly through-out all passages implemented. The structure is composed by several initial conditions passed 
	through a column vector and then obtaining, assuming to consider an unforced system, the desired paths passing each instant of time and a specific initial 
	condition. All results have been saved in order to help the user focusing on a specific set of values after having implemented the desired analysis.
	Each equi-spatiate time's vector has been defined onto different maximum values in order to get exactly all results showed in the slides. The process to run ,through folders, files is as follows: Part1_2 >> HCW_IC_MakeFigs.m;

	1.3) The next code, named 'MainExercise1.3.m', reflects the user's possibility to look for an optimized traiectory between two impulses. The first passage 
	is to request the user all initial conditions through keyboard, one at each, and after deciding the S/Cs' mass and mean heights, these inputs have been passed to the 	function named 'function_Min_DeltaV_maneuvers.m'. This last code evaluates at first the minimum sum between the initial and final deltaVs to obtain the desired 
	optimized deltaV and relative path as similar as has been made for 'HCW_Figures.m'. Although it wasn't required, we have decided to show also other possible 
	not-optimized paths in order to visualize physically what's happening on our path. To run it, it's necessary to open only the file named 'MainExercise1.3.m' and
	inserting gradually all desired inputs. The process to run ,through folders, files is as follows: Part1_3 >> Main.Excercise1_3.m ;

	1.4) What about the code named 'Animation_Design.m', it refers to the optional part relative to a game-like simulation in which the user has to insert through the
	keyboard each of the three DeltaV's components whenever he/she wants. The structure is composed by the first and last possible paths which have been optimized 
	with the same logic seen in the function 'function_Min_DeltaV_maneuvers.m', while the other three possible paths depend obviously on inputs given by the user.
	At each for's step, the code deletes older results and create them again to improve the numerical computation's development. All procedural steps which need to
	be accomplished have been described in detail in the code itself. To run the code it's necessary to insert all data on a command prompt that will be opened at
	first and any time the user desires to stop the simulation and changing the path to his/her wishes. The function 'mArrow3.m' doesn't need to be run because it's
	reclaimed directly on the main code 'Animation_Design' to plot the arrows for HCW CCS and DeltaVs at each simulation's break given by the user. If the user 
	would desire to see again the animation just created, on the same folder of these two codes previously described, will be written a file named 'Video.mp4' that
	will contain the animation itself, as a proof of followed choices. The process to run ,through folders, files is as follows: Part1_4 >> Animation.Design.m . We also created a second version of the animation: Part1_4 >> Second_Version_1.4 >> main.n .(To run the script you need the Machine Learning Toolbox) ; 

	2.1) The code that refers to 'CASE_FF_P_6L_5R' computes our Robot manipulator through the implementation of masses and semi-lenghts of the base-link and each of 
	links' arm. In order to provide as close as possible a better results, the gravity gradient has been implemented inside the function named 	'FFP6L5R_odefun_state2dotstate' by inserting 	it into the wrenches and then passing them to the Forward Dynamics analysis. We have computed both torques and 
	forces using this method and, at the end, will be showed the main results of this study. The main code is that named 'FFP6L5R_PlotFigures' which is capable to 
	reclaim automatically all previous codes, so 'FFP6L5R_Robot_Description', 'FFP6L5R_Simulate' and 'FFP6L5R_odefun_state2dotstate', requesting the user to insert the 	desired option for the type of joint. The structure is very similar to that we saw in lab4 and discarding the inputted wrenches given to the file 'FFP6L5R_Simulate' 	because these have been written directly onto the code 'FFP6L5R_odefun_state2dotstate' by defining torques and forces associated to the gravity-gradient. The process to run ,through folders, files is as follows: Part2.1 >> SCRIPTS >> CASE_FF_P_6L_5R >> FFP6L5R_Simulate.m >> FFP6L5R_PlotFigures.m ;

	2.2) The code in the Part2.2 folder allows you to create the free-Flyers animation. Taking as input the position of the centers of mass and each element and the relative angles to the horizontal. Through two functions xx and xx was created the design that will vary during the fourth orbit. The process to run ,through folders, files is as follows: Part2_2 >> main.m
