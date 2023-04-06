-----------------------------------
-- Area: Windurst Woods
--  NPC: Istvan
-- Type: ENM Quest Timer
-- !pos 116.294 -6 -98.164 241
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
