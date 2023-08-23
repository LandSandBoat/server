-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Taby Canatahey
-- !pos -119.119 -4.106 -524.347 116
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.TABY_CANATAHEY_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
