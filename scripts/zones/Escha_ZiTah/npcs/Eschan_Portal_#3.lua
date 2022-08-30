-----------------------------------
-- Area: Escha - Zi'Tah Island (288)
--  NPC: Eschan Portal #1
-- !pos --344.275 1.659 -182.613 288
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
-----------------------------------
local entity = {}
-- Cost will end up being double, since onEventUpdate triggers twice
local warpCost = 25 

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local beads = player:getCurrency("escha_beads")
    player:startEvent(9100, 0, 2046820351, 288, 2, 0, beads, 50, 0)
	player:PrintToPlayer("WARNING: You are about to consume escha beads, not silt.", xi.msg.channel.SYSTEM)
end

entity.onEventUpdate = function(player, csid, option)
    local beads = player:getCurrency("escha_beads")
    if option > 0 then
	    player:setCurrency("escha_beads", beads - warpCost)
	end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
