--[[
    a script that compares current player rotation to set rotation
    if it results true (player meets rotation condition), blows the player up
    if you want to invert this so that you can enter the rotation the player should have instead of shouldn't have
    change "if (rot...." to "if not (rot..."
]]
local rotX, rotY, rotZ = getElementRotation (vehicle)

--[[
    change rotX and rotY to whatever you want to check for, in the current scenario
    the player will be blown if the X rotation is below (<) 90 and the Y rotation is above (>) 180
]]
if (rotX < 90) and (rotY > 180) then
    blowVehicle (vehicle) -- kills the player
end