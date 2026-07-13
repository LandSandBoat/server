-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- !pos -39 -3 69 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(522)
end

return entity
