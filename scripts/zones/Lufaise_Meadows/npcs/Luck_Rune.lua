-----------------------------------
-- Area: Lufaise Meadows
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos 276.507 1.917 -139.961 24
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
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
