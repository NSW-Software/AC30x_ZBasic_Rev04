while 1
		if SCAN_EVENT(IN(8)) < 0  then 'EMO change start from on to off
			PRINT "DI8 EMO Activated."
			EMO_Active = 1
		
			RAPIDSTOP(2)
			WDOG = 0 'Disable all axes 0:Disable 1:Enable
			RAPIDSTOP(3)
			
			GXYZStatus=4
			GX2Y2Z2Status=4
				
			 for i = 2 to 21
				 if PROC_STATUS(i)= 1 THEN
					STOPTASK(i)
				  ENDIF 
				 next
				 
			WHILE IN(8) = OFF 
			   RAPIDSTOP(2)	
			   IF SCAN_EVENT(IN(8)) > 0 THEN EXIT WHILE
			WEND
			
			DELAY(1000)
			PRINT "DI8 EMO Released."
			EMO_Active =0 
			WDOG =1
		endif
Wend
END