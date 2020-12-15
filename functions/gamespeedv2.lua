--[[
    easeGameSpeed by dnlk

    it's the same as setGameSpeed but rather than instantly setting the gamespeed it does so over a short time to make the transition smoother
    (works great with teleports)

    don't be scared by how much code t here is, you only need it in the file ONCE,
    it introduces a new function called "easeGameSpeed", the usage is very simple

    GO TO THE BOTTOM OF THE FILE TO SEE WHAT YOU GOTTA DO
]]

--[[ ignore all of this here ]]
local ease = {}

function easeGameSpeed(targetSpeed, overTime, callback)
	ease.startedAt 		= 	getTickCount()
	ease.startSpeed		= 	getGameSpeed()
	ease.targetSpeed 	= 	math.round(targetSpeed, 4, "floor")
	ease.overTime 		= 	overTime
	ease.callback		=	(type(callback) == "function" or type(callback) == "nil") and (type(callback) == "function" and callback or nil) or nil
	ease.isActive 		= 	true
end

addEventHandler("onClientRender", root, function()
	if ease.isActive then
	    local progress = (getTickCount() - ease.startedAt) / ((ease.startedAt + ease.overTime) - ease.startedAt)
	    local currentSpeed = math.round(getGameSpeed(), 1, (ease.startSpeed > ease.targetSpeed and "ceil" or "floor"))

		local X, Y, Z = interpolateBetween(currentSpeed, 0.0, 0.0, ease.targetSpeed, 0.0, 0.0, progress, "InOutQuad")
		X = math.round(X, 4, (ease.startSpeed > ease.targetSpeed and "floor" or "ceil"))
		if ease.startSpeed > ease.targetSpeed and X <= ease.targetSpeed then
			X = math.round(X, 1, "ceil")
		elseif ease.startSpeed < ease.targetSpeed and X >= ease.targetSpeed then
			X = math.round(X, 1, "floor")
		end
		
		setGameSpeed(X)
		if X == ease.targetSpeed then
			ease.isActive = false
			if type(ease.callback) == "function" then
				ease.callback();
			end
		end
	end
end)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

--[[ stop ignoring from here
change easeGameSpeed (0.5, 1000) to change the gamespeed & slowdown time (ms)
                     ^^^^^^^^^^^  

change easeGameSpeed(1.0, 1000) to reset it, only change the 1000 to the time you want to transition back to take 
                          ^^^^
]]

easeGameSpeed (0.5, 1000)

setTimer(function()
    easeGameSpeed(1, 1000)
end, 5000, 1)