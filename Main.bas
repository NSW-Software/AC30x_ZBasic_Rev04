RUN "Variables.bas"

IF EMO_ACTIVE=1 THEN
	ErrCode=10
	goto abort
ENDIF
RUN "INITSYSTEM.bas"
abort:
END




'REVISION HISTORY

'FwVersion = 1.4.0 'Razi
'FwVersionDate = 20231121
'--GAxis change from 3 to 5
'--Reassign all Axis numbers
'--Revise PPU for X2,Z2
'--Remove limit sens for GZ2
'--Change HomeMode for GZ2 from datum(3) to datum(4)
'--Change homing speed for GX2 to match XY home speed
'--Change homing speed for GY2 from 1 to 5

'FwVersion = 1.3.0 'Razi
'FwVersionDate = 20231023
'--Revise HomeMode for main GX and GY
'
'FwVersion = 1.2.0 'Razi
'FwVersionDate = 20230923
'--Refactor certain syntax to adapt to any hw firmware Version 
'
'FwVersion = 1.1.0 'Hong
'FwVersionDate = -
'
'FwVersion = 1.0.0 'Hong
'FwVersionDate = -
'--Initial release


 