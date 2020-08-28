antisc = createMarker (0, 0, 0, "corona", 5, 85, 85, 85, 85) -- size 5, r: 85, g: 85, b: 85, a: 85

if source == antisc then
    local x, y, z = getElementRotation (vehicle)
    if (x < 150) and (x > 270) then
        blowVehicle (vehicle)
        outputChatBox (x)
    end
end