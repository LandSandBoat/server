-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Lotte
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onTrade(player, trade, npc)
end

return entity
