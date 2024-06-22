STOP "RunGantry.bas"

BASE(GXAxis,GYAxis,GZAxis)
RAPIDSTOP(2)
RAPIDSTOP(3)

WAIT IDLE

GxyzStatus = 3


END

