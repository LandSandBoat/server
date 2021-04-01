-----------------------------------
-- Area: Al Zahbi
--  NPC: Famatar
-- Type: Imperial Gate Guard
-- !pos -105.538 0.999 75.456 48
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.besieged.onTrigger(player, npc, 218)
end

entity.onEventUpdate = function(player, csid, option)
    xi.besieged.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.besieged.onEventFinish(player, csid, option)
end

return entity
