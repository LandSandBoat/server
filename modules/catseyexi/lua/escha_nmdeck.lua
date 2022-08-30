-----------------------------------
require("modules/module_utils")
require("scripts/zones/Escha_RuAun/Zone")
-----------------------------------
local m = Module:new("???_Ports")
m:setEnabled(true)

local mob =
{
    BYAKKO    = 17961559,
    GENBU     = 17961562,
    SEIRYU    = 17961565,
    SUZAKU    = 17961568,
    KIRIN     = 17961571,    
}

m:addOverride("xi.zones.Escha_RuAun.Zone.onInitialize", function(zone)
    -------------------------
	-- Port to GOD Balcony --
	-------------------------
    super(zone)

    local suzport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Suzaku Portal",
		look = 2492,
        x = -359.060,
        y = -40.105,
        z = -255.183,
        rotation = 28,
        widescan = 1,

        onTrigger = function(player, npc)
		    player:injectActionPacket(6, 600, 0, 0, 0)
		      
			player:timer(2000, function(playerArg)
       			player:setPos(-453.837, -71.552, -308.441, 102)
			end)

		    player:timer(2750, function(playerArg)
    		    player:injectActionPacket(6, 602, 0, 0, 0)
			end)
		end,
    })

    local byaport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Byakko Portal",
		look = 2492,
        x = -353.819,
        y = -40.105,
        z = 262.473,
        rotation = 28,

        onTrigger = function(player, npc)
	        player:injectActionPacket(6, 600, 0, 0, 0)

			player:timer(2000, function(playerArg)
			    player:setPos(-432.945, -71.552, 336.247, 156)
			end)	
			
		    player:timer(2750, function(playerArg)
    		    player:injectActionPacket(6, 602, 0, 0, 0)
			end)
		end,
    })

    local genport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Genbu Portal",
		look = 2492,
        x = 140.386,
        y = -40.147,
        z = 417.497,
        rotation = 28,

        onTrigger = function(player, npc)
	        player:injectActionPacket(6, 600, 0, 0, 0)

			player:timer(2000, function(playerArg)
			    player:setPos(185.649, -71.552, 515.620, 211)
			end)
			
		    player:timer(2750, function(playerArg)
    		    player:injectActionPacket(6, 602, 0, 0, 0)
			end)
		end,
    })

    local syrport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Seiyru Portal",
		look = 2492,
        x = 440.573,
        y = -40.106,
        z = -4.610,
        rotation = 28,

        onTrigger = function(player, npc)
	        player:injectActionPacket(6, 600, 0, 0, 0)
			
			player:timer(2000, function(playerArg)
			    player:setPos(548, -71, -17, 0)
			end)
			
		    player:timer(2750, function(playerArg)
    		    player:injectActionPacket(6, 602, 0, 0, 0)
			end)
		end,
    })
	
	-----------------------
	-- NPC's to pop NM's --
	-----------------------
    local suzport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Fire Beacon",
		look = 2824,
        x = -492.100,
        y = -70.020,
        z = -253.984,
        rotation = 0,

        onTrigger = function(player, npc)
            if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) or
		        player:hasKeyItem(xi.keyItem.SUZAKUS_BENEFACTION) then
		        player:delKeyItem(xi.keyItem.SUZAKUS_BENEFACTION)
		        player:PrintToPlayer("You can feel a thunderous force culminating from beneath you...", xi.msg.channel.NS_SAY)
                player:timer(3000, function(playerArg)
				    GetMobByID(17961568):setSpawn(-521.813, -70.220, -270.628, 239)
		            SpawnMob(17961568):updateClaim(player)
		        end)
            end
	    end,
    })

    local byaport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Light Beacon",
		look = 2824,
        x = -393.230,
        y = -70.020,
        z = 390.329,
        rotation = 0,

        onTrigger = function(player, npc)
            if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) or
		       player:hasKeyItem(xi.keyItem.BYAKKOS_PRIDE) then
		       player:delKeyItem(xi.keyItem.BYAKKOS_PRIDE)
		       player:PrintToPlayer("You can feel a thunderous force culminating from beneath you...", xi.msg.channel.NS_SAY)
                player:timer(3000, function(playerArg)
				    GetMobByID(mob.BYAKKO):setSpawn(-415.262, -70.280, 408.908, 26)
		            SpawnMob(mob.BYAKKO):updateClaim(player)
		        end)
            end
	    end,
    })

    local genport = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Water Beacon",
		look = 2824,
        x = 251.169,
        y = -70.020,
        z = 494.367,
        rotation = 0,

        onTrigger = function(player, npc)
            if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) or
		        player:hasKeyItem(xi.keyItem.GENBUS_HONOR) then
		        player:PrintToPlayer("You can feel a thunderous force culminating from beneath you...", xi.msg.channel.NS_SAY)
		        player:delKeyItem(xi.keyItem.GENBUS_HONOR)
                player:timer(3000, function(playerArg)
				    GetMobByID(mob.GENBU):setSpawn(261.906, -70.219, 526.206, 78)
		            SpawnMob(mob.GENBU):updateClaim(player)
		        end)
            end
	    end,
    })

    local syrpop = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Wind Beacon",
		look = 2824,
        x = 548.096,
        y = -70.020,
        z = -85.344,
        rotation = 0,

        onTrigger = function(player, npc)
            if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) or
		        player:hasKeyItem(xi.keyItem.SEIRYUS_NOBILITY) then
		        player:PrintToPlayer("You can feel a thunderous force culminating from beneath you...", xi.msg.channel.NS_SAY)
		        player:delKeyItem(xi.keyItem.SEIRYUS_NOBILITY)
                player:timer(3000, function(playerArg)
				    GetMobByID(mob.SEIRYU):setSpawn(578.687, -70.220, -87.668, 130)
		            SpawnMob(mob.SEIRYU):updateClaim(player)
		        end)
            end
	    end,
	})
	
	local kirpop = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Avatar Beacon",
		look = 2827,
        x = -1.216,
        y = -55.240,
        z = -632.844,
        rotation = 0,

        onTrigger = function(player, npc)
            if  player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) or
	    	    player:hasKeyItem(xi.keyItem.KIRINS_FERVOR) then
	    	    player:PrintToPlayer("You can feel a thunderous force culminating from beneath you...", xi.msg.channel.NS_SAY)
	    	    player:delKeyItem(xi.keyItem.KIRINS_FERVOR)
                player:timer(3000, function(playerArg)
				    GetMobByID(mob.KIRIN):setSpawn(-0.769, -54.040, -600.119, 67)
		            SpawnMob(mob.KIRIN):updateClaim(player)
		        end)
            end
	    end,
	})
	
end)

return m
