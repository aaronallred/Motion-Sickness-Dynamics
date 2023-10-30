# Motion-Sickness-Dynamics

This code is intended to serve as an implementation to the motion sickness dynamics model presented in Experimental Brain Research.\
Simulink v. 2023b is required to run the observer model with motion sickness symptom dynamces. 

# Update Oct 2023
The most recent motion sickness model has updated parameters for the sensory weights and motion sickness dynamics. Originally, the model was trained used a Ka gain of -0.5, and the prior MS dynamics corresponded to this augmented set of perceptual parameters, the rest of the parameters are provided in Newman 2009 and Clark et al. 2019 (per the refernces in our paper).

# Run Simulations
Within the 'Main.m' file, you can define a 'Custom' motion profile, and the environment G-level can also be defined here.\
The motion profile is defined for columns 1-3 are being xyz position and columns 4-6 are xyz rotations.

You can also run some pre-definied examples such as:\
'Cian' (Cian et al. 2011). The motion profile \
'Gravity Transition'a 1g-0g gravity transition without adaptation over time.

The final output of the file is the following:
![Screenshot](ExampleOutput.png)

