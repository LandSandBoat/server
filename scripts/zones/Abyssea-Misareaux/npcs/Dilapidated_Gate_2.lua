-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: Dilapidated Gate
-- 
-- !pos -259.55 -30.18 278.56
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local menu =
    {
        title = "Proceed through the gate?",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
        end,
        
        options =
        {
            {
                "Yes",
                function(playerArg)
                    player:injectActionPacket(player:getID(), 6, 600, 0, 0, 0, 0, 0)
		          
		            player:timer(2000, function(playerArg)
       	    	        player:setPos(-259.61, -30.07, 276.260, 53)
		            end)

		            player:timer(4000, function(playerArg)
       	    	        player:injectActionPacket(player:getID(), 6, 602, 0, 0, 0, 0, 0)
		            end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        
        onCancelled = function(playerArg)
        end,
    }
    player:customMenu(menu)
end


entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
