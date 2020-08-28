fadeCamera(false, 0.5, 0, 0, 0) -- time, r, g, b	
setTimer (function()
    setElementPosition(vehicle, posX, posY, posZ)
    setElementRotation(vehicle, rotX, rotY, rotZ)
    setElementVelocity(vehicle, velX, velY, velZ)
    setVehicleTurnVelocity(vehicle, tVelX, tVelY, tVelZ)
    fadeCamera(gMe, true, 1)
end, 500, 1)