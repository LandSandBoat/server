-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Heih Porhiaap
-- !pos -118.876 -4.088 -515.731 116
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.HEIH_PORHIAAP_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
