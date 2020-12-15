--[[
    stores your velocity when entering a marker and outputs it to the chat,
    you can use this with everything related to any element,
    some other functions commonly used with:
        > get- & setElementRotation
        > get- & setElementPosition
        > get- & setElementAngularVelocity
]]

local x, y, z = getElementVelocity (vehicle)
outputChatBox ("setElementVelocity (vehicle, "..x..", "..y..", "..z..")")