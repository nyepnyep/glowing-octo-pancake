--[[ 
    this goes at the top of the file either above or below all the markers (own preference)
    posX = position on X axis
    posY = position on Y axis
    posZ = position o Z axis
    rotX = X rotation
    rotY = Y rotation
    rotZ = Z rotation
]]
local object = createObject (ID, posX, posY, posZ, rotX, rotY, rotZ)


--[[ 
    and now for actually moving the object:
    object = the object
    time = time in miliseconds (1000 = 1s)
    newPosX = new position on the X axis
    newPosY = new position on the Y axis
    newPosZ = new position on the Z axis

    the value that goes into the rotation can be calculated by doing the following formula:
    new rotation = desired rotation - current rotation
    example: let's say I want X: 0, Y: 0 Z: 120 as my new rotation
    currently I have X: 54, Y: -48, Z 95
    to get these to the desired rotation I need to get X & Y to 0 and Z to 120
    X: 54 to 0 = -54
    Y: -48 to 0 = 48
    Z: 95 to 120 = 35

    so example usage:
    moveObject (object, 2500, 3000, 0, 1500, -54, 48, 35)

]]
moveObject (object, time, newPosX, newPosy, newPosZ, addRotX, addRotY, addRotZ)