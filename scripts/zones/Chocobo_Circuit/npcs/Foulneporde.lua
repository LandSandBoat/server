-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Foulneporde
-- !pos -250.715 -0.005 -469.532 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onStandsEntranceTrigger(player, 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onStandsEntranceEventFinish(player, csid, option, npc)
end

return entity
