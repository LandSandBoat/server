-----------------------------------
-- Area: Grauberg [S]
--  NPC: Harvesting Point
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.HARVESTING, 901)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.HARVESTING_IS_POSSIBLE_HERE, 1020)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
