IF EMO_ACTIVE=1 THEN
	ErrCode=10
	PRINT "EMO Active"
	goto endHome
ENDIF
RUN GXYZHome
DELAY(100)
WAIT UNTIL IDLE(6)=-1 AND IDLE(7)=-1 AND IDLE(8)=-1
RUN GX2Y2Z2Home


PRINT "Home Succes"
GStatus = 1
GOTO endHome
endHome:
PRINT "HOME Error Code" +ErrCode
PRINT "Status" +GStatus


