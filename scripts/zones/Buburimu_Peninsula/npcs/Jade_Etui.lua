-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Jade Etui
-- Involved in Brigand's Chart quest
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    return xi.brigandsChart.jadeEtuiOnTrigger(player, npc)
end

return entity
