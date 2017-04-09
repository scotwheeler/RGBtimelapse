#pragma rtGlobals=1		// Use modern global access method.
#pragma version=3.0 //last edited scot 22/12/2015

Menu "Macros"

"Documentation...",		showDSHelp();
"Single Camera Control...", buildSingleCamPanel();
"Dual Camera Control...", buildDualCamPanel();

End

function screenshotcontrols(ctrl):ButtonControl
string ctrl
execute/Q "buildSingleCamPanel()"
end

structure WMGrabberHookStruct
	int32 version						 
	char winName[32]
	char eventName[32]
	int32 windowWidth						 
	int32 windowHeight					 
	int32 imageWidth
	int32 imageHeight
	int32 mouseX
	int32 mouseY 
endStructure

Function myGrabberHook(s)
	struct WMGrabberHookStruct &s
	
	String str
	sprintf str,"WIN=%s,  EVENT=%s,  MouseX=%d,  MouseY=%d", s.winName,s.eventName,s.mouseX,s.mouseY
	SetVariable setvar0 value=_STR:str
End


Function initGrabberButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber INIT"
		break
	endswitch

	return 0
End

Function cam1ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber /W=win1 newWin=1"
		break
	endswitch

	return 0
End

Function cam0ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win0 newWin=0"
			break
	endswitch

	return 0
End

Function grab0ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/w=win0 grabFrame"
			break
	endswitch

	return 0
End

Function grab1ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win1 grabFrame"
			break
	endswitch

	return 0
End

Function quit0ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win0 closeWindow"
			break
	endswitch

	return 0
End

Function quit1ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win1 closeWindow"
			break
	endswitch

	return 0
End


Function cam0QualityButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win0 showQuality"
			break
	endswitch

	return 0
End

Function cam1QualityButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win1 showQuality"
			break
	endswitch

	return 0
End

Function format0ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win0 showFormat"
			break
	endswitch

	return 0
End

Function format1ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win1 showFormat"
			break
	endswitch

	return 0
End

Function videoProp0ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win0 showVideoPrefs"
		break
	endswitch

	return 0
End

Function videoProp1ButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			Execute "Grabber/W=win1 showVideoPrefs"
		break
	endswitch

	return 0
End

Function activateGenericCheckProc(cba) : CheckBoxControl
	STRUCT WMCheckboxAction &cba

	switch( cba.eventCode )
		case 2: // mouse up
			Variable checked = cba.checked
			if(checked)
				Execute "  Grabber/w=win0 namedHook={hook1,myGrabberHook}"
			else
				Execute "  Grabber/w=win0 namedHook={hook1,$\"\"}"
				SetVariable setvar0 value=_STR:""
			endif
	endswitch

	return 0
End

Function aboutButtonProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	switch( ba.eventCode )
		case 2: // mouse up
			showDSHelp()
		break
	endswitch

	return 0
End


Function buildDualCamPanel()
	NewPanel/K=1 /W=(753,61,1110,351) as "Dual Camera Control"
	DoWindow/C twoCamPanel
	Button button0,pos={101,44},size={120,20},proc=initGrabberButtonProc,title="Initialize Grabber"
	Button button1,pos={21,74},size={120,20},proc=cam0ButtonProc,title="Camera0"
	Button button2,pos={199,75},size={120,20},proc=cam1ButtonProc,title="Camera1"
	Button button3,pos={21,99},size={120,20},proc=grab0ButtonProc,title="Grab Frame"
	Button button4,pos={199,98},size={120,20},proc=grab1ButtonProc,title="Grab Frame"
	Button button5,pos={28,248},size={120,20},proc=quit0ButtonProc,title="Quit"
	Button button6,pos={202,248},size={120,20},proc=quit1ButtonProc,title="Quit"
	Button button7,pos={21,123},size={120,20},proc=cam0QualityButtonProc,title="Quality"
	Button button8,pos={199,121},size={120,20},proc=cam0QualityButtonProc,title="Quality"
	Button button9,pos={21,146},size={120,20},proc=format0ButtonProc,title="Format"
	Button button10,pos={199,146},size={120,20},proc=format1ButtonProc,title="Format"
	Button button11,pos={20,169},size={120,20},proc=videoProp0ButtonProc,title="Video Properties"
	Button button12,pos={200,169},size={120,20},proc=videoProp1ButtonProc,title="Video Properties"
	CheckBox check0,pos={67,197},size={170,14},proc=activateGenericCheckProc,title="Activate Generic Hook Function"
	CheckBox check0,value= 0
	SetVariable setvar0,pos={13,220},size={329,16},bodyWidth=329,title=" "
	SetVariable setvar0,value= _STR:""
	Button button01,pos={101,6},size={120,20},proc=aboutButtonProc,title="About"
End


Function showDSHelp()
	notebook DSGrabber_Demo visible=2
End


Function buildSingleCamPanel()
	NewPanel /K=1 /W=(745,59,1102,349) as "Camera Control"
	DoWindow/C singleCamPanel
	Button button0,pos={22,44},size={120,20},proc=initGrabberButtonProc,title="Initialize Grabber"
	Button button1,pos={21,74},size={120,20},proc=cam0ButtonProc,title="Camera0"
	Button button3,pos={21,99},size={120,20},proc=grab0ButtonProc,title="Grab Frame"
	Button button5,pos={28,248},size={120,20},proc=quit0ButtonProc,title="Quit"
	Button button7,pos={21,123},size={120,20},proc=cam0QualityButtonProc,title="Quality"
	Button button9,pos={21,146},size={120,20},proc=format0ButtonProc,title="Format"
	Button button11,pos={22,169},size={120,20},proc=videoProp0ButtonProc,title="Video Properties"
	CheckBox check0,pos={67,197},size={170,14},proc=activateGenericCheckProc,title="Activate Generic Hook Function"
	CheckBox check0,value= 0
	SetVariable setvar0,pos={13,220},size={329,16},bodyWidth=329,title=" "
	SetVariable setvar0,value= _STR:""
	Button button01,pos={22,6},size={120,20},proc=aboutButtonProc,title="About"
EndMacro

Window screenshotpan() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(700,70,1065,300) as "screenshotpan"
	SetDrawLayer UserBack
	SetDrawEnv fillfgc= (56576,56576,56576)
	DrawRect 0,9,243,117
	Button button0,pos={253,103},size={100,50},proc=timelapse,title="Make \rMovie"
	Button button1,pos={253,13},size={100,50},proc=screengrabing,title="Start\rTimelapse"
	SetVariable setvar0,pos={9,20},size={181,16},bodyWidth=100,title="Timelapse name"
	SetVariable setvar0,value= root:AqParams:screengrabname
	SetVariable setvar1,pos={9,72},size={121,16},bodyWidth=60,title="Interval time"
	SetVariable setvar1,format="%1.2f s",value= root:AqParams:screengrabperiod
	SetVariable setvar2,pos={9,45},size={157,16},bodyWidth=60,title="Timelapse total time"
	SetVariable setvar2,format="%1.0f s",value= root:AqParams:screengrabtime
	Button button2,pos={252,72},size={100,20},proc=screenshotcontrols,title="Built in controls"
	SetVariable setvar3,pos={9,126},size={114,16},bodyWidth=60,title="Frame rate"
	SetVariable setvar3,format="%1.0f /s",value= root:AqParams:framerate
	CheckBox check0,pos={9,94},size={66,14},title="Auto save",value= 0
	Button button3,pos={253,166},size={100,50},proc=AnalysetimelapseBUT,title="Analyse \rTimelapse"
	CheckBox check1,pos={10,153},size={102,14},title="Add time to movie",value= 0
	ValDisplay movper,pos={13,189},size={194,18}
	ValDisplay movper,limits={0,100,0},barmisc={0,0},mode= 3
	ValDisplay movper,value= #"root:AqParams:movpercent"
	ValDisplay tothrs,pos={172,45},size={50,14},format="%0.2f hrs"
	ValDisplay tothrs,limits={0,0,0},barmisc={0,1000}
	ValDisplay tothrs,value= #"root:AqParams:tottimehrs"
	ValDisplay interhrs1,pos={137,73},size={50,14},format="%0.2f hrs"
	ValDisplay interhrs1,limits={0,0,0},barmisc={0,1000}
	ValDisplay interhrs1,value= #"root:AqParams:intertimehrs"
	ToolsGrid snap=1,visible=1
EndMacro

function createvariables()
//create the required variables in AqParams if don't already exist
string datafolder=getdatafolder(1)
setdatafolder root:AqParams
	NVAR/Z screengrabtime=root:aqparams:screengrabtime
	if( !NVAR_Exists(screengrabtime) )
		variable/G screengrabtime=600
	endif
	NVAR/Z screengrabperiod=root:aqparams:screengrabperiod
	if( !NVAR_Exists(screengrabperiod) )
		variable/G screengrabperiod=60
	endif
	NVAR/Z framerate=root:aqparams:framerate
	if( !NVAR_Exists(framerate) )
		variable/G framerate=10
	endif
	NVAR/Z movpercent=root:aqparams:movpercent
	if( !NVAR_Exists(movpercent) )
		variable/G movpercent=0
	endif
	NVAR/Z tottimehrs=root:aqparams:tottimehrs
	if( !NVAR_Exists(tottimehrs) )
		variable/G tottimehrs
		string nonperm="screengrabtime/3600"
		setformula tottimehrs, nonperm
	endif
	NVAR/Z intertimehrs=root:aqparams:intertimehrs
	if( !NVAR_Exists(intertimehrs) )
		variable/G intertimehrs
		string nonperm2="screengrabperiod/3600"
		setformula tottimehrs, nonperm2
	endif
	SVAR/Z screengrabname=root:aqparams:screengrabname
	if( !SVAR_Exists(screengrabname) )
		string/G screengrabname="Enter_exp_name"
	endif
setdatafolder datafolder

End

function screenshotBut(ctrl):ButtonControl
	string ctrl
	DoAlert 0, "Have you saved to a new experiment?\rIf no, do so now!"
	createvariables()
	
	dowindow/F screenshotpan
	if (V_Flag==0)
		execute "screenshotpan()"
	endif
end

function screengrabing(ctrl):ButtonControl
	string ctrl
	SVAR screengrabname=root:aqparams:screengrabname
	NVAR screengrabtime=root:aqparams:screengrabtime
	NVAR screengrabperiod=root:aqparams:screengrabperiod
	NVAR/Z scope=root:aqparams:scope
	if( !NVAR_Exists(scope) )
		scope=0
	endif
	
	
	variable starttime,i,pictime, humidity, humidityStd
	string executestring, newwavename,currentdatafolder,timewavnam,humidwavenam
	timewavnam=screengrabname+"_time"
	humidwavenam=screengrabname+"_humid"
	currentdatafolder=getdatafolder(1)
	
	newdatafolder/O/S $(screengrabname) //create and go to new subfolder
	Execute "Grabber INIT" // initialises camera
	NVAR Grabber_Error
	
	Execute "Grabber/Z/W=camera bringToFront"
	if (Grabber_Error!=0)
		Execute "Grabber/W=camera newWin=0"
	endif
	
	sleep/S 3
	starttime=datetime
	i=0
	
	string timestring =secs2time((starttime+screengrabtime),3)+" "+secs2date((starttime+screengrabtime),-1)
	string timepanelexec="scotfininfo(\""+timestring+"\")"
	
	if (exists("scotfininfo")==5) //check if procedure is avaliable 
		execute timepanelexec
	endif
	DOUPDATE
	
	do
		if (GetKeyState(0) == 32)//stops procedure if esc button held till next loop
			break
		endif
		newwavename=screengrabname+"_"+num2str(i)
		executestring="Grabber/w=camera outwavename="+newwavename+" grabFrame "
		// record time
		make/O /N=(i+1) $(timewavnam)
		wave timewav=$(timewavnam)
		pictime=datetime
		timewav[i]=pictime-starttime
		if(scope==1) //record humidity for Seb's environment chamber
			make/O /N=(i+1) $(humidwavenam)
			wave humidwav=$(humidwavenam)
			if (exists("GetHumidity")==6)
				string exec="humidity=GetHumidity(humidityStd)"
				execute/Q/Z exec
			endif
			//humidity=GetHumidity(humidityStd)
			humidwav[i]=humidity
		endif
		
		Execute executestring
		
		sleep/C=1/S (screengrabperiod-(datetime-pictime))
		print newwavename
		note $(newwavename),num2str(datetime-starttime)
		
		controlinfo/W=screenshotpan check0
		if (V_Value==1)
			if (mod(i,20)==0)//and the autosave is clicked?
				saveexperiment
				print "Experiment autosave"
			endif
		endif
		
		i+=1
	
	while ((datetime-starttime)<screengrabtime)
	
	Execute "Grabber/W=camera closeWindow"
	setdatafolder currentdatafolder // go back to top folder
	print "experiment finished"
	if (exists("scotfininfo")==5) //check if procedure is avaliable 
		killwindow scotfininfo
	endif



end

function timelapse(ctrl):Buttoncontrol
string ctrl
	NVAR/Z percentage=root:AqParams:movpercent
		if(!NVAR_Exists(percentage))
			Variable /G root:AqParams:movpercent=0
			NVAR percentage=root:AqParams:movpercent
		endif
	SVAR screengrabname=root:aqparams:screengrabname
	NVAR framerate=root:aqparams:framerate

	string currentdatafolder,wavetodisplay, legendstring
	
	variable i,n
	dowindow/K timelapsing
	currentdatafolder=getdatafolder(1)
	setdatafolder $(screengrabname)
	wave timewave=$(screengrabname+"_time")
	variable times=0
	n=0
	do
		n+=1
	while(waveexists($(screengrabname+"_"+num2str(n)))==1)
	print n
	i=0
	do
		wavetodisplay=screengrabname+"_"+num2str(i)
		times=timewave[i]/60 //time into minutes
		if (times<2) //if less than 2 mins, display in seconds
			times*=60
			times=round(times)
			legendstring=num2str(times)+"secs"
		elseif (times>=2&&times<300) // display 2-300 mins
			times*=100
			times=round(times)
			times/=100
			legendstring=num2str(times)+"mins"		
		elseif (times>=300&&times<2880) //greater than 300 mins in hrs
			times/=60 //put into hours
			times*=100
			times=round(times)
			times/=100
			legendstring=num2str(times)+"hrs"
		elseif (times>=2880)//greater than 48hrs in days
			times/=1440
			times*=100
			times=round(times)
			times/=100
			legendstring=num2str(times)+"days"
		endif
		
		dowindow/F timelapsing
		if (V_Flag==0)
			Newimage/N=timelapsing /s=1 $(wavetodisplay)
			controlinfo/W=screenshotpan check1
			if(V_Value==1)
				TextBox/C/N=text0/F=0 legendstring
			endif
			doupdate
			newmovie/F=(framerate)
			addmovieframe
			
		else
			appendimage/W=timelapsing $(wavetodisplay)
			controlinfo/W=screenshotpan check1
			if(V_Value==1)
				TextBox/C/N=text0/F=0 legendstring
			endif
			doupdate
			addmovieframe
		
		endif
		
		//sleep/S 0.1
		i+=1
		percentage=(i/n)*100
		doupdate
	
	
	while(waveexists($(screengrabname+"_"+num2str(i)))==1)
	closemovie



	setdatafolder currentdatafolder 
end


#pragma rtGlobals=3		// Use modern global access method and strict wave access.

function tracktimelapse(ctrl):buttoncontrol
	string ctrl
	SVAR screengrabname=root:AqParams:screengrabname
	NVAR diam=root:AqParams:squarepixel
	string currentdatafolder=getdatafolder(1)
	variable i,j,k,m,n
	variable numofdev

	string execstring, devposlist,wavname
	setdatafolder screengrabname
	newimage/N=trackingselect $(screengrabname+"_0")
	showinfo
	prompt numofdev, "How many devices do you want to track?"
	doprompt "Enter number of devices",numofdev
	make/O/N=(numofdev) devnum,xpos,ypos
	wave xpos=xpos
	wave ypos=ypos
	for (i=0;i<numofdev;i+=1) //find the devices
		execstring="selwithcur("+num2str(i+1)+")"
		Execute execstring
		pauseforuser selwithcur,trackingselect
		devnum[i]=i+1
		xpos[i]=pcsr(A)
		ypos[i]=qcsr(A)
		dowindow/F trackingselect
		print ypos[i],xpos[i]
		SetDrawEnv xcoord= top,ycoord= left;DelayUpdate
		drawrect (xpos[i]-diam),(ypos[i]-diam),(xpos[i]+diam),(ypos[i]+diam) //left top right bottom
		doupdate
	endfor
	variable avgred,avggreen,avgblue
	do //creates red,green,blue wave for each device

		wavname=screengrabname+"_dev"+num2str(j+1)
		k=0
		do
			k+=1
		while(waveexists($(screengrabname+"_"+num2str(k+1))))
		k+=1
		make/O/N=((k),3,0,0) $(wavname)
		wave avgwave=$(wavname)
		make/O/N=(k) $(wavname+"mean")//wave for (R+G+B)/3
		wave avgwavemean=$(wavname+"mean")
	
		k=0
		do // red green and blue here for all times
			avgred=0
			avggreen=0
			avgblue=0
			wave timewave=$(screengrabname+"_"+num2str(k))
			for (m=0;m<((diam*2)+1);m+=1) //adds all rows
				for (n=0;n<((diam*2)+1);n+=1) //adds all cols in row 
					avgred+=timewave[(xpos[j]-diam+m)][(ypos[j]-diam+n)][0]
					avggreen+=timewave[(xpos[j]-diam+m)][(ypos[j]-diam+n)][1]
					avgblue+=timewave[(xpos[j]-diam+m)][(ypos[j]-diam+n)][2]
				endfor
			endfor
			avgred=avgred/((2*diam+1)^2)
			avggreen=avggreen/((2*diam+1)^2)
			avgblue=avgblue/((2*diam+1)^2)
		
			avgwave[k][0]=avgred
			avgwave[k][1]=avggreen
			avgwave[k][2]=avgblue
	
			k+=1
		while(waveexists($(screengrabname+"_"+num2str(k))))
		k-=1 //back 1 to the total number of time points
	
		variable s=0
		do
			avgwavemean[s]=(avgwave[s][0]+avgwave[s][1]+avgwave[s][2])/3
			s+=1
		while(s<k)
		j+=1
	while(j<numofdev)

	setdatafolder currentdatafolder
	variable/G numofdevG=numofdev
	
	execute "plottimelapse(\"ctrl\")"
End

Window selwithcur(dev) : Panel
	variable dev
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(1247,278,1478,379) as "selwithcur"
	SetDrawLayer UserBack
	DrawText 49,32,"Select device "+num2str(dev)+" with cursor"
	Button button0,pos={89,51},size={60,20},proc=selwithcurbut,title="Continue"
EndMacro

function selwithcurbut(ctrl):ButtonControl //closes the selection window
	string ctrl
	killwindow selwithcur
end

function plottimelapse(ctrl):buttoncontrol
string ctrl
	SVAR screengrabname=root:AqParams:screengrabname
	//NVAR numofdevG
	string devwavnam
	variable i=1
	string currentdatafolder=getdatafolder(1)
	setdatafolder screengrabname
	wave timewav=$(screengrabname+"_time")
	
	do 
	devwavnam=screengrabname+"_dev"+num2str(i)
	wave devwav=$(devwavnam)
	wave devmeanwav=$(devwavnam+"mean")
	display/N=$(devwavnam) devwav[][0]/TN=red vs timewav as devwavnam
	appendtograph devwav[][1]/TN=green vs timewav
	appendtograph devwav[][2]/TN=blue vs timewav
	appendtograph devmeanwav/TN=meann vs timewav
	modifygraph rgb[0]=(65535,0,0),rgb[1]=(0,65535,0),rgb[2]=(0,0,65535),rgb[3]=(0,0,0)
	setaxis left,0,256
	label bottom "Time /S"
	label left "RGB colour 0-256"
	
	
	i+=1
	while (waveexists($(screengrabname+"_dev"+num2str(i)))==1)


	setdatafolder currentdatafolder

end

Window Analysetimelapse() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel/K=1 /W=(427,226,727,426) as "Analysetimelapse"
	SetVariable setvar0,pos={9,20},size={181,16},bodyWidth=100,title="Timelapse name"
	SetVariable setvar0,value= root:AqParams:screengrabname
	SetVariable setvar3,pos={19,54},size={127,16},bodyWidth=60,title="Square pixels"
	SetVariable setvar3,format="%1.0f pixels²",value= root:AqParams:squarepixel
	Button button0,pos={171,126},size={100,50},proc=plottimelapse,title="Plot RGB"
	Button button1,pos={17,126},size={100,50},proc=tracktimelapse,title="Analyse timelapse"
	ToolsGrid snap=1,visible=1
EndMacro

function AnalysetimelapseBUT(ctrl):ButtonControl
	string ctrl
	dowindow/F Analysetimelapse
	if (V_Flag==0)
		execute "Analysetimelapse()"
	endif

End

