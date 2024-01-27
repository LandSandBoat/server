-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Cavernous Maw
-- Teleports Players to Sauromugue_Champaign_S
-- !pos 369 8 -227 120
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
