--[[ infinite nos ]]
addEventHandler ( "onClientRender", root,
function ( )
    local vehicle = getPedOccupiedVehicle ( localPlayer )
    if ( isElement ( vehicle ) and getElementType ( vehicle ) == "vehicle" ) then
        if ( not getVehicleUpgradeOnSlot ( vehicle, 8 ) ) then 
            addVehicleUpgrade ( vehicle, 1010 ) 
            setVehicleNitroActivated ( vehicle, true )
        else
            setVehicleNitroLevel ( vehicle, 1.0 )
        end
    end
end
)