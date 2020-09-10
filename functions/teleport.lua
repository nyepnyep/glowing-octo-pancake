--[[ 
    please keep in mind that you don't instantly teleport, there is a slight delay on the teleport
    this is so that it happens whilst the screen is black by fadeCamera, just makes it smoother
    also, use the setElementVelocity to add velocity after exiting the teleport (more smoother)
]]

fadeCamera(false, 0.5, 0, 0, 0) -- time, r, g, b (0.5s to fade the camera)
setTimer (function()
    -- everything here is delayed by 0.5s (the 500 at "end, 500, 1")

    -- set the new position and rotation
    setElementPosition(vehicle, posX, posY, posZ)
    setElementRotation(vehicle, rotX, rotY, rotZ)

    -- add a speedboost to it
    setElementVelocity(vehicle, velX, velY, velZ)

    -- if you do a teleport with a jump after it you can use this to add a naturally looking spin to it (very sensetive)
    setVehicleTurnVelocity(vehicle, tVelX, tVelY, tVelZ)

    -- unfades the screen over the course of 1 second
    fadeCamera(gMe, true, 1)
end, 500, 1) -- when changing the 500, please change 0.5 @ fadeCamera (false, 0.5 ... ) accordingly