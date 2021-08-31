-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Asrahd
-- Type: Imperial Gate Guard
-- !pos 0.011 -1 10.587 50
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.besieged.onTrigger(player, npc, 630)
end

entity.onEventUpdate = function(player, csid, option)
    xi.besieged.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.besieged.onEventFinish(player, csid, option)
end

return entity
