--[[ predefined values ]]
local gMe=getLocalPlayer()

--[[ markers ]]
marker1 = createMarker (4761.70703125, 0, 5659.5961914063, "corona", 5, 85, 85, 85, 85)

--[[ functions ]]
function Lacia(hitPlayer)
    if hitPlayer~=gMe then return end
    vehicle=getPedOccupiedVehicle(hitPlayer)
    if source == marker1 then
        -- add script here
    end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),Lacia)
