-----------------------------------
-- Area: Qufim Island
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos -612.948 12.573 461.963 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
