-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Cavernous Maw
-- !pos 418 25 27 109
-- Teleports Players to Pashhow Marshlands [S]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.maws.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.maws.onEventFinish(player, csid, option, npc)
end

return entity
