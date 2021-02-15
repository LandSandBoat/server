-----------------------------------
-- Area: Port Jeuno
--  NPC: Gavin
-- !pos -15 8 44 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.GAVIN_DIALOG, tpz.ki.AIRSHIP_PASS_FOR_KAZHAM)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
