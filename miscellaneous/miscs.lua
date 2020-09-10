-- music (doesn't include the disabling as that's usually handled by servers nowadays)
playSound ("files/song.mp3", true)

-- disable the sun
setSunSize (0)

-- disable the rare occasion of birds flying in the sky
setBirdsEnabled (false)

-- remove fog, this can be handy with a lot of weathers that have a low default loading distance
setFarClipDistance (1000)

-- change the sky color to whatever you want (0-255 range)
setSkyGradient (topRed, topGreen, topBlue, botRed, botGreen, botBlue)

-- change the color of the water (0-255 range)
setWaterColor (0, 0, 0)