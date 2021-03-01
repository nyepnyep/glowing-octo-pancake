-- Always work in this file, don't make more files

-- include in meta:    <script src="c_main.lua" type="client"></script>

local getMe=getLocalPlayer()

--[[ markers ]]
marker1 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a
marker2 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a
marker3 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a
marker4 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a
marker5 = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- posX, posY, posZ, "type", size, r, g, b, a

--[[ functions ]]
function mainEvents(hitPlayer)
    if hitPlayer~=getMe then return end
    vehicle=getPedOccupiedVehicle(hitPlayer)
    if source == marker1 then
        -- add script here
    end
    if source == marker2 then
        -- add script here
    end
    if source == marker3 then
        -- add script here
    end
    if source == marker4 then
        -- add script here
    end
    if source == marker5 then
        -- add script here
    end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),mainEvents)
