-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Cavernous Maw
-- !pos 369 8 -227 98
-- Teleports Players to Sauromugue_Champaign
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.maws.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.maws.onEventFinish(player, csid, option, npc)
end

return entity
