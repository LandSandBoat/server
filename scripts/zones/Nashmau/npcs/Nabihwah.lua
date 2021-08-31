-----------------------------------
-- Area: Nashmau
--  NPC: Nabihwah
-- Type: Imperial Gate Guard
-- !pos 9.988 -7 68.585 53
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.besieged.onTrigger(player, npc, 253)
end

entity.onEventUpdate = function(player, csid, option)
    xi.besieged.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.besieged.onEventFinish(player, csid, option)
end

return entity
