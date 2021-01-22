-----------------------------------
-- Area: Al Zahbi
--  NPC: Falzuuk
-- Type: Imperial Gate Guard
-- !pos -60.486 0.999 105.397 48
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.besieged.onTrigger(player, npc, 216)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.besieged.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.besieged.onEventFinish(player, csid, option)
end

return entity
