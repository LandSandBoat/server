-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ophelia
-- Type: ENM Quest Timer
-- !pos -25 2 -94.6 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.enm.timerNpcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.enm.timerNpcOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.enm.timerNpcOnEventFinish(player, csid, option)
end

return entity
