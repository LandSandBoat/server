-----------------------------------
-- Area: Mhaura
--  NPC: Explorer Moogle
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

local eventId = 334

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.teleport.explorerMoogleOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.teleport.explorerMoogleOnEventFinish(player, csid, option, eventId)
end

return entity
