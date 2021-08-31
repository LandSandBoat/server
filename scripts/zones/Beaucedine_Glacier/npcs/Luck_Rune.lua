-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos 70.736 -37.778 149.624 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
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
