Welcome to BeatBox!

For Windows users, double click the app to run. This requires Java version 8.0 or later.
For Mac/Linux users, you will need to install Processing version 3.0 or later as well as the "Sound" library. From there, double click on any of the source files, and run in Processing.
If the application doesn't work, open in Processing.

The UI is fairly simple. The red page contains controls to start and stop the playback feature, as well as volume sliders for each of the instruments. The blue and green pages are fairly similar, and contain "Undo" and "Clear" buttons. They also contain sliders to control the ADSR (Attack, Decay, Sustain, and Release) of their notes. The yellow instrument is relatively self-explanatory.

Sometimes the audio engine becomes too overloaded and crashes. There is no known fix for this; the crash bounces back to libraries that I cannot access. Please try to avoid overloading the audio engine. You will hear clipping when it starts having trouble.


This app was made on 11/4/2018 by Jonathan Bischoff for VandyHacksV.
It uses the default "Sound" library in Processing 3.0, with additional functionality built around some of the classes, (for example my SmartEnv and SmartOsc classes that extend Env and Osc)

Enjoy!
