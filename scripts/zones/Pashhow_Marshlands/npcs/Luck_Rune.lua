-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos 573.245 24.999 199.560 109
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
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
