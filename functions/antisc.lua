local rotX, rotY, rotZ = getElementRotation (vehicle)

-- change rotX/rotY to whichever rotations you wish to check and the 90 to what it should be above or below
if (rotX < 90) and (rotY > 90) then
    blowVehicle (vehicle)
end