# Motion-Sickness-Dynamics

This code is intended to serve as an implementation to the motion sickness dynamics model presented in Experimental Brain Research.\
Matlab 2022b was used to save the Simulink File, so this version or later is required to run the code.\

Within the 'Main.m' file, you can define a 'Custom' motion profile, and the environment G-level can also be defined here.\
The motion profile is defined for columns 1-3 are being xyz position and columns 4-6 are xyz rotations.\

You can also run some pre-definied examples such as:\
'Cian' (Cian et al. 2011). The motion profile \
'Gravity Transition'a 1g-0g gravity transition without adaptation over time\

The final output of the file is the following:
![Screenshot](ExampleOutput.png)

