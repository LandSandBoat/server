-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Boirie
-- !pos -389.378 -0.005 -491.435 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsEntranceTrigger(player, 5)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventFinish(player, csid, option, npc)
end

return entity
