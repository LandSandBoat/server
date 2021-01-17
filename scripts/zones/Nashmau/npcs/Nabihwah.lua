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
    tpz.besieged.onTrigger(player, npc, 253)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.besieged.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.besieged.onEventFinish(player, csid, option)
end

return entity
