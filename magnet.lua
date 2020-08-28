-- [[ magnet ]]
local power = 0.008
					 
					 
local flyTolerance = 10

function magnetWheels()
    progress = (getTickCount() - tick)/17
    tick = getTickCount()

    local vehicle = getPedOccupiedVehicle(localPlayer)

    if vehicle then
        local x,y,z = getElementPosition(vehicle)
        local vx,vy,vz = getElementVelocity(vehicle)
        local underx,undery,underz = getPositionFromElementOffset(vehicle,0,0,-1)
        local rayx,rayy,rayz = getPositionFromElementOffset(vehicle,0,0,-3)
        local hit = processLineOfSight ( x, y, z, rayx,rayy,rayz, true,false )

    	setElementHealth(vehicle, 1000)
    	setVehicleGravity(vehicle, 0, 0, 0)
    	setElementVelocity(vehicle, (underx - x)*power*progress+vx, (undery - y)*power*progress+vy, (underz - z)*power*progress+vz)

    	if hit then
    		fTick = getTickCount()
    	elseif (getTickCount() - fTick) > flyTolerance*1000 then  
    	    blowVehicle(vehicle)
    	    stopMagnets()
    	end
    end
end
	
function getPositionFromElementOffset(element,offX,offY,offZ)

    local m = getElementMatrix(element)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    do
    	return x,y,z
    end
end

function onMarker (hitPlayer, matchingDimension)
    if hitPlayer == localPlayer and isPedInVehicle(hitPlayer) then
        local vehicle = getPedOccupiedVehicle(hitPlayer)
        local r,g,b,a = getMarkerColor(source)
        if r ~= 255 and g ~= 255 then return
        elseif r == 0 and g == 255 and b == 0 and a == 0 and not tick then
            tick = getTickCount()
            fTick = getTickCount()
            addEventHandler("onClientRender", root, magnetWheels)
        elseif r == 255 and g == 0 and b == 0 and a == 0 and tick then
            stopMagnets()
        end
    end
end
addEventHandler ( "onClientMarkerHit", root, onMarker)

function onWasted()
    local vehicle = getPedOccupiedVehicle(source)
    if vehicle then
        local gx,gy,gz = getVehicleGravity(vehicle)
        if gx == 0 and gy == 0 and gz == -1 then return end
        stopMagnets()
    end
end

addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), onWasted )

function stopMagnets()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    removeEventHandler("onClientRender", root, magnetWheels)
    setVehicleGravity(vehicle, 0, 0, -1)
    tick = nil
end