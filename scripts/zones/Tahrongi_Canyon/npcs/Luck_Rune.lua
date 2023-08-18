-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos -54.755 7.647 -379.945 117
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
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
