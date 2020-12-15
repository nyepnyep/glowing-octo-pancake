--[[
    use to change to gravity of EVERYTHING, read this if you only want it on a specific vehicle: https://wiki.multitheftauto.com/wiki/SetVehicleGravity
    resets the gravity after 2500ms

    change "setGravity (-0.008)" to change the gravity
                        ^^^^^^

    change "end, 2500, 1)" to change the interval time
                 ^^^^
]]

setGravity (-0.008)
setTimer(function()
    resetGravity()
end, 2500, 1)