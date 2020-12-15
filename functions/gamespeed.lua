--[[
    use to change the gamespeed upon hitting a marker and disabling it on a time interval
    currently on a 2500ms interval

    change "setGameSpeed (0.5)" to change the gamespeed
                         ^^^^^

    change "end, 2500, 1)" to change the interval time
                 ^^^^
]]

setGameSpeed (0.5)
setTimer(function()
    resetGameSpeed()
end, 2500, 1)