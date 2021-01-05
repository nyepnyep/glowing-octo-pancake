--[[
    Don't change anything about this file, just import it into the map.

    All this does is check if a player is currently reversing or not.


    HOW TO USE THIS:
    Just place a marker anywhere you want in editor and put the RGBA to 255, 0, 0, 0
    (
        R: 255
        G: 0
        B: 0
        A: 0
    )



    -- Written for Lumiverse & Force out Xtreme map fixing.
]]

function isVehicleReversing(theVehicle)
    local getMatrix = getElementMatrix (theVehicle)
    local getVelocity = Vector3 (getElementVelocity(theVehicle))
    local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3]) 
    if (getVectorDirection >= 0) then
        return false;
    end
    return true;
end
  
function onMarker (hitPlayer, matchingDimension)
    if hitPlayer == localPlayer and isPedInVehicle(hitPlayer) then
        local vehicle = getPedOccupiedVehicle(hitPlayer)
        local r,g,b,a = getMarkerColor(source)
        if r == 255 and g == 0 and b == 0 and a == 0 then
            if not isVehicleReversing (vehicle) then
                blowVehicle (vehicle)
            end
        end
    end
end
addEventHandler ( "onClientMarkerHit", root, onMarker)