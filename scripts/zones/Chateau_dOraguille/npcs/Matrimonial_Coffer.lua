-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Matrimonial Coffer
-- !pos -7.777 0.000 3.013 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.matrimonialcoffer.startEvent(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.matrimonialcoffer.finishEvent(player, csid, option, npc)
end

return entity
