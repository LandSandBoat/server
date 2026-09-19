-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Drahbah
-- Type: Appraiser
-- !pos -86 0 83 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.appraisal.appraiseItem(player, npc, trade, 500, 679)
end

entity.onTrigger = function(player, npc)
    player:startEvent(678, 500)
end

return entity
