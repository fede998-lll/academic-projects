## ITA

Strumento software di analisi per il movimento orbitale e l'assetto/configurazione planare di un sistema Satellite-Manipolatore Robotico in orbita intorno alla Terra - Politecnico di Torino - Torino, ITALIA

Il progetto si concentra sull'analisi del movimento di un manipolatore robotico su un veicolo in volo libero in orbita. Le ipotesi includono il movimento nel piano dell'orbita e un bersaglio in orbita circolare a un'altitudine di 500 km. Sono state stabilite specifiche riguardanti le masse del manipolatore e del corpo di base. L'analisi comprende sia il movimento traslazionale che rotazionale interno del veicolo. Il team è composto da 4 membri.

## ENG

Software tool for analysis of orbital motion and planar configuration of a Satellite-Robotic Manipulator system in orbit around Earth - Politecnico di Torino - Turin, ITALY

The project focuses on analyzing the motion of a robotic manipulator on a free-flying vehicle in orbit. Assumptions include motion in the orbit plane and a target in circular orbit at an altitude of 500 km. Specifics regarding the masses of the manipulator and the base body have been established. The analysis includes both translational and internal rotational motion of the vehicle. The team consists of 4 members.

## Software Overview

This repository contains software implementations related to aerospace engineering and physics. It includes various codes and simulations for different purposes. Below is a brief overview of each section:

### Part 1: Orbital Mechanics

#### 1.2 HCW Figures

- File: `HCW_Figures.m`
- Description: This code calculates the trajectory of an object in the z-direction, given initial conditions. It assumes an unforced system and generates paths over time for various initial conditions.

To run:
```bash
Part1_2 >> HCW_IC_MakeFigs.m
```

#### 1.3 Optimized Trajectory

- File: `MainExercise1.3.m`
- Description: This code helps find an optimized trajectory between two impulses. Users input initial conditions, spacecraft mass, and mean heights, and the code calculates the optimized deltaV and path.

To run:
```bash
Part1_3 >> Main.Excercise1_3.m
```

#### 1.4 Animation Design

- File: `Animation_Design.m`
- Description: This code provides a game-like simulation where users input DeltaV components. It generates optimized paths and allows users to interactively change the path. An animation is created as well.

To run:
```bash
Part1_4 >> Animation.Design.m
```

### Part 2: Robot Manipulator

#### 2.1 Robot Manipulator Analysis

- File: `FFP6L5R_PlotFigures.m`
- Description: This code analyzes a robot manipulator with specified masses and arm lengths. It calculates torques and forces, considering gravity gradients, and provides results.

To run:
```bash
Part2.1 >> SCRIPTS >> CASE_FF_P_6L_5R >> FFP6L5R_PlotFigures.m
```

#### 2.2 Free-Flyer Animation

- File: `main.m`
- Description: This code creates an animation of a free flyer using input positions and angles of elements. The design evolves during the simulation.

To run:
```bash
Part2_2 >> main.m
```

Please refer to each section's folder for detailed instructions and additional files if necessary.
