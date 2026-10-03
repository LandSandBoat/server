-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Malecharisant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onTrade(player, trade, npc)
end

return entity
