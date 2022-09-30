---------------------------------------------------------------------------------------------------
-- func: !anchor [<set> <go> <where> <clear>]
-- desc: Used to warp to a predfined destination
---------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/zone")
-------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "ss"
}

local zone_list =
{
	26,  -- Tavnazian Safehold 
        32,  -- Sealion's Den
	48,  -- Al Zahbi
	50,  -- Aht Urhgan Whitegate
        53,  -- Nashmau
        80,  -- Southern San d'Oria [S]
        87,  -- Bastok Markets [S]
        94,  -- Windurst Waters [S]
	230, -- Southern San d'Oria
    	231, -- Northern San d'Oria
    	232, -- Port San d'Oria
    	233, -- Chateau d'Oraguille
	234, -- Bastok Mines
	235, -- Bastok Markets
	236, -- Port Bastok
	237, -- Metalworks
	238, -- Windurst Waters
    	239, -- Windurst Walls
    	240, -- Port Windurst
    	241, -- Windurst Woods
    	242, -- Heavens Tower
    	243, -- Ru'Lude Gardens
    	244, -- Upper Jeuno
    	245, -- Lower Jeuno
    	246, -- Port Jeuno
    	247, -- Rabao
    	248, -- Selbina
    	249, -- Mhaura
    	250, -- Kazham
    	251, -- Hall of the Gods
    	252, -- Norg
	256, -- Western Adoulin
	257, -- Eastern Adoulin
}

local zone_list_deny_set =
{
	71,  -- The Colosseum 

}

local function validZone(zone_list, id)
	for k,v in pairs(zone_list) do
		if v == id then
		return true
 		end
 	end
end

local function denyZone(zone_list_deny_set, id)
	for k,v in pairs(zone_list_deny_set) do
		if v == id then
		return true
 		end
 	end
end

-- invert xi.zone table
    local zoneNameByNum={}
    for k, v in pairs(xi.zone) do
        zoneNameByNum[v]=k
    end

function onTrigger(PC, Command, Sub)

    Command = Command or nil
    Sub = Sub or nil

    if not Command then
        PC:PrintToPlayer("Instructions", 29)
        PC:PrintToPlayer("!anchor help: Provides help with anchor system.", 29)
        return
    end
    
    Command = string.lower(Command)

    if Command == "help" then
        PC:PrintToPlayer("The sub-commands available for !anchor are as follows:", 29)
        PC:PrintToPlayer("!anchor set: Sets current location as anchor point.", 29)
        PC:PrintToPlayer("!anchor go: Send player to anchor point from safe areas.", 29)
        PC:PrintToPlayer("!anchor where: Displays current anchor point.", 29)
        PC:PrintToPlayer("!anchor clear: Clears current anchor point.", 29)

    elseif Command == "set" then
      	local pos = PC:getPos()
	local zone = PC:getZoneID()
        local current_time = os.time()
        local rem_set = 0

	if denyZone(zone_list_deny_set, zone) == true then
		PC:PrintToPlayer( string.format("This function is not valid in the current zone."), 14 )
        elseif (PC:getLocalVar("anchor_set_cooldown") > current_time) then
                rem_set = PC:getLocalVar("anchor_set_cooldown") - current_time
                PC:PrintToPlayer( string.format("Must wait for SET timer to expire in %i seconds.", rem_set), 14 )
	else
		PC:setAnimation(33)
		PC:PrintToPlayer("Setting anchor point...", 29)
		PC:timer(10000, function(PC)
    			PC:setAnimation(0)
        	    	PC:setCharVar("anchor_x",pos.x)
		    	PC:setCharVar("anchor_y",pos.y)
			PC:setCharVar("anchor_z",pos.z)
			PC:setCharVar("anchor_rot",pos.rot)
			PC:setCharVar("anchor_zone",zone)   
                        PC:setCharVar("anchor_time", os.time() + 300)
                        PC:setLocalVar("anchor_set_cooldown", os.time() + 600)
			PC:PrintToPlayer("Anchor point set.", 29)
			end)
	end

    elseif Command == "go" then
 	local x = PC:getCharVar("anchor_x")
    	local y = PC:getCharVar("anchor_y")
    	local z = PC:getCharVar("anchor_z")
    	local rot = PC:getCharVar("anchor_rot")
    	local zone = PC:getCharVar("anchor_zone")
        local time = PC:getCharVar("anchor_time")
	local pzone = PC:getZoneID()
        local remaining = 0

		
	if (zone == 0) then
		PC:PrintToPlayer( string.format("No anchor point set."), 14 )
        elseif  time > os.time() then
                remaining = time - os.time()
                PC:PrintToPlayer( string.format("Must wait for GO timer to expire in %i seconds.", remaining), 14 )
        elseif (validZone(zone_list, pzone) == true) then
		PC:PrintToPlayer( string.format("Sending %s to %s zone...", PC:getName(), zoneNameByNum[zone]), 29)
        	PC:setAnimation(33)
 		PC:timer(10000, function(PC)
			PC:setPos(x, y, z, rot, zone)
			end)
	else
		PC:PrintToPlayer( string.format("Anchor system is not available in the current zone."), 14 )
	end

    elseif Command == "where" then
        local x = PC:getCharVar("anchor_x")
    	local y = PC:getCharVar("anchor_y")
    	local z = PC:getCharVar("anchor_z")
    	local rot = PC:getCharVar("anchor_rot")
    	local zone = PC:getCharVar("anchor_zone")

	PC:PrintToPlayer( string.format("x: %i y:%i, z: %i, rot: %i, zone: %s", x, y, z, rot, zoneNameByNum[zone]), 29 )

    elseif Command == "clear" then

        PC:setCharVar("anchor_x",0)
	PC:setCharVar("anchor_y",0)
	PC:setCharVar("anchor_z",0)
	PC:setCharVar("anchor_rot",0)
	PC:setCharVar("anchor_zone",0)  
        PC:setCharVar("anchor_time",0)      
        PC:PrintToPlayer("Anchor point cleared.", 29)
    end
end