local marker = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- size 5, r: 85, g: 85, b: 85, a: 85

local gMe=getLocalPlayer()

function nyepnyep(hitPlayer)
    if hitPlayer~=gMe then return end
    vehicle=getPedOccupiedVehicle(hitPlayer)
        if source == marker then
            -- add scripts here
        end
    end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),nyepnyep)