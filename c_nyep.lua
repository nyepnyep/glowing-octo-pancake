-- Always work in this file, don't make more files for different things

local gMe=getLocalPlayer()

--[[ markers ]]
marker1 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a

--[[ functions ]]
function nyepnyep(hitPlayer)
    if hitPlayer~=gMe then return end
    vehicle=getPedOccupiedVehicle(hitPlayer)
    if source == marker1 then
        -- add script here
    end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),nyepnyep)
