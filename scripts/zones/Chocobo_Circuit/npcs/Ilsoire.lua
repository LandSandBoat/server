-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Ilsoire
-- !pos -330.361 -0.005 -410.638 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsEntranceTrigger(player, 1)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventFinish(player, csid, option, npc)
end

return entity
