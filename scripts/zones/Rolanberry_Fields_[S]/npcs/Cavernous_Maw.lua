-----------------------------------
-- Area: Rolanberry Fields [S]
--  NPC: Cavernous Maw
-- !pos -198 8 360 91
-- Teleports Players to Rolanberry Fields
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
