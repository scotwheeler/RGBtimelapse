# RGBtimelapse

A program in IGOR Pro to measure a timelapse using a connected webcam. Areas of the image can be selected and the RGB monitored over time. Designed to measure degredation of solar cell material films.  

Before running:
You need to create a shortcut in the IGOR User Files extensions folder (Help -> Show Igor Pro User Files) 
to the frame grabber extension which is located in the wavemetrics folder 
(C:\Program Files (x86)\WaveMetrics\Igor Pro Folder\More Extensions\Data Acquisition\Frame Grabbers\DSXOP\DSXop.xop).

Plug in, and install driver for your chosen webcam.

Open IGOR timecapture experiment. 

Procedures: scotwebcam.ipf is required (in timecapture folder in marvin) and scotCETPVanalysis.ipf helps.

Once open:

Save as a new file!

Click the main Timecapture button on the home panel
(If integrating this software into another experiment, a copy of this main button can be used as access)

To check webcam is working, click: Built in controls -> initialize Grabber -> Camera0. 
This should display a panel with a live webcam feed. 
These camera controls can also be used to change camera properties. 
When finished, click Quit to exit camera window, and close camera control panel. 

To run the timecapture, enter a new experiment name. This should be done for each succesive capture.
Enter the total time for the experiment to run in seconds, and the time period between each picture. 
'Auto save' will save the experiment every 10 pictures if selected. 
Click ' Start Timelapse' to begin. 

To make a movie:

Make sure the correct timelapse name is entered. (You should always be working relative to the root folder). 
Enter the number of frames per second for the movie. 
Select 'Add time to movie' if you want the time (from the start of the experiment) to be displayed. 
Click, 'Make Movie'. 

To Analyse the colour change in a timelapse:

Make sure the correct timelapse name is entered. (You should always be working relative to the root folder). 

 TBC
