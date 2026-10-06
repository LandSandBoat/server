-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Mulaitrand
-- !pos -389.406 -0.005 -468.903 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsEntranceTrigger(player, 3)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventFinish(player, csid, option, npc)
end

return entity
