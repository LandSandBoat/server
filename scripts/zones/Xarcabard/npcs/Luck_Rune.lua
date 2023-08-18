-----------------------------------
-- Area: Xarcabard
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos 576.117 -0.164 -16.935 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
