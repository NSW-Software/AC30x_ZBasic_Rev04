SysState=2
ErrCode=0
RAPIDSTOP(2)
for i=0 to 15
	ATYPE(i)=1
next

IF EMO_ACTIVE=1 THEN
	ErrCode=10
	PRINT "EMO Active"
	goto endError
ENDIF

SLOT_SCAN(0)
IF RETURN=0 THEN
	ErrCode=100
	GOTO endError
ENDIF

GLOBAL nodeAxisCount
nodeAxisCount=NODE_COUNT(0)

IF nodeAxisCount<GAxisCount THEN
	ErrCode=101
	GOTO endError
ENDIF
IF nodeAxisCount>GAxisCount THEN
	ErrCode=102
	GOTO endError
ENDIF

DIM axisnum ' X,Y,Z,Z2,X2 axis
axisnum=6
FOR i=0 to nodeAxisCount-1 'GAxisCount-1
	AXIS_ADDRESS(axisnum)=i+1
	ATYPE(axisnum)=65
	IF axisnum<>8 OR axisnum<>10 THEN
		DRIVE_PROFILE(axisnum)=13
	ELSE
		DRIVE_PROFILE(axisnum)=5
	ENDIF
	
	IF axisnum = 6 OR axisnum = 7 THEN
		UNITS(axisnum)=XYPPU
	ELSEIF axisnum = 9 THEN
		UNITS(axisnum) = X2PPU
	ELSE
		UNITS(axisnum) = X2PPU
	ENDIF
	
	PRINT "AXIS DETECTED: AXIS"+axisnum
	axisnum=axisnum+1
NEXT

axisnum=0 'Y2 axis
FOR i=5 to 6
	AXIS_ADDRESS(axisnum)=i+1
	ATYPE(axisnum)=1
	UNITS(axisnum)=Y2PPU
	IF axisnum<>0 THEN
		INVERT_STEP(axisnum)=2
	ENDIF
	PRINT "AXIS DETECTED: AXIS"+axisnum
	axisnum=axisnum+1
NEXT

'INVERT_STEP(3)=2
FWD_IN(6)=10
FWD_IN(7)=13
FWD_IN(9) = 16
'FWD_IN(10) = 20
'FWD_IN(0)=16
FWD_IN(1)=19
'FWD_IN(2)=20

REV_IN(6)=11
REV_IN(7)=12
REV_IN(9)=17
'REV_IN(10) = 21
'REV_IN(0)=17
REV_IN(1)=18
'REV_IN(2)=21

FS_LIMIT(6)=375
FS_LIMIT(7)=2
FS_LIMIT(8)=5
RS_LIMIT(6)=-2
RS_LIMIT(7)=-630
RS_LIMIT(8)=-110

INVERT_IN(10, ON)
INVERT_IN(11, ON)
INVERT_IN(12, ON)
INVERT_IN(13, ON)
INVERT_IN(14, ON)
INVERT_IN(16, ON)
INVERT_IN(17, ON)
INVERT_IN(18, ON)
INVERT_IN(19, ON)
INVERT_IN(20, ON)
INVERT_IN(21, ON)

'HomeSens for GZ
'UNITS(8) = ZPPU
UNITS(8) = XYPPU
DATUM_IN(GZAxis)=14
DATUM_IN(GZ2Axis) = 21

SLOT_START(0)
IF RETURN=0 THEN 
	ErrCode=110
	PRINT "Ethercat bus failed."
	GOTO endError
ENDIF

axisnum=6
FOR i=0 to nodeAxisCount-1
	DRIVE_CONTROLWORD(axisnum)=128
	DELAY(10)
	DRIVE_CONTROLWORD(axisnum)=6
	delay(10)
	DRIVE_CONTROLWORD(axisnum)=15
	DELAY(10)
	axisnum=axisnum+1
NEXT

DATUM(0)
WDOG=1

'Conveyor
BASE(ConvAxis)
ATYPE=1
UNITS=CUNITS
INVERT_STEP(ConvAxis) = 2

'ConveyorWidth
BASE(ConvWdAxis)
ATYPE=1
UNITS=CWUNITS
ACCEL=CVWIDTH_SPEEDPROF(3)
DECEL=CVWIDTH_SPEEDPROF(2)
SPEED=CVWIDTH_SPEEDPROF(0)
CREEP=CVWIDTH_SPEEDPROF(0)

SysState=1

PRINT "INITSYSTEM ErrorCode: " + ErrCode 
PRINT "SysState: " + SysState
END

endError:
SysState = 3
PRINT "INITSYSTEM ErrorCode: " + ErrCode 
PRINT "SysState: " + SysState
END