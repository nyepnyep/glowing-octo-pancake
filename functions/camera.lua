--[[
    sets to camera to a specified position and rotation
    and returns it back to the player after a couple seconds

    (note that when decorating a part with custom camera you should decorate accordingly to the new vision)

    the first thing to fill in is the new position of the camera, fill this in @ posX, posY & posZ
    after that we add the position it should be looking at, fill this in @ lookAtX, lookAty & lookAtZ

    next comes camera roll, this is 0 in the given code, it's how much you want the camera to be spun
    e.g. 90 will flip the camera 90 degrees to the right
    
    the last thing is the cameras field of view
]]
setCameraMatrix (posX, posY, posZ lookAtX, lookAtY, lookAtZ, 0, 70)
setTimer (function()
    setCameraTarget (getLocalPlayer)
end, 2500, 1)


--[[
    change the 2500 to the time it should take for the camera to reset itself to the player
    (2500 = 2.5s)
]]