-----------------------------------
-- Area: Selbina
--  NPC: Explorer Moogle
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

local eventId = 1135

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.teleport.explorerMoogleOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.teleport.explorerMoogleOnEventFinish(player, csid, option, eventId)
end

return entity
