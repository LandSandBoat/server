-----------------------------------
-- Area: Nashmau
--  NPC: Memeroon
-- Type: Appraiser
-- !pos -26 0 -40 53
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.appraisal.appraiseItem(player, npc, trade, 500, 273)
end

entity.onTrigger = function(player, npc)
    player:startEvent(272, 500)
end

return entity
