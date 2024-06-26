-----------------------------------
-- Area: Phanauet Channel
--  NPC: Eunirange
-- !pos 5.945 -3.75 13.612 1
-----------------------------------
local ID = zones[xi.zone.PHANAUET_CHANNEL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ARE_WE_THERE_YET)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
