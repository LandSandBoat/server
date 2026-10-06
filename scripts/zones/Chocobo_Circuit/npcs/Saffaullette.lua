-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Saffaullette
-- !pos -250.670 -0.005 -491.350 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsEntranceTrigger(player, 4)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventFinish(player, csid, option, npc)
end

return entity
