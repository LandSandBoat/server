-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ophelia
-- Type: ENM Quest Timer
-----------------------------------
require("scripts/globals/enm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

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
