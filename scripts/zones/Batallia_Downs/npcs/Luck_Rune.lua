-----------------------------------
-- Area: Batallia Downs
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos -362.167 -12.199 157.158 105
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
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
