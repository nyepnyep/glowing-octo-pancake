--[[ sky & water ]]
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		outputDebugString('/sSkyAlt to switch the effect')
		triggerEvent( "switchSkyAlt", resourceRoot, true )
		addCommandHandler( "sSkyAlt",
			function()
				triggerEvent( "switchSkyAlt", resourceRoot, not salEffectEnabled )
			end
		)
	end
)

function switchSkyAlt( sbaOn )
	outputDebugString( "switchSkyAlt: " .. tostring(sbaOn) )
	if sbaOn then
		startShaderResource()
	else
		stopShaderResource()
	end
end

addEvent( "switchSkyAlt", true )
addEventHandler( "switchSkyAlt", resourceRoot, switchSkyAlt )
addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)

--

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		if getVersion ().sortable < "1.1.0" then
			-- outputChatBox( "Resource is not compatible with this client." )
			return
		end

		local myShader, tec = dxCreateShader ( "files/water.fx" )

		if not myShader then
			-- outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			-- outputChatBox( "Using technique " .. tec )

			local textureVol = dxCreateTexture ( "images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "microflakeNMapVol_Tex", textureVol );
			dxSetShaderValue ( myShader, "showroomMapCube_Tex", textureCube );

			engineApplyShaderToWorldTexture ( myShader, "waterclear256" )

			setTimer(	function()
							if myShader then
								local r,g,b,a = getWaterColor()
								dxSetShaderValue ( myShader, "gWaterColor", r/255, g/255, b/255, a/255 );
							end
						end
						,100,0 )
		end
	end
)

--

local sphereObjScale=100
local sphereShadScale={1,1,0.9}
local makeAngular=true

local sphereTexScale={1,1,1}
local FadeEffect = true 
local SkyVis = 0.5

local ColorAdd=-0.15
local ColorPow=2
local shadCloudsTexDisabled=false
local modelID=15057
setCloudsEnabled(false)

local skydome_shader = nil
local null_shader = nil
local skydome_texture = nil
local  getLastTick,getLastTock = 0,0

function startShaderResource()
    if salEffectEnabled then return end
    skydome_shader = dxCreateShader ( "files/shaders/shader_skydome.fx",0,0,true,"object" )
    null_shader = dxCreateShader ( "files/shaders/shader_null.fx" )
    skydome_texture=dxCreateTexture("files/textures/skydome.jpg")
        if not skydome_shader or not null_shader or not skydome_texture then 
--          outputChatBox('Could not start Skybox alternative !',255,0,0)
        return 
        else
--          outputConsole('Shader skybox alternative v0.45 has started.')
    end

    setCloudsEnabled(false)
    dxSetShaderValue ( skydome_shader, "gTEX", skydome_texture )
    dxSetShaderValue ( skydome_shader, "gAlpha", 1 )
    dxSetShaderValue ( skydome_shader, "makeAngular", makeAngular )
    dxSetShaderValue ( skydome_shader, "gObjScale", sphereShadScale )
    dxSetShaderValue ( skydome_shader, "gTexScale",sphereTexScale )
    dxSetShaderValue ( skydome_shader, "gFadeEffect", FadeEffect )
    dxSetShaderValue ( skydome_shader, "gSkyVis", SkyVis )
    dxSetShaderValue ( skydome_shader, "gColorAdd", ColorAdd )
    dxSetShaderValue ( skydome_shader, "gColorPow", ColorPow )  
    engineApplyShaderToWorldTexture ( skydome_shader, "skybox_tex" ) 
    if shadCloudsTexDisabled then engineApplyShaderToWorldTexture ( null_shader, "cloudmasked*" ) end
    txd_skybox = engineLoadTXD('files/models/skybox_model.txd')
    engineImportTXD(txd_skybox, modelID)
    dff_skybox = engineLoadDFF('files/models/skybox_model.dff', modelID)
    engineReplaceModel(dff_skybox, modelID)  

    local cam_x,cam_y,cam_z = getElementPosition(getLocalPlayer())
    skyBoxBoxa = createObject ( modelID, cam_x, cam_y, cam_z, 0, 0, 0, true )
    setObjectScale(skyBoxBoxa,sphereObjScale) 
    setElementAlpha(skyBoxBoxa,1)
    addEventHandler ( "onClientHUDRender", getRootElement (), renderSphere )
    addEventHandler ( "onClientHUDRender", getRootElement (), renderTime )
    applyWeatherInfluence()
    salEffectEnabled = true
end

function stopShaderResource()
    if not salEffectEnabled then return end
    removeEventHandler ( "onClientHUDRender", getRootElement (), renderSphere )
    removeEventHandler ( "onClientHUDRender", getRootElement (), renderTime )
    if null_shader then 
        engineRemoveShaderFromWorldTexture ( null_shader, "cloudmasked*" ) 
        destroyElement(null_shader)
        null_shader=nil
    end
    engineRemoveShaderFromWorldTexture ( skydome_shader, "skybox_tex" )
    destroyElement(skyBoxBoxa)
    destroyElement(skydome_shader)
    destroyElement(skydome_texture)
    skyBoxBoxa=nil
    skydome_shader=nil
    skydome_texture=false
    salEffectEnabled = false
end

lastWeather=0
function renderSphere()
    if getTickCount ( ) - getLastTock < 2  then return end
    local cam_x, cam_y, cam_z, lx, ly, lz = getCameraMatrix()
    if cam_z<=200 then setElementPosition ( skyBoxBoxa, cam_x, cam_y, 80,false ) 
        else setElementPosition ( skyBoxBoxa, cam_x, cam_y, 80+cam_z-200,false )
    end
    local r1, g1, b1, r2, g2, b2 = getSkyGradient()
    local skyBott = {r2/255, g2/255, b2/255, 1}	
    dxSetShaderValue ( skydome_shader, "gSkyBott", skyBott )
    if getWeather()~=lastWeather then
        applyWeatherInfluence()
    end
    lastWeather=getWeather()
    getLastTock = getTickCount ()
end

function renderTime()

    local hour, minute = getTime ( )
    if getTickCount ( ) - getLastTick < 100  then return end
    if not skydome_shader then return end
    if hour >= 20 then
        local dusk_aspect = ((hour-20)*60+minute)/240
        dusk_aspect = 1-dusk_aspect
        dxSetShaderValue ( skydome_shader, "gAlpha", dusk_aspect)
    end 	
    if hour <= 2 then
     dxSetShaderValue ( skydome_shader, "gAlpha", 0)
    end 	
    if hour > 2 and hour <= 6 then
        local dawn_aspect = ((hour-3)*60+minute)/180
        dawn_aspect = dawn_aspect
        dxSetShaderValue ( skydome_shader, "gAlpha", dawn_aspect)
    end 	
    if hour > 6 and hour < 20 then
        dxSetShaderValue ( skydome_shader, "gAlpha", 1)
    end 
    getLastTick = getTickCount ()
end


function applyWeatherInfluence()
	setSunSize (0)
	setSunColor(0, 0, 0, 0, 0, 0)
end